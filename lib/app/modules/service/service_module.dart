import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/modules/service/service_controller.dart';
import 'package:manipedi_studio/app/modules/service/service_page.dart';

class ServiceModule extends ChildModule {
  @override
  // Injecoes de dependencia
  List<Bind> get binds => [
    Bind((i) => ServiceController())
  ];

  @override
  // Rotas
  List<ModularRouter> get routers => [
    ModularRouter<String>(
      Modular.initialRoute,
      child: (_, args) => ServicePage(),
      transition: TransitionType.leftToRight,
    ),
  ];

  static const routeName = '/service';
}
