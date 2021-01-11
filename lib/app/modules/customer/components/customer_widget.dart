import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/app_controller.dart';

class CustomersWidget extends StatefulWidget {
  CustomersWidget({this.index});
  final int index;

  @override
  _CustomersWidgetState createState() => _CustomersWidgetState();
}

class _CustomersWidgetState extends State<CustomersWidget> {
  final appController = Modular.get<AppController>();
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
  Widget build(BuildContext context) {
    return Card(
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
                      Icon(Icons.person, size: 40, color: Colors.purple),
                      isEditing
                          ? Flexible(
                              child: TextFormField(
                                controller: nameController,
                                onChanged: (valor) => setState(() {
                                  appController.customers[widget.index].name =
                                      valor;
                                  name = valor;
                                }),
                              ),
                            )
                          : Text(
                              appController.customers[widget.index].name,
                            ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.phone, size: 40, color: Colors.green),
                      isEditing
                          ? Flexible(
                              child: TextFormField(
                              maxLength: 11,
                              controller: numberController,
                              onChanged: (valor) => setState(() {
                                appController.customers[widget.index].number =
                                    valor;
                                number = valor;
                              }),
                            ))
                          : Text(appController.customers[widget.index].number),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(children: [
                  Text("Serviços: "),
                  Text(appController.customers[widget.index].numServices
                      .toString()),
                ]),
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
                                    index: widget.index,
                                    newCustomer: newCustomer);
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
          ],
        ),
      ]),
    );
  }
}