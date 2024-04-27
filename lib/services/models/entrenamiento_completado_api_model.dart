class EntrenamientoCompletadoApiModel {
  int? completados;

  EntrenamientoCompletadoApiModel({
    this.completados,
  });

  factory EntrenamientoCompletadoApiModel.fromJson(Map<String, dynamic> json) =>
      EntrenamientoCompletadoApiModel(
        completados: json["completados"],
      );

  Map<String, dynamic> toJson() => {
        "completados": completados,
      };
}

class EventosAsistidosApiModel {
  int? asistio;

  EventosAsistidosApiModel({
    this.asistio,
  });

  factory EventosAsistidosApiModel.fromJson(Map<String, dynamic> json) =>
      EventosAsistidosApiModel(
        asistio: json["asistio"],
      );

  Map<String, dynamic> toJson() => {
        "asistio": asistio,
      };
}
