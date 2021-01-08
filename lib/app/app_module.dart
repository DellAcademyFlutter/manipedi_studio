import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/modules/client/client_module.dart';
import 'package:manipedi_studio/app/modules/config/config_module.dart';
import 'package:manipedi_studio/app/modules/result/result_module.dart';
import 'package:manipedi_studio/app/modules/schedule/schedule_module.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'data/customer_dao.dart';
import 'modules/home/home_module.dart';

class AppModule extends MainModule {
  @override
  // Lista de injecoes de dependencia do projeto
  List<Bind> get binds => [
    Bind((i) => AppController()),
    Bind((i) => CustomerDao()),
  ];

  @override
  // Root Widget
  Widget get bootstrap => AppWidget();

  @override
  // Modulos associados a este aplicativo
  List<ModularRouter> get routers => [
    ModularRouter(HomeModule.routeName, module: HomeModule()),
    ModularRouter(CustomerModule.routeName, module: CustomerModule()),
    ModularRouter(ScheduleModule.routeName, module: ScheduleModule()),
    ModularRouter(ResultModule.routeName, module: ResultModule()),
    ModularRouter(ConfigModule.routeName, module: ConfigModule()),
  ];
}