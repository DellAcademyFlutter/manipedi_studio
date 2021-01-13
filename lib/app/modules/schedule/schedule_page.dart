import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/data/schedule_dao.dart';
import 'package:manipedi_studio/app/modules/schedule/schedule_controller.dart';
import 'components/calendar_ui.dart';

class SchedulePage extends StatefulWidget {

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final scheduleDao = Modular.get<ScheduleDao>();
  final scheduleController = Modular.get<ScheduleController>();

  @override
  void initState() {
    super.initState();
    //Inicializa os schedules do Banco
    scheduleController.initializeSchedules();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        CalendarWidget(),
      ],
    ));
  }
}
