import 'package:flutter_modular/flutter_modular.dart';
import 'result_controller.dart';
import 'result_page.dart';

class ResultModule extends ChildModule {
  @override
  // Injecoes de dependencia
  List<Bind> get binds => [
    Bind((i) => ResultController())
  ];

  @override
  // Rotas
  List<ModularRouter> get routers => [
    ModularRouter<String>(
      Modular.initialRoute,
      child: (_, args) => ResultPage(),
      transition: TransitionType.leftToRight,
    ),
  ];

  static const routeName = "/result";
}
