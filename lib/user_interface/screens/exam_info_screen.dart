import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../../data/models/_models.dart';
import '../components/_components.dart';

class ExamInfoScreen extends StatefulWidget {
  final Exam? exam;
  final Function(Exam ex) onSave;

  const ExamInfoScreen({
    Key? key,
    required this.onSave,
    this.exam,
  }) : super(key: key);

  @override
  State<ExamInfoScreen> createState() => _ExamInfoScreenState();
}

class _ExamInfoScreenState extends State<ExamInfoScreen> {
  final titleController = TextEditingController();
  final locationController = TextEditingController();
  DateTime? date;
  TimeOfDay? time;
  Importance selectedImportance = Importance.low;
  List<ExamTicket> examTickets = [];

  bool isSaved = false;
  bool dontSaveExam = false;

  String dateText = 'Выбрать дату экзамену';
  String timeText = 'Выбрать время экзамена';

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    if (widget.exam != null) {
      titleController.text = widget.exam!.title;
      locationController.text = widget.exam!.location;
      date = widget.exam!.dateTime.toDate();
      dateText = DateFormat.yMMMMd('ru').format(widget.exam!.dateTime.toDate());
      time = TimeOfDay(
        hour: widget.exam!.dateTime.toDate().hour,
        minute: widget.exam!.dateTime.toDate().minute,
      );
      timeText = DateFormat.Hm('ru').format(
        DateTime(
          2022,
          1,
          1,
          widget.exam!.dateTime.toDate().hour,
          widget.exam!.dateTime.toDate().minute,
        ),
      );
      selectedImportance = widget.exam!.importance;
      examTickets.addAll(widget.exam!.tickets);
    }
  }

  @override
  void dispose() async {
    titleController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ExamTraining'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(10),
          physics: const ClampingScrollPhysics(),
          children: [
            CustomTextField(
              controller: titleController,
              label: 'Название экзамена',
            ),
            OutlinedButtonWithIcon(
              icon: Icons.today_rounded,
              text: dateText,
              onTap: _selectDate,
            ),
            OutlinedButtonWithIcon(
              icon: Icons.schedule_rounded,
              text: timeText,
              onTap: _selectTime,
            ),
            CustomTextField(
              controller: locationController,
              label: 'Место экзамена',
            ),
            ImportanceSelectView(
              selectedImportance: selectedImportance,
              setImportance: _selectImportance,
            ),
            ExamTicketsView(
              examTickets: examTickets,
              setTickets: _setExamTickets,
            ),
            const SizedBox(height: 85),
          ],
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          height: 60,
          child: CustomRoundedButton(
            onTap: _onSave,
            text: 'Сохранить',
          ),
        ),
      ),
    );
  }

  bool _checkNeedSave() {
    if (widget.exam == null) {
      if (titleController.text.isNotEmpty ||
          locationController.text.isNotEmpty ||
          date != null ||
          time != null ||
          selectedImportance != Importance.low ||
          examTickets.isNotEmpty) {
        return true;
      }
      return false;
    } else {
      if (titleController.text != widget.exam!.title ||
          locationController.text != widget.exam!.location ||
          date! != widget.exam!.dateTime.toDate() ||
          selectedImportance != widget.exam!.importance) {
        return true;
      }

      final dateTimeInDate = widget.exam!.dateTime.toDate();
      if (time!.hour != dateTimeInDate.hour ||
          time!.minute != dateTimeInDate.minute) {
        return true;
      }

      if (examTickets.length != widget.exam!.tickets.length) {
        return true;
      }
      bool ticketsIsChanged = false;
      final startExamTickets = widget.exam!.tickets;
      for (var i = 0; i < examTickets.length; i++) {
        try {
          if (examTickets[i].answer != startExamTickets[i].answer ||
              examTickets[i].question != startExamTickets[i].question) {
            ticketsIsChanged = true;
          }
        } catch (e) {
          ticketsIsChanged = true;
        }
      }
      return ticketsIsChanged;
    }
  }

  Future<bool?> showWarning(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: 'Есть несохраненные данные. Сохранить?',
        actionTitle: 'Да',
        cancelTitle: 'Нет',
        actionFunction: () {
          Navigator.pop(context);
          _onSave(context);
        },
        cancelFunction: () {
          setState(() => dontSaveExam = true);
          Navigator.pop(context);
        },
        actionColor: Colors.blue,
        cancelColor: Colors.red,
      ),
    );
  }

  _onSave(context) {
    if (_validate()) {
      final exam = Exam(
        title: titleController.text,
        dateTime: Timestamp.fromDate(
          DateTime(
            date!.year,
            date!.month,
            date!.day,
            time!.hour,
            time!.minute,
          ),
        ),
        location: locationController.text,
        importance: selectedImportance,
        tickets: examTickets,
      );
      exam.reference = widget.exam?.reference;
      widget.onSave(exam);
      setState(() {
        isSaved = true;
      });
      Navigator.pop(context);
    } else {
      _onWarning();
    }
  }

  _selectDate() async {
    final now = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date == null ? now : date!,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365)),
    );
    if (newDate != null) {
      setState(() {
        date = newDate;
        dateText = DateFormat.yMMMMd('ru').format(newDate);
      });
    }
  }

  _selectTime() async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? const TimeOfDay(hour: 12, minute: 0),
    );
    if (newTime != null) {
      setState(() {
        time = newTime;
        timeText = DateFormat.Hm('ru').format(
          DateTime(2022, 1, 1, newTime.hour, newTime.minute),
        );
      });
    }
  }

  _selectImportance(Importance newImportance) {
    setState(() => selectedImportance = newImportance);
  }

  _setExamTickets(List<ExamTicket> newTickets) {
    log(newTickets.map((e) => e.toJson()).toString());
    setState(() => examTickets = newTickets);
  }

  Future<bool> _onWillPop() async {
    if (_checkNeedSave()) {
      if (!isSaved) {
        await showWarning(context);
        if (dontSaveExam) {
          return true;
        }
      }
      return isSaved;
    }
    return true;
  }

  bool _validate() {
    return titleController.text.isNotEmpty &&
        locationController.text.isNotEmpty &&
        date != null &&
        time != null &&
        examTickets.isNotEmpty;
  }

  _onWarning() {
    List<String> errors = [];
    if (titleController.text.isEmpty) {
      errors.add('"Название экзамена"');
    }
    if (locationController.text.isEmpty) {
      errors.add('"Место экзамена"');
    }
    if (date == null) {
      errors.add('"Дата экзамена"');
    }
    if (time == null) {
      errors.add('"Время экзамена"');
    }
    if (examTickets.isEmpty) {
      errors.add('"Билеты"');
    }

    if (errors.isNotEmpty) {
      final error = errors.length == 1
          ? 'Поле ${errors.first} должно быть заполнено'
          : 'Поле ${errors.join(', ')} должны быть заполнены';
      showDialog(
        context: context,
        builder: (_) => CustomAlertDialog(
          title: error,
          actionTitle: 'ОК',
          actionFunction: () => Navigator.pop(context),
          actionColor: Colors.blue,
          isOneButton: true,
        ),
      );
    }
  }
}
