import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/app_controller.dart';

import '../costumer_controller.dart';

class CustomersWidget extends StatefulWidget {
  CustomersWidget({this.index});
  final int index;

  @override
  _CustomersWidgetState createState() => _CustomersWidgetState();
}

class _CustomersWidgetState extends State<CustomersWidget> {
  final appController = Modular.get<AppController>();
  final customerController = Modular.get<CustomerController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  String name;
  String number;
  bool isEditing;

  @override
  void initState() {
    super.initState();
    nameController.text = appController.customers[widget.index].name;
    name = nameController.text;
    numberController.text = appController.customers[widget.index].number;
    number = numberController.text;
    isEditing = false;
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: (isEditing) ? Theme.of(context).cardColor.withAlpha(150) : null,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Icon(Icons.account_circle_outlined, size: 80),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, size: 40, color: Colors.teal),
                      Flexible(
                        child: TextFormField(
                          controller: nameController,
                          readOnly: !isEditing,
                          onChanged: (valor) => setState(() {
                            appController.customers[widget.index].name = valor;
                            name = valor;
                          }),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.phone, size: 40, color: Colors.green),
                      Flexible(
                          child: TextFormField(
                        maxLength: 11,
                        controller: numberController,
                        readOnly: !isEditing,
                        onChanged: (valor) => setState(() {
                          appController.customers[widget.index].number = valor;
                          number = valor;
                        }),
                      ))
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => setState(() {
                          isEditing = !isEditing;
                          if (isEditing == false) {
                            final newCustomer =
                                appController.customers[widget.index];
                            newCustomer.name = name;
                            newCustomer.number = number;
                            appController.updateCustomer(
                                index: widget.index, newCustomer: newCustomer);
                          }
                        })),
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      appController.removeCustomer(index: widget.index);
                    }),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
