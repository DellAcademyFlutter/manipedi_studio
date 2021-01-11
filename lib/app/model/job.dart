class Job {
  Job({this.id, this.name, this.price});

  //Atributos
  int id;
  String name;
  double price;

  /// Atribui os valores dos parametros de [Job] dado um [Map].
  Job.fromMap({Map<String, dynamic> map}) {
    id = map['id'];
    name = map['name'];
    price = map['price'];
  }

  /// Este metodo codifica este [Job] em um [Map].
  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}
