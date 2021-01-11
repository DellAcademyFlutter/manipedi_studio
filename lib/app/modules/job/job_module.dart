import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/modules/job/job_controller.dart';
import 'package:manipedi_studio/app/modules/job/job_page.dart';

class JobModule extends ChildModule {
  @override
  // Injecoes de dependencia
  List<Bind> get binds => [
    Bind((i) => JobController())
  ];

  @override
  // Rotas
  List<ModularRouter> get routers => [
    ModularRouter<String>(
      Modular.initialRoute,
      child: (_, args) => JobPage(),
      transition: TransitionType.leftToRight,
    ),
  ];

  static const routeName = '/JobModule';
}
