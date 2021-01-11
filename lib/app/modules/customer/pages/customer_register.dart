import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:manipedi_studio/app/modules/customer/costumer_controller.dart';

class CustomerRegister extends StatefulWidget {
  static const routeName = "/customerRegister";

  @override
  _CustomerRegisterState createState() => _CustomerRegisterState();
}

class _CustomerRegisterState extends State<CustomerRegister> {
  final customerController = Modular.get<CustomerController>();
  TextEditingController customerName = TextEditingController();
  TextEditingController customerNumber = TextEditingController();
  String inputCustomerName;
  String inputCustomerNumber;
  var maskNumberFormatter = MaskTextInputFormatter(
      mask: '(##) #########', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: customerName,
                maxLines: 1,
                cursorColor: Colors.black,
                onChanged: (valor) => setState(() => inputCustomerName = valor),
                decoration: InputDecoration(
                  labelText: 'Nome da Cliente',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: customerNumber,
                inputFormatters: [maskNumberFormatter],
                maxLines: 1,
                cursorColor: Colors.black,
                onChanged: (valor) => setState(() => inputCustomerNumber = valor),
                decoration: InputDecoration(
                  labelText: 'Número da Cliente',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width, // match_parent
                child: RaisedButton(
                  child: Text("Adicionar"),
                  onPressed: () {
                    customerController.saveCustomer(
                        name: inputCustomerName,
                        number: maskNumberFormatter.getUnmaskedText());
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      //  ),
    );
  }
}
