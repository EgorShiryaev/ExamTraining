import 'package:exam_training/components/custom_rounded_button.dart';
import 'package:exam_training/components/custom_text_field.dart';
import 'package:exam_training/components/exam_info_screen/exam_tickets_view.dart';
import 'package:exam_training/components/exam_info_screen/importance_select_view.dart';
import 'package:exam_training/components/outlined_button_with_icon.dart';
import 'package:exam_training/models/exam_ticket.dart';
import 'package:exam_training/models/importance.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class ExamInfoScreen extends StatefulWidget {
  const ExamInfoScreen({Key? key}) : super(key: key);

  @override
  State<ExamInfoScreen> createState() => _ExamInfoScreenState();
}

class _ExamInfoScreenState extends State<ExamInfoScreen> {
  final titleController = TextEditingController();
  DateTime? date;
  TimeOfDay? time;
  final locationController = TextEditingController();
  Importance selectedImportance = Importance.high;
  List<ExamTicket> examTickets = [];

  String dateText = 'Выбрать дату экзамену';
  String timeText = 'Выбрать время';

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  _selectDate() async {
    final now = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date == null ? now : date!,
      firstDate: now.subtract(const Duration(days: 7)),
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
      initialTime: const TimeOfDay(hour: 12, minute: 0),
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

  _saveExam(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
        // physics: const ClampingScrollPhysics(),
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
          onTap: _saveExam,
          text: 'Сохранить',
        ),
      ),
    );
  }
}
