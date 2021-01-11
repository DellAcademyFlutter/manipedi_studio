import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/data/schedule_dao.dart';
import 'package:manipedi_studio/app/data/scheduling_dao.dart';
import 'package:manipedi_studio/app/model/customer.dart';
import 'package:manipedi_studio/app/model/schedule.dart';
import 'package:manipedi_studio/app/model/scheduling.dart';

import '../../app_controller.dart';

class ScheduleController extends ChangeNotifier {
  final appController = Modular.get<AppController>();
  DateTime selectedDay;
  String day, month, year;

  final schedulingDao = Modular.get<SchedulingDao>();
  List<int> schedulingJobs = [];

  /// Inicializa a lista de markers do postit
  initializeScheduleJobs({int scheduleId}) async {
    await schedulingDao
        .getScheduleJobsIds(scheduleId: scheduleId)
        .then((value) {
      for (var i = 0; i < value.length; i++) {
        if (!schedulingJobs.contains(value[i])) {
          schedulingJobs.add(value[i]);
        }
      }

      notifyListeners();
    });
  }

  /// Adiciona um [job] da lista de [jobs]
  void addJob({@required int jobId}) {
    if (!schedulingJobs.contains(jobId)) {
      schedulingJobs.add(jobId);
    }
    notifyListeners();
  }

  /// Remove um um [job] da lista de [jobs]
  void removeJob({@required int jobId}) {
    if (schedulingJobs.contains(jobId)) {
      schedulingJobs.remove(jobId);
    }
    notifyListeners();
  }

  ScheduleConfirm({Schedule schedule, Customer customer, List<int> scheduleJobs,
      String date, String time}) {

    final newSchedule = Schedule(
      id: schedule?.id,
      time: time,
      date: date,
    );

    // Editar o postit
    if (schedule != null) {
      appController
          .updateSchedule(
              index: appController.schedules.indexOf(schedule),
              newSchedule: newSchedule)
          .then((value) => associateJobsToSchedule(
              customerId: customer.id,
              scheduleId: schedule.id,
              scheduleJobs: scheduleJobs));
    }   // Adicionar o postit
    else {
      //TODO: INICIALIZAR LISTA DE SCHEDULES NO HOMEPAGE_PRIMEIRO
      appController.addSchedule(schedule: newSchedule).then((value) =>
          associateJobsToSchedule(
              customerId: customer.id,
              scheduleId: value,
              scheduleJobs: scheduleJobs));
    }
  }

  /// Associa um [Schedule] com varios [Jobs]s dados.
  associateJobsToSchedule(
      {int customerId, int scheduleId, List<int> scheduleJobs}) {
    final schedulingDao = Modular.get<SchedulingDao>();

    // Remove todos os jobs antigos deste postit
    schedulingDao.deleteJobsCustomer(
        customerId: customerId, scheduleId: scheduleId);

    // Adicionar todos os jobs do postit
    if (scheduleJobs.isNotEmpty) {
      for (var i = 0; i < scheduleJobs.length; i++) {
        final newScheduling = Scheduling(
          customerId: customerId,
          scheduleId: scheduleId,
          jobId: scheduleJobs[i],
        );

        appController.addScheduling(scheduling: newScheduling);
      }
    }
  }

  /// Inicializa os [Schedules]s do [Costumer] logado no sistema.
  initializeSchedules() async {
    final appController = Modular.get<AppController>();
    final scheduleDao = Modular.get<ScheduleDao>();

    await scheduleDao
        .getSchedules()
        .then((value) => appController.setSchedules(schedules: value));
  }
}
