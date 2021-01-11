import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/modules/schedule/components/schedule_widget.dart';
import 'package:manipedi_studio/app/modules/schedule/pages/schedule_register.dart';

import '../../../app_controller.dart';
import '../schedule_controller.dart';

class DailySchedules extends StatefulWidget {
  static const routeName = "/dailySchedule";

  @override
  _DailySchedulesState createState() => _DailySchedulesState();
}

class _DailySchedulesState extends State<DailySchedules> {
  final appController = Modular.get<AppController>();
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
        body: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: 200,
                child: Consumer<AppController>(builder: (context, value) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: appController.schedules.length,
                    itemBuilder: (BuildContext context, int index) {
                      final daily = appController.schedules[index].date;
                      if(scheduleController.selectedDay.toString() == daily){
                        return ScheduleWidget(
                          index: index,
                        );
                      }
                      else{
                        return SizedBox.shrink();
                      }
                    }
                  );
                }),
              ),
            ),
          ],
        )
    );
  }
}
