import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/app_controller.dart';
import 'package:manipedi_studio/app/data/customer_dao.dart';
import 'package:manipedi_studio/app/model/customer.dart';

class CustomerController {
  final appController = Modular.get<AppController>();
  final customerDao = Modular.get<CustomerDao>();

  /// Salva um Customer  dado um [name] e um [number].
  saveCustomer({String name, String number}) {
    final newCustomer = Customer(name: name, number: number, numServices: 0);

    appController.addCustomer(customer: newCustomer);
  }

  /// Inicializa os [Customer] do sistema.
  initializeCustomers() async {
    await customerDao
        .getCustomers()
        .then((value) => appController.setCustomers(customers: value));
  }
}
