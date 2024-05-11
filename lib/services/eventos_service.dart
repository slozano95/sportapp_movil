import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sportapp_movil/constants.dart';
import 'package:sportapp_movil/services/models/entrenamiento_completado_api_model.dart';
import 'package:sportapp_movil/services/models/eventos_api_model.dart';

class EventosService {
  Future<List<EventosApiModel>> getAll(http.Client client) async {
    final url = '$baseUrl/eventos/user/$id_user';
    final response = await client.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = List<EventosApiModel>.from(
          json.decode(response.body).map((x) => EventosApiModel.fromJson(x)));
      // print("Request successful getAll exercises");

      return data;
    } else {
      print("2Request failed with status: ${response.statusCode}");
      return [];
    }
  }

  Future<int> getAsistidos(http.Client client) async {
    var diasAtras = DateTime.now().day;
    diasAtras = 30;
    final url = '$baseUrl/eventos/user/asistio/$id_user/$diasAtras';
    final response = await client.get(
      Uri.parse(url),
      headers: headers,
    );
    if (response.statusCode == 200) {
      var data = EventosAsistidosApiModel.fromJson(json.decode(response.body));
      return data.asistio ?? 0;
    } else {
      print("0Request failed with status: ${response.statusCode}");
      return 0;
    }
  }
}
