import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sportapp_movil/constants.dart';
import 'package:sportapp_movil/datamanager.dart';
import 'package:sportapp_movil/services/models/entrenamiento_api_model.dart';
import 'package:sportapp_movil/services/models/entrenamiento_completado_api_model.dart';

class EntrenamientoService {
  Future<List<EntrenamientosModel>> getAll(http.Client client) async {
    final url = '$baseUrl/entrenamientos/user/${DataManager().getUserId()}';
    final response = await client.get(
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

  Future<int> getCompletados(http.Client client) async {
    var diasAtras = DateTime.now().day;
    diasAtras = 30;
    final url =
        '$baseUrl/entrenamientos/user/completados/${DataManager().getUserId()}/$diasAtras';
    final response = await client.get(
      Uri.parse(url),
      headers: headers,
    );
    if (response.statusCode == 200) {
      var data =
          EntrenamientoCompletadoApiModel.fromJson(json.decode(response.body));
      return data.completados ?? 0;
    } else {
      print("0Request failed with status: ${response.statusCode}");
      return 0;
    }
  }
}
