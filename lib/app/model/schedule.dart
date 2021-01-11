import 'package:flutter/cupertino.dart';

class Schedule {
  Schedule({this.id, this.idCustomer, this.date, this.time});
  int id;
  int idCustomer;
  String date;
  String time;

  /// Atribui os valores dos parametros deste [Schedule] dado um [Map].
  Schedule.fromMap({Map<String, dynamic> map}) {
    id = map['id'];
    idCustomer = map['idCustomer'];
    date = map['date'];
    time = map['time'];
  }

  /// Este metodo codifica este [Schedule] em um [Map].
  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['idCustomer'] = idCustomer;
    data['date'] = date;
    data['time'] = time;
    return data;
  }

  /// Atribui os valores dos atributos de um [Schedule] a este [Schedule].
  setValues({@required Schedule otherSchedule}) {
    id = otherSchedule.id;
    idCustomer = otherSchedule.idCustomer;
    date = otherSchedule.date;
    time = otherSchedule.time;
  }
}
