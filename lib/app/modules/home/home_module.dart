import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/modules/customer/costumer_controller.dart';
import 'package:manipedi_studio/app/modules/job/job_controller.dart';
import 'home_controller.dart';
import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  // Injecoes de dependencia
  List<Bind> get binds => [
    Bind((i) => HomeController()),
    Bind((i) => CustomerController()),
    Bind((i) => JobController()),
  ];

  @override
  // Rotas
  List<ModularRouter> get routers => [
    ModularRouter<String>(
      Modular.initialRoute,
      child: (_, args) => HomePage(),
      transition: TransitionType.leftToRight,
    ),
  ];

  static Inject get to => Inject<HomeModule>.of();
  static const routeName = '/home';

}
