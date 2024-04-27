class SimulatorApiModel {
  int heartRate;
  String id;
  int lastHeartRate;
  String maxCambio;
  String maxHeartrate;
  String minCambio;
  String minHeartrate;

  SimulatorApiModel({
    required this.heartRate,
    required this.id,
    required this.lastHeartRate,
    required this.maxCambio,
    required this.maxHeartrate,
    required this.minCambio,
    required this.minHeartrate,
  });

  factory SimulatorApiModel.fromJson(Map<String, dynamic> json) =>
      SimulatorApiModel(
        heartRate: json["heart_rate"],
        id: json["id"],
        lastHeartRate: json["last_heart_rate"],
        maxCambio: json["max_cambio"],
        maxHeartrate: json["max_heartrate"],
        minCambio: json["min_cambio"],
        minHeartrate: json["min_heartrate"],
      );

  Map<String, dynamic> toJson() => {
        "heart_rate": heartRate,
        "id": id,
        "last_heart_rate": lastHeartRate,
        "max_cambio": maxCambio,
        "max_heartrate": maxHeartrate,
        "min_cambio": minCambio,
        "min_heartrate": minHeartrate,
      };
}
