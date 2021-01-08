class Customer {
  Customer({this.id, this.name, this.number, this.numServices});

  //Atributos
  int id;
  String name;
  String number;
  int numServices;

  /// Atribui os valores dos parametros de [Customer] dado um [Map].
  Customer.fromMap({Map<String, dynamic> map}) {
    id = map['id'];
    name = map['name'];
    number = map['number'];
    numServices = map['numServices'];
  }

  /// Este metodo codifica este [Customer] em um [Map].
  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['number'] = number;
    data['numServices'] = numServices;
    return data;
  }

}