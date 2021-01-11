class Scheduling {
  Scheduling({this.customerId, this.scheduleId, this.jobId});

  int customerId;
  int scheduleId;
  int jobId;

  /// Atribui os valores dos parametros deste [Scheduling] dado um [Map].
  Scheduling.fromMap({Map<String, dynamic> map}) {
    customerId = map['customerId'];
    scheduleId = map['scheduleId'];
    jobId = map['jobId'];
  }

  /// Este metodo codifica este [Schedule] em um [Map].
  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['customerId'] = customerId;
    data['scheduleId'] = scheduleId;
    data['jobId'] = jobId;
    return data;
  }
}
