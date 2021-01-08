import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'data/customer_dao.dart';
import 'model/customer.dart';

class AppController extends ChangeNotifier{
  // Injecoes de dependencia
  final customerDao = Modular.get<CustomerDao>();

  // Atributos da classe
  List<Customer> customers;

  /// Adiciona um [Marker] a lista de [Marker]s e no BD.
  addCustomer ({Customer customer}) async {
    int generatedId;
    await customerDao.insertCustomer(customer).then((value) => generatedId = value);
    customer.id = generatedId;
    customers.add(customer);

    notifyListeners();
  }

  /// Salva um [Customer] em sua tabela no Banco de Dados.
  saveCustomer({String name, String number}) {
    final newCustomer = Customer(
        id: null, name: name, number: number, numServices: 0);

    addCustomer(customer: newCustomer);
  }

  /// Remove um [Customer] da lista de [Customer]s e no BD.
  removeCustomer({int index}) async {
    final id = customers[index].id;
    await customerDao.removeCustomer(id);
    //await markingDao.deleteMarkerMarkings(markerId: id);
    customers.removeAt(index);

    notifyListeners();
  }

  /// Atualiza um [Customer] na lista de [Customers]s e no BD.
  updateCustomer({int index, Customer newCustomer}) async {
    await customerDao.updateCustomer(newCustomer);

    customers[index].id = newCustomer.id;
    customers[index].name = newCustomer.name;
    notifyListeners();
  }

  /// Atribui a lista de [Marker] do usuario com uma dada lista de [Marker].
  setCustomers({List<Customer> customers}) {
    this.customers = customers;
    notifyListeners();
  }

}