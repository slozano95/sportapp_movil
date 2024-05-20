import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sportapp_movil/constants.dart';
import 'package:sportapp_movil/datamanager.dart';
import 'package:sportapp_movil/services/models/deportista_api_model.dart';
import 'package:sportapp_movil/services/models/entrenamiento_api_model.dart';
import 'package:sportapp_movil/services/models/entrenamiento_completado_api_model.dart';

class DeportistaService {
  Future<DeportistaApiModel?> getData() async {
    final url = '$baseUrl/deportista/${DataManager().getUserId()}';
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    if (response.statusCode == 200) {
      var data = DeportistaApiModel.fromJson(json.decode(response.body));
      return data;
    } else {
      print("0Request failed with status: ${response.statusCode}");
      return null;
    }
  }
}
