import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/app_controller.dart';
import 'package:manipedi_studio/app/app_widget.dart';
import 'package:manipedi_studio/app/data/customer_dao.dart';
import 'package:manipedi_studio/app/data/job_dao.dart';
import 'package:manipedi_studio/app/data/scheduling_dao.dart';
import 'package:manipedi_studio/app/modules/config/config_module.dart';
import 'package:manipedi_studio/app/modules/customer/costumer_module.dart';
import 'package:manipedi_studio/app/modules/home/home_module.dart';
import 'package:manipedi_studio/app/modules/job/job_module.dart';
import 'package:manipedi_studio/app/modules/result/result_module.dart';
import 'package:manipedi_studio/app/modules/schedule/schedule_module.dart';
import 'package:manipedi_studio/app/repositories/shared/user_settings.dart';

import 'data/schedule_dao.dart';

class AppModule extends MainModule {
  @override
  // Lista de injecoes de dependencia do projeto
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => CustomerDao()),
        Bind((i) => JobDao()),
        Bind((i) => ScheduleDao()),
        Bind((i) => SchedulingDao()),
        Bind((i) => UserSettings()),
      ];

  @override
  // Root Widget
  Widget get bootstrap => AppWidget();

  @override
  // Modulos associados a este aplicativo
  List<ModularRouter> get routers => [
        ModularRouter(HomeModule.routeName, module: HomeModule()),
        ModularRouter(CustomerModule.routeName, module: CustomerModule()),
        ModularRouter(JobModule.routeName, module: JobModule()),
        ModularRouter(ScheduleModule.routeName, module: ScheduleModule()),
        ModularRouter(ResultModule.routeName, module: ResultModule()),
        ModularRouter(ConfigModule.routeName, module: ConfigModule()),
      ];
}
