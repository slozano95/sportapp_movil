class EventosApiModel {
  bool? estadoSuscripcion;
  Evento? evento;
  String? fechaSuscripcion;
  String? idEvento;
  String? idUsuario;
  String? idUsuarioEvento;

  EventosApiModel({
    this.estadoSuscripcion,
    this.evento,
    this.fechaSuscripcion,
    this.idEvento,
    this.idUsuario,
    this.idUsuarioEvento,
  });

  factory EventosApiModel.fromJson(Map<String, dynamic> json) =>
      EventosApiModel(
        estadoSuscripcion: json["estado_suscripcion"],
        evento: json["evento"] == null ? null : Evento.fromJson(json["evento"]),
        fechaSuscripcion: json["fecha_suscripcion"],
        idEvento: json["id_evento"],
        idUsuario: json["id_usuario"],
        idUsuarioEvento: json["id_usuario_evento"],
      );

  Map<String, dynamic> toJson() => {
        "estado_suscripcion": estadoSuscripcion,
        "evento": evento?.toJson(),
        "fecha_suscripcion": fechaSuscripcion,
        "id_evento": idEvento,
        "id_usuario": idUsuario,
        "id_usuario_evento": idUsuarioEvento,
      };
}

class Evento {
  String? descripcion;
  bool? estado;
  String? fechaEvento;
  String? idEvento;
  String? idSocio;
  String? lugar;
  String? nivel;
  String? nombre;

  Evento({
    this.descripcion,
    this.estado,
    this.fechaEvento,
    this.idEvento,
    this.idSocio,
    this.lugar,
    this.nivel,
    this.nombre,
  });

  factory Evento.fromJson(Map<String, dynamic> json) => Evento(
        descripcion: json["descripcion"],
        estado: json["estado"],
        fechaEvento: json["fecha_evento"],
        idEvento: json["id_evento"],
        idSocio: json["id_socio"],
        lugar: json["lugar"],
        nivel: json["nivel"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "estado": estado,
        "fecha_evento": fechaEvento,
        "id_evento": idEvento,
        "id_socio": idSocio,
        "lugar": lugar,
        "nivel": nivel,
        "nombre": nombre,
      };
}
