import 'package:flutter_modular/flutter_modular.dart';
import 'schedule_controller.dart';
import 'schedule_page.dart';

class ScheduleModule extends ChildModule {
  @override
  // Lista de injecoes de dependencia do projeto
  List<Bind> get binds => [
    Bind((i) => ScheduleController())
  ];

  @override
  // Modulos associados a este aplicativo
  List<ModularRouter> get routers => [
    ModularRouter<String>(
      Modular.initialRoute,
      child: (_, args) => SchedulePage(),
      transition: TransitionType.leftToRight,
    ),
  ];
  static const routeName = "/schedule";

}