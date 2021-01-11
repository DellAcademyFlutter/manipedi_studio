import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/data/job_dao.dart';
import 'package:manipedi_studio/app/model/job.dart';
import '../../../app_controller.dart';
import '../schedule_controller.dart';

class ScheduleJobSelectArguments {}

class ScheduleJobSelect extends StatefulWidget {
  static const routeName = "/scheduleSelect";

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ScheduleJobSelect> {
  final appController = Modular.get<AppController>();
  final scheduleController = Modular.get<ScheduleController>();
  final jobDao = Modular.get<JobDao>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecionar Seviços'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: FutureBuilder(
            future: jobDao.getJobs(),
            builder: (BuildContext context, AsyncSnapshot<List<Job>> snapshot) {
              return snapshot.hasData
                  ? Consumer<AppController>(builder: (context, value) {
                      appController.jobs = snapshot.data;
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: appController.jobs.length,
                        itemBuilder: (BuildContext context, int index) =>
                            SelectJobWidget(
                          index: index,
                          priorAddedJob: scheduleController.schedulingJobs,
                        ),
                      );
                    })
                  : CircularProgressIndicator();
            }),
      ),
    );
  }
}

/// [Widget] elemento filtro da lista de [Job] .
class SelectJobWidget extends StatefulWidget {
  SelectJobWidget({
    @required this.index,
    @required this.priorAddedJob,
  });

  final int index;
  final List<int> priorAddedJob;

  @override
  _SelectJobWidgetState createState() => _SelectJobWidgetState();
}

class _SelectJobWidgetState extends State<SelectJobWidget> {
  final scheduleController = Modular.get<ScheduleController>();
  final appController = Modular.get<AppController>();
  bool isSelected = false;

  atualizeStatus() {
    setState(() {
      isSelected = !isSelected;
      isSelected
          ? scheduleController.addJob(
              jobId: appController.jobs[widget.index].id)
          : scheduleController.removeJob(
              jobId: appController.jobs[widget.index].id);
    });
  }

  @override
  void initState() {
    super.initState();

    isSelected =
        widget.priorAddedJob.contains(appController.jobs[widget.index].id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppController>(builder: (context, value) {
      return GestureDetector(
        onTap: () {
          atualizeStatus();
        },
        child: Card(
          child: Row(children: [
            Icon(Icons.web, size: 50,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.auto_awesome, color: Colors.pink),
                    SizedBox(width: 5),
                    Text(appController.jobs[widget.index].name),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.attach_money, color: Colors.yellow),
                    Text(appController.jobs[widget.index].price.toString()),
                  ],
                ),
              ],
            ),
            Spacer(),
            Checkbox(
              value: isSelected,
              onChanged: (value) => atualizeStatus(),
            )
          ]),
        ),
      );
    });
  }
}
