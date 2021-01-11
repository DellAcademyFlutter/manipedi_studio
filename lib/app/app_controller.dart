import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:manipedi_studio/app/data/customer_dao.dart';
import 'package:manipedi_studio/app/data/job_dao.dart';
import 'package:manipedi_studio/app/model/customer.dart';
import 'package:manipedi_studio/app/model/job.dart';

import 'data/schedule_dao.dart';
import 'data/scheduling_dao.dart';
import 'model/schedule.dart';
import 'model/scheduling.dart';

class AppController extends ChangeNotifier {
  // Injecoes de dependencia
  final customerDao = Modular.get<CustomerDao>();
  final jobDao = Modular.get<JobDao>();
  final scheduleDao = Modular.get<ScheduleDao>();
  final schedulingDao = Modular.get<SchedulingDao>();

  // Atributos da classe
  List<Customer> customers;
  List<Job> jobs;
  List<Schedule> schedules;
  Map<DateTime, List> events = {};

  //
  // Customers
  //

  /// Adiciona um [Customer] a lista de [Customer]s e no BD.
  addCustomer({Customer customer}) async {
    await customerDao
        .insertCustomer(customer)
        .then((value) => customer.id = value);
    customers.add(customer);

    notifyListeners();
  }

  /// Salva um [Customer] em sua tabela no Banco de Dados.
  saveCustomer({String name, String number}) {
    final newCustomer =
        Customer(id: null, name: name, number: number, numServices: 0);

    addCustomer(customer: newCustomer);
  }

  /// Remove um [Customer] da lista de [Customer]s e no BD.
  removeCustomer({int index}) async {
    final id = customers[index].id;
    await customerDao.removeCustomer(id);
    //await markingDao.deleteMarkerMarkings(markerId: id); //TODO
    customers.removeAt(index);

    notifyListeners();
  }

  /// Atualiza um [Customer] na lista de [Customer]s e no BD.
  updateCustomer({int index, Customer newCustomer}) async {
    await customerDao.updateCustomer(newCustomer);

    customers[index].name = newCustomer.name;
    customers[index].number = newCustomer.number;
    notifyListeners();
  }

  /// Atribui a lista de [Customer] com uma dada lista de [Customer].
  setCustomers({List<Customer> customers}) {
    this.customers = customers;
    notifyListeners();
  }

  //
  // Job
  //

  /// Adiciona um [Job] a lista de [Job]s e no BD.
  addJob({Job job}) async {
    int generatedId;
    await jobDao.insertJob(job).then((value) => generatedId = value);
    job.id = generatedId;
    jobs.add(job);

    notifyListeners();
  }

  /// Salva um [Job] em sua tabela no Banco de Dados.
  saveJob({String name, double price}) {
    final newJob = Job(id: null, name: name, price: price);

    addJob(job: newJob);
  }

  /// Remove um [Job] da lista de [Job]s e no BD.
  removeJob({int index}) async {
    final id = jobs[index].id;
    await jobDao.removeJob(id);
    //await markingDao.deleteMarkerMarkings(markerId: id); //TODO
    jobs.removeAt(index);

    notifyListeners();
  }

  /// Atualiza um [Job] na lista de [Job]s e no BD.
  updateJob({int index, Job newJob}) async {
    await jobDao.updateJob(newJob);

    jobs[index].name = newJob.name;
    jobs[index].price = newJob.price;
    notifyListeners();
  }

  /// Atribui a lista de [Job] com uma dada lista de [Job].
  setJob({List<Job> jobs}) {
    this.jobs = jobs;
    notifyListeners();
  }

  /// Busca e retorna um nome de um [Job] por seu id.
  String getJobNameById({int jobId}) {
    for (var i = 0; i < jobs.length; i++) {
      if (jobs[i].id == jobId) {
        return jobs[i].name;
      }
    }
    return "NothingFound";
  }

  //
  // Schedule
  //

  /// Adiciona um [Schedule] a lista de [Schedules]s e no BD.
  Future<int> addSchedule({Schedule schedule}) async {
    await scheduleDao
        .insertSchedule(schedule)
        .then((value) => schedule.id = value);
    schedules.add(schedule);

    //Antes de adicionar na lista de events, convertepara DateTime
    final parsedDate = DateTime.parse(schedule.date);
    events.addAll({
      parsedDate: ['Agendamento']
    });

    notifyListeners();
    return schedule.id;
  }

  /// Salva um [Schedule] em sua tabela no Banco de Dados.
  saveSchedules({String date, String time}) {
    final newSchedule = Schedule(date: date, time: time);

    addSchedule(schedule: newSchedule);
  }

  /// Remove um [Schedule] da lista de [Schedules]s e no BD.
  removeSchedule({int index}) async {
    final id = schedules[index].id;
    await scheduleDao.removeSchedule(id);
    //await markingDao.deleteMarkerMarkings(markerId: id); //TODO
    schedules.removeAt(index);

    notifyListeners();
  }

  /// Atualiza um [Schedule] na lista de [Schedules]s e no BD.
  Future<int> updateSchedule({int index, Schedule newSchedule}) async {
    await scheduleDao.updateSchedule(newSchedule);
    schedules[index].setValues(otherSchedule: newSchedule);

    notifyListeners();
    return newSchedule.id;
  }

  /// Atribui a lista de [Schedule] com uma dada lista de [Schedules].
  setSchedules({List<Schedule> schedules}) {
    this.schedules = schedules;
    notifyListeners();
  }

  // Recebe uma lista de [Schedules] e atribui em eventos
  setEventsByShedules() {
    DateTime parsedDate;
    for (var i = 0; i < schedules.length; i++) {
      parsedDate = DateTime.parse(schedules[i].date);
      events.addAll({
        parsedDate: ['Agendamento']
      });
    }
    notifyListeners();
  }

  //
  // Scheduling
  //

  /// Adiciona um [Scheduling], armazenando em sua tabela no Banco de Dados.
  addScheduling({Scheduling scheduling}) async {
    await schedulingDao.insertScheduling(scheduling);
  }

  /// Remove um [Scheduling], armazenando em sua tabela no Banco de Dados.
  removeScheduling({Scheduling scheduling}) async {
    await schedulingDao.deleteScheduling(scheduling);
  }
}
