import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/modules/config/config_controller.dart';
import 'package:manipedi_studio/app/modules/config/config_page.dart';

class ConfigModule extends ChildModule {
  @override
  // Lista de injecoes de dependencia do projeto
  List<Bind> get binds => [
    Bind((i) => ConfigController())
  ];

  @override
  // Modulos associados a este aplicativo
  List<ModularRouter> get routers => [
    ModularRouter<String>(
      Modular.initialRoute,
      child: (_, args) => ConfigPage(),
      transition: TransitionType.leftToRight,
    ),
  ];

  static const routeName = "/config";
}