import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../../../data/models/_models.dart';
import '../../components/_components.dart';

class CreateTaskScreen extends StatefulWidget {
  final Function(Task task) onSave;
  final Task? task;

  const CreateTaskScreen({
    Key? key,
    required this.onSave,
    this.task,
  }) : super(key: key);

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime? date;
  TimeOfDay? time;
  Importance selectedImportance = Importance.low;
  List<Subtask> subtasks = [];

  bool isSaved = false;
  bool dontSaveExam = false;

  String dateText = 'Выбрать дату задачи';
  String timeText = 'Выбрать время задачи';

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    if (widget.task != null) {
      titleController.text = widget.task!.title;
      descriptionController.text = widget.task!.description;
      date = widget.task!.dateTime.toDate();
      dateText = DateFormat.yMMMMd('ru').format(widget.task!.dateTime.toDate());
      time = TimeOfDay(
        hour: widget.task!.dateTime.toDate().hour,
        minute: widget.task!.dateTime.toDate().minute,
      );
      timeText = DateFormat.Hm('ru').format(
        DateTime(
          2022,
          1,
          1,
          widget.task!.dateTime.toDate().hour,
          widget.task!.dateTime.toDate().minute,
        ),
      );
      selectedImportance = widget.task!.importance;
      subtasks.addAll(widget.task!.subtasks);
    }
  }

  @override
  void dispose() async {
    titleController.dispose();
    descriptionController.dispose();
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
          physics: const ClampingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(10),
          children: [
            CustomTextField(
              controller: titleController,
              label: 'Название задачи',
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
              controller: descriptionController,
              label: 'Описание задачи',
              maxLines: 3,
            ),
            ImportanceSelectView(
              selectedImportance: selectedImportance,
              setImportance: _selectImportance,
            ),
            SubtasksView(
              subtasks: subtasks,
              add: addSubtask,
              delete: deleteSubtask,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              height: 60,
              child: CustomRoundedButton(
                onTap: _onSave,
                text: 'Сохранить',
              ),
            ),
          ],
        ),
      ),
    );
  }

  addSubtask(String title) {
    subtasks.add(Subtask(title: title, completed: false));
    setState(() {});
  }

  deleteSubtask(String title) {
    subtasks.removeWhere((element) => element.title == title);
    setState(() {});
  }

  bool _checkNeedSave() {
    if (widget.task == null) {
      if (titleController.text.isNotEmpty ||
          descriptionController.text.isNotEmpty ||
          date != null ||
          time != null ||
          selectedImportance != Importance.low ||
          subtasks.isNotEmpty) {
        return true;
      }
      return false;
    } else {
      if (titleController.text != widget.task!.title ||
          descriptionController.text != widget.task!.description ||
          date! != widget.task!.dateTime.toDate() ||
          selectedImportance != widget.task!.importance) {
        return true;
      }

      final dateTimeInDate = widget.task!.dateTime.toDate();
      if (time!.hour != dateTimeInDate.hour ||
          time!.minute != dateTimeInDate.minute) {
        return true;
      }

      if (subtasks.length != widget.task!.subtasks.length) {
        return true;
      }
      bool subtasksIsChanged = false;
      final startSubTasks = widget.task!.subtasks;
      for (var i = 0; i < subtasks.length; i++) {
        try {
          if (subtasks[i].title != startSubTasks[i].title) {
            subtasksIsChanged = true;
          }
        } catch (e) {
          subtasksIsChanged = true;
        }
      }
      return subtasksIsChanged;
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
      final task = Task(
        completed: widget.task?.completed ?? false,
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
        description: descriptionController.text,
        importance: selectedImportance,
        subtasks: subtasks,
      );
      task.reference = widget.task?.reference;
      task.userId = widget.task?.userId ?? '';
      widget.onSave(task);
      setState(() => isSaved = true);
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
      cancelText: 'Отмена',
      confirmText: 'Готово',
      helpText: 'Выберите дату',
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
      cancelText: 'Отмена',
      confirmText: 'Готово',
      helpText: 'Выберите время',
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

  // _setExamTickets(List<ExamTicket> newTickets) {
  //   setState(() => subtasks = newTickets);
  // }

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
        descriptionController.text.isNotEmpty &&
        date != null &&
        time != null;
  }

  _onWarning() {
    List<String> errors = [];
    if (titleController.text.isEmpty) {
      errors.add('"Название задачи"');
    }
    if (descriptionController.text.isEmpty) {
      errors.add('"Описание задачи"');
    }
    if (date == null) {
      errors.add('"Дата задачи"');
    }
    if (time == null) {
      errors.add('"Время задачи"');
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
