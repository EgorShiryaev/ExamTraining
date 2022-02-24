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

  String dateText = 'Выбрать дату экзамену';
  String timeText = 'Выбрать время';

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
    setState(() => examTickets = newTickets);
  }

  @override
  void dispose() {
    titleController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  _onSave(context) {
    if (date != null && time != null) {
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
        tickets: [
          ExamTicket(
            question: 'Вопрос',
            answer: 'Ответ',
          ),
        ],
      );
      exam.reference = widget.exam?.reference;
      widget.onSave(exam);
      Navigator.pop(context);
    }
  }
}
