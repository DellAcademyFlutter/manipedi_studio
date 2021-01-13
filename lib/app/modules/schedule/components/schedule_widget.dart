import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:manipedi_studio/app/app_controller.dart';
import 'package:manipedi_studio/app/modules/schedule/pages/schedule_register.dart';

import 'package:manipedi_studio/app/modules/schedule/schedule_controller.dart';

class ScheduleWidget extends StatefulWidget {
  ScheduleWidget({this.index});
  final int index;

  @override
  _ScheduleWidgetState createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  final appController = Modular.get<AppController>();
  final scheduleController = Modular.get<ScheduleController>();
  List<int> currentSchedulingJobs = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Carrega a lista de jobs dos clientes do banco, armazenando em [currentSchedulingJobs]
    scheduleController.initializeScheduleJobs(
        appController.schedules[widget.index].id,
        appController.schedules[widget.index].idCustomer,
        currentSchedulingJobs);

    return Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.20,
        child: Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          decoration: myBoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.web_rounded,
                    color: Colors.pinkAccent,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Agendamento ${appController.schedules[widget.index].time}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.person, color: Colors.green),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Cliente: '),
                  SizedBox(
                    width: 5,
                  ),
                  Text(appController.getCustomerNameById(
                      appController.schedules[widget.index].idCustomer)),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.auto_awesome),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Serviços'),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Consumer<ScheduleController>(builder: (context, value) {
                  return Row(
                    children: currentSchedulingJobs.map<Card>((int jobId) {
                      return Card(
                        child: Row(
                          children: [
                            Icon(Icons.web),
                            Text(appController.getJobNameById(jobId: jobId)),
                            SizedBox(width: 5)
                          ],
                        ),
                      );
                    }).toList(),
                  );
                }),
              ),
            ],
          ),
        ),
        actions: [
          EditWidget(
            appController: appController,
            index: widget.index,
          ),
          RemoveWidget(
            appController: appController,
            index: widget.index,
          )
        ]);
  }
}

/// Adiciona uma decoração para um [Container]
BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(
      color: Colors.pink,
    ),
  );
}

/// [IconSlideAction] de Edição do Sliding
class EditWidget extends StatelessWidget {
  const EditWidget(
      {Key key, @required this.appController, @required this.index})
      : super(key: key);

  final AppController appController;
  final index;

  @override
  Widget build(BuildContext context) {
    return IconSlideAction(
      caption: 'Editar',
      icon: Icons.edit,
      color: Colors.green,
      onTap: () {
        Navigator.pushNamed(
          context,
          ScheduleRegister.routeName,
          arguments: ScheduleRegisterArguments(
            schedule: appController.schedules[index],
          ),
        );
      },
    );
  }
}

/// [IconSlideAction] de Remover do Sliding
class RemoveWidget extends StatelessWidget {
  const RemoveWidget(
      {Key key, @required this.appController, @required this.index})
      : super(key: key);

  final AppController appController;
  final index;

  @override
  Widget build(BuildContext context) {
    return IconSlideAction(
      caption: 'Remover',
      icon: Icons.restore_from_trash_outlined,
      color: Colors.red,
      onTap: () {
        appController.removeSchedule(index: index);
      },
    );
  }
}
