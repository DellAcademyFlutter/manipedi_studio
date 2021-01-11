import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/modules/schedule/pages/schedule_register.dart';

import '../schedule_controller.dart';

class DailySchedules extends StatefulWidget {
  static const routeName = "/dailySchedule";

  @override
  _DailySchedulesState createState() => _DailySchedulesState();
}

class _DailySchedulesState extends State<DailySchedules> {
  final scheduleController = Modular.get<ScheduleController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text("Dia: ${scheduleController.day}/${scheduleController.month}"
                  "/${scheduleController.year}"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          tooltip: "Adicinar um agendamento",
          onPressed: () => Navigator.pushNamed(
            context,
            ScheduleRegister.routeName,
            arguments: ScheduleRegisterArguments(schedule: null),
          ),
        ),
        body: Center(child: Container(child: Text('Olá Página!'))));
  }
}
