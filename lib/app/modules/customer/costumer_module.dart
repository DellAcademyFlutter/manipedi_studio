import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/modules/customer/Pages/customer_register.dart';
import 'package:manipedi_studio/app/modules/customer/costumer_controller.dart';
import 'package:manipedi_studio/app/modules/customer/costumer_page.dart';

class CustomerModule extends ChildModule {
  @override
  // Lista de injecoes de dependencia do projeto
  List<Bind> get binds => [Bind((i) => CustomerController())];

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
