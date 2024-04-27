import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sportapp_movil/constants.dart';
import 'package:sportapp_movil/services/models/entrenamiento_api_model.dart';

class EntrenamientoService {
  Future<List<EntrenamientosModel>> getAll() async {
    final url = '$baseUrl/entrenamientos/user/$id_user';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = List<EntrenamientosModel>.from(json
          .decode(response.body)
          .map((x) => EntrenamientosModel.fromJson(x)));
      // print("Request successful getAll exercises");
      // print(response.body);
      return data;
    } else {
      print("1Request failed with status: ${response.statusCode}");
      return [];
    }
  }
}
