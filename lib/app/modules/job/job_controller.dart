import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/app_controller.dart';
import 'package:manipedi_studio/app/data/job_dao.dart';
import 'package:manipedi_studio/app/model/job.dart';

class JobController{
  final appController = Modular.get<AppController>();
  final jobDao = Modular.get<JobDao>();

  /// Salva um Job  dado um [name] e um [price].
  saveJob({String name, double price}) {
    final newJob = Job(name: name, price: price);

    appController.addJob(job: newJob);
  }

  /// Inicializa os [Job] do sistema.
  initializeJobs() async {
    await jobDao
        .getJobs()
        .then((value) => appController.setJob(jobs: value));
  }
}