import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/model/customer.dart';
import 'package:manipedi_studio/app/model/schedule.dart';
import 'package:manipedi_studio/app/modules/schedule/components/custom_picker.dart';
import 'package:manipedi_studio/app/modules/schedule/pages/schedule_job_select.dart';

import '../../../app_controller.dart';
import '../schedule_controller.dart';

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
  Customer selectedCostumer;
  String _time = "";

  @override
  void initState() {
    super.initState();

    if (widget.schedule != null) {
      scheduleController.initializeScheduleJobs(scheduleId: widget.schedule.id);
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
                value: selectedCostumer,
                onChanged: (newValue) {
                  setState(() {
                    selectedCostumer = newValue;
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
                    _time = '${time.hour} : ${time.minute}';
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
                      customer: selectedCostumer,
                      schedule: widget.schedule,
                      time: _time,
                      date: scheduleController.selectedDay.toString(),
                      scheduleJobs: scheduleController.schedulingJobs);
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
