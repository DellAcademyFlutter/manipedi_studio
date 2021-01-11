import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/app_controller.dart';
import 'package:manipedi_studio/app/data/job_dao.dart';
import 'package:manipedi_studio/app/modules/job/job_controller.dart';

import 'components/jobs_widget.dart';

class JobPage extends StatefulWidget {
  @override
  _JobPageState createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  final jobDao = Modular.get<JobDao>();
  final appController = Modular.get<AppController>();
  final jobController = Modular.get<JobController>();
  TextEditingController jobName = TextEditingController();
  TextEditingController jobPrice = TextEditingController();
  String inputJobName;
  String inputJobPrice;

  @override
  void initState() {
    super.initState();
    jobController.initializeJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Serviços'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Consumer<AppController>(builder: (context, value) {
              return appController.jobs != null
                  ? Expanded(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: appController.jobs.length,
                          itemBuilder: (BuildContext context, int index) =>
                              JobsWidget(
                            index: index,
                          ),
                        ),
                      ),
                    )
                  : CircularProgressIndicator();
            }),
            Container(
              child: Column(children: [
                Text("Cadastrar Serviço:", textAlign: TextAlign.center),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: jobName,
                        maxLines: 1,
                        cursorColor: Colors.black,
                        onChanged: (valor) =>
                            setState(() => inputJobName = valor),
                        decoration: InputDecoration(
                          labelText: 'Serviço',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: TextFormField(
                        controller: jobPrice,
                        maxLines: 1,
                        cursorColor: Colors.black,
                        onChanged: (valor) =>
                            setState(() => inputJobPrice = valor),
                        decoration: InputDecoration(
                          labelText: 'Preço',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      tooltip: 'Add',
                      onPressed: () {
                        jobController.saveJob(
                            name: inputJobName,
                            price: double.parse(inputJobPrice));
                        jobName.clear();
                        jobPrice.clear();

                      },
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
