class ExercisesApiModel {
  bool? estado;
  String? idEjercicio;
  String? nombre;
  String? urlImagen;

  ExercisesApiModel({
    this.estado,
    this.idEjercicio,
    this.nombre,
    this.urlImagen,
  });

  factory ExercisesApiModel.fromJson(Map<String, dynamic> json) =>
      ExercisesApiModel(
        estado: json["estado"],
        idEjercicio: json["id_ejercicio"],
        nombre: json["nombre"],
        urlImagen: json["url_imagen"],
      );

  Map<String, dynamic> toJson() => {
        "estado": estado,
        "id_ejercicio": idEjercicio,
        "nombre": nombre,
        "url_imagen": urlImagen,
      };
}
