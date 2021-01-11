import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/app_controller.dart';
import 'package:manipedi_studio/app/modules/schedule/pages/schedule_register.dart';

import '../schedule_controller.dart';

class ScheduleWidget extends StatefulWidget {
  ScheduleWidget({this.index});
  final int index;

  @override
  _ScheduleWidgetState createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  final appController = Modular.get<AppController>();
  final scheduleController = Modular.get<ScheduleController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Agendamento ${appController.schedules[widget.index].time}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Icon(
                Icons.web_rounded,
                size: 60,
                color: Colors.pinkAccent,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.green),
                      //TODO: PASSAR O CLIENTE AQUI
                      //Text(appController.customers[widget.index].name),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.auto_awesome),
                      Text('Serviços: TODO'),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => setState(() {
                           //TODO: PASSAR O CLIENTE AQUI
                            Navigator.pushNamed(
                              context,
                              ScheduleRegister.routeName,
                              arguments: ScheduleRegisterArguments(
                                  schedule:
                                      appController.schedules[widget.index]),
                            );
                          })),
                  IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        //appController.removeScheduling();
                      }),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
