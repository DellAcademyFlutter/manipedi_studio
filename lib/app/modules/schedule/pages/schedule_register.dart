import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/model/schedule.dart';
import 'package:manipedi_studio/app/modules/schedule/components/custom_picker.dart';
import 'package:manipedi_studio/app/modules/schedule/pages/schedule_job_select.dart';

import 'package:manipedi_studio/app/app_controller.dart';
import 'package:manipedi_studio/app/modules/schedule/schedule_controller.dart';

class ScheduleRegisterArguments {
  ScheduleRegisterArguments({this.schedule});
  Schedule schedule;
}

class ScheduleRegister extends StatefulWidget {
  ScheduleRegister({this.schedule});

  static const routeName = "/scheduleRegister";
  final Schedule schedule;

  @override
  _ScheduleRegisterState createState() => _ScheduleRegisterState();
}

class _ScheduleRegisterState extends State<ScheduleRegister> {
  final appController = Modular.get<AppController>();
  final scheduleController = Modular.get<ScheduleController>();
  String _time;
  int timeMinutes;
  String minutesFix;

  @override
  void initState() {
    super.initState();

    //Se o Schedule for a edição de um Schedule
    if (widget.schedule != null) {
      //Carrega a lista de jobs do usuário no Scheduling e armazena na lista schedulingJobs
      scheduleController.initializeScheduleJobs(widget.schedule.id,
          widget.schedule.idCustomer, scheduleController.schedulingJobs);

      //Zera a lista de schedulings
      scheduleController.schedulingJobs.clear();

      //Inicializa o Costumer
      scheduleController.selectedCostumer =
          appController.getCustomerByIdTemp(widget.schedule.idCustomer);

      _time = widget.schedule.time; //Inicializa o tempo

      // Se for a criação de um novo Schedule
    } else {
      _time = "";
      scheduleController.selectedCostumer = null;
      scheduleController.schedulingJobs.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Agendando')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                  "Dia: ${scheduleController.day}/${scheduleController.month}"
                  "/${scheduleController.year}"),
            ),
            Center(
              child: DropdownButton(
                icon: Icon(Icons.person),
                iconSize: 20,
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                hint: Text('Escolha uma Cliente'),
                value: scheduleController.selectedCostumer,
                onChanged: (newValue) {
                  setState(() {
                    scheduleController.selectedCostumer = newValue;
                  });
                },
                items: appController.customers.map((customer) {
                  return DropdownMenuItem(
                    child: Center(child: Center(child: Text(customer.name))),
                    value: customer,
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: RaisedButton(
                // Icon(Icons.access_time_outlined),
                child: Text('Selecionar horário'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 16.0,
                onPressed: () {
                  DatePicker.showPicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 350.0,
                      ),
                      showTitleActions: true,
                      pickerModel: CustomPicker(currentTime: DateTime.now()),
                      onConfirm: (time) {
                    timeMinutes = time.minute.toInt();
                    if (timeMinutes < 10) {
                      minutesFix = "0${timeMinutes.toString()}";
                    } else {
                      minutesFix = time.minute.toString();
                    }
                    _time = '${time.hour} : ${minutesFix}';
                    setState(() {});
                  }, locale: LocaleType.pt);
                  setState(() {});
                },
              ),
            ),
            SizedBox(height: 8),
            Center(child: Text("Horário: ${_time}")),
            SizedBox(height: 30),
            Center(
              child: RaisedButton(
                child: Text('Escolher os serviços'),
                onPressed: () =>
                    Navigator.pushNamed(context, ScheduleJobSelect.routeName),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Consumer<ScheduleController>(builder: (context, value) {
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: scheduleController.schedulingJobs
                        .map<Card>((int jobId) {
                      return Card(
                          margin: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Icon(Icons.web),
                              Text(appController.getJobNameById(jobId: jobId)),
                              SizedBox(width: 5)
                            ],
                          ));
                    }).toList(),
                  ),
                );
              }),
            ),
            Spacer(),
            Center(
              child: RaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.domain_verification,
                      size: 30,
                    ),
                    Text('Confirmar'),
                  ],
                ),
                onPressed: () {
                  scheduleController.ScheduleConfirm(
                      customer: scheduleController.selectedCostumer,
                      schedule: widget.schedule,
                      time: _time,
                      date: scheduleController.selectedDay.toString(),
                      scheduleJobs: scheduleController.schedulingJobs);
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
