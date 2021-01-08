import 'package:flutter_modular/flutter_modular.dart';
import 'Pages/customer_register.dart';
import 'client_controller.dart';
import 'client_page.dart';

class CustomerModule extends ChildModule {
  @override
  // Lista de injecoes de dependencia do projeto
  List<Bind> get binds => [
    Bind((i) => CustomerController())
  ];

  @override
  // Modulos associados a este aplicativo
  List<ModularRouter> get routers => [
    ModularRouter<String>(
      Modular.initialRoute,
      child: (_, args) => CustomerPage(),
      transition: TransitionType.leftToRight,
    ),
    ModularRouter<String>(
      CustomerRegister.routeName,
      child: (_, args) => CustomerRegister(),
      transition: TransitionType.leftToRight,
    ),
  ];

  static const routeName = "/customer";
}