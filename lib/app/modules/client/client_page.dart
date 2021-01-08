import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:manipedi_studio/app/data/customer_dao.dart';
import 'package:manipedi_studio/app/modules/client/Pages/customer_register.dart';
import '../../app_controller.dart';
import 'Components/customer_widget.dart';
import 'client_controller.dart';

class CustomerPage extends StatefulWidget {
  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final customerDao = Modular.get<CustomerDao>();
  final appController = Modular.get<AppController>();
  final customerController = Modular.get<CustomerController>();
  TextEditingController customerName = TextEditingController();
  String inputCustomerName;

  @override
  void initState() {
    super.initState();
    customerController.initializeCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CustomerRegister.routeName);
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<AppController>(builder: (context, value) {
                return appController.customers != null
                    ? Expanded(
                        child: SizedBox(
                          height: 200, //TODO
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: appController.customers.length,
                            itemBuilder: (BuildContext context, int index) =>
                                CustomersWidget(
                              index: index,
                            ),
                          ),
                        ),
                      )
                    : CircularProgressIndicator();
              }),
            ]),
      ),
    );
  }
}
