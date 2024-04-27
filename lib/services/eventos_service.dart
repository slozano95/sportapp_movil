import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sportapp_movil/constants.dart';
import 'package:sportapp_movil/services/models/eventos_api_model.dart';

class EventosService {
  Future<List<EventosApiModel>> getAll() async {
    final url = '$baseUrl/eventos/user/$id_user';
    final response = await http.get(
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
}
