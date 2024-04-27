class DeportistaApiModel {
  double? altura;
  String? deportePracticar;
  int? edad;
  DateTime? fechaCreacion;
  String? genero;
  String? idUsuario;
  double? pesoActual;
  double? pesoInicial;

  DeportistaApiModel({
    this.altura,
    this.deportePracticar,
    this.edad,
    this.fechaCreacion,
    this.genero,
    this.idUsuario,
    this.pesoActual,
    this.pesoInicial,
  });

  factory DeportistaApiModel.fromJson(Map<String, dynamic> json) =>
      DeportistaApiModel(
        altura: json["altura"]?.toDouble(),
        deportePracticar: json["deporte_practicar"],
        edad: json["edad"],
        fechaCreacion: json["fecha_creacion"] == null
            ? null
            : DateTime.parse(json["fecha_creacion"]),
        genero: json["genero"],
        idUsuario: json["id_usuario"],
        pesoActual: json["peso_actual"],
        pesoInicial: json["peso_inicial"],
      );

  Map<String, dynamic> toJson() => {
        "altura": altura,
        "deporte_practicar": deportePracticar,
        "edad": edad,
        "fecha_creacion": fechaCreacion?.toIso8601String(),
        "genero": genero,
        "id_usuario": idUsuario,
        "peso_actual": pesoActual,
        "peso_inicial": pesoInicial,
      };
}
