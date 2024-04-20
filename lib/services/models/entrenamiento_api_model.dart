class EntrenamientosModel {
  List<Ejercicio>? ejercicios;
  bool? estado;
  String? fechaEntrenamiento;
  String? idEntrenamiento;
  String? idUsuario;
  String? nombre;

  EntrenamientosModel({
    this.ejercicios,
    this.estado,
    this.fechaEntrenamiento,
    this.idEntrenamiento,
    this.idUsuario,
    this.nombre,
  });

  factory EntrenamientosModel.fromJson(Map<String, dynamic> json) =>
      EntrenamientosModel(
        ejercicios: json["ejercicios"] == null
            ? []
            : List<Ejercicio>.from(
                json["ejercicios"]!.map((x) => Ejercicio.fromJson(x))),
        estado: json["estado"],
        fechaEntrenamiento: json["fecha_entrenamiento"],
        idEntrenamiento: json["id_entrenamiento"],
        idUsuario: json["id_usuario"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "ejercicios": ejercicios == null
            ? []
            : List<dynamic>.from(ejercicios!.map((x) => x.toJson())),
        "estado": estado,
        "fecha_entrenamiento": fechaEntrenamiento,
        "id_entrenamiento": idEntrenamiento,
        "id_usuario": idUsuario,
        "nombre": nombre,
      };
}

class Ejercicio {
  bool? estado;
  String? idEjercicio;
  String? nombre;
  int? numeroRepeticiones;
  String? urlImagen;

  Ejercicio({
    this.estado,
    this.idEjercicio,
    this.nombre,
    this.numeroRepeticiones,
    this.urlImagen,
  });

  factory Ejercicio.fromJson(Map<String, dynamic> json) => Ejercicio(
        estado: json["estado"],
        idEjercicio: json["id_ejercicio"],
        nombre: json["nombre"],
        numeroRepeticiones: json["numero_repeticiones"],
        urlImagen: json["url_imagen"],
      );

  Map<String, dynamic> toJson() => {
        "estado": estado,
        "id_ejercicio": idEjercicio,
        "nombre": nombre,
        "numero_repeticiones": numeroRepeticiones,
        "url_imagen": urlImagen,
      };
}
