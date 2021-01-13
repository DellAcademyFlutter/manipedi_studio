import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/data/customer_dao.dart';
import 'package:manipedi_studio/app/data/schedule_dao.dart';
import 'package:manipedi_studio/app/data/scheduling_dao.dart';
import 'package:manipedi_studio/app/model/customer.dart';
import 'package:manipedi_studio/app/model/schedule.dart';
import 'package:manipedi_studio/app/model/scheduling.dart';

import '../../app_controller.dart';

class ScheduleController extends ChangeNotifier {
  final appController = Modular.get<AppController>();
  final schedulingDao = Modular.get<SchedulingDao>();
  final customerDao = Modular.get<CustomerDao>();
  DateTime selectedDay;
  String day, month, year;
  String formattedDate;
  Customer selectedCostumer;
  List<int> schedulingJobs = [];

  /// Inicializa a lista de jobs do Scheduling
  initializeScheduleJobs(
      int scheduleId, int customerId, List<int> schedulingJobs) async {
    schedulingJobs.clear();

    await schedulingDao
        .getScheduleJobsIds(scheduleId: scheduleId, customerId: customerId)
        .then((value) {
      for (var i = 0; i < value.length; i++) {
        schedulingJobs.add(value[i]);
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

  ScheduleConfirm(
      {Schedule schedule, Customer customer, List<int> scheduleJobs, String date, String time}) {

    final newSchedule = Schedule(
      id: schedule?.id,
      idCustomer: customer.id,
      time: time,
      date: date,
    );

    // Editar o postit
    if (schedule != null) {
      appController.updateSchedule(newSchedule: newSchedule).then((value) =>
          associateJobsToSchedule(
              customerId: customer.id,
              scheduleId: schedule.id,
              scheduleJobs: scheduleJobs));
    } // Adicionar o postit
    else {
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

    //Atualiza a lista de eventos baseado na lista de Schedules
    appController.setEventsByShedules();
  }
}
