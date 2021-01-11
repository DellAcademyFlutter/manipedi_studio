import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/app_controller.dart';

class JobsWidget extends StatefulWidget {
  JobsWidget({this.index});
  final int index;

  @override
  _JobsWidgetState createState() => _JobsWidgetState();
}

class _JobsWidgetState extends State<JobsWidget> {
  final appController = Modular.get<AppController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  String name;
  String price;
  bool isEditing;

  @override
  void initState() {
    super.initState();
    nameController.text = appController.jobs[widget.index].name;
    name = nameController.text;
    priceController.text = appController.jobs[widget.index].price.toString();
    price = priceController.text;
    isEditing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.web, size: 40),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.auto_awesome, color: Colors.pink),
                            SizedBox(width: 5),
                            isEditing
                                ? Flexible(
                                child: TextFormField(
                                  controller: nameController,
                                  onChanged: (valor) => setState(() {
                                    appController.jobs[widget.index].name = valor;
                                    name = valor;
                                  }),
                                ))
                                : Text(appController.jobs[widget.index].name),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.attach_money, color: Colors.yellow),
                            isEditing
                                ? Flexible(
                                child: TextFormField(
                                  controller: priceController,
                                  onChanged: (valor) => setState(() {
                                    appController.jobs[widget.index].price = double.parse(valor);
                                    price = valor;
                                  }),
                                ))
                                : Text(appController.jobs[widget.index].price.toString()),
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
                              final newJob =
                              appController.jobs[widget.index];
                              newJob.name = name;
                              newJob.price = double.parse(price);
                              appController.updateJob(
                                  index: widget.index,
                                  newJob: newJob);
                            }
                          })),
                      IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            appController.removeJob(index: widget.index);
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
