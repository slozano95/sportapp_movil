import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sportapp_movil/constants.dart';
import 'package:sportapp_movil/services/models/entrenamiento_api_model.dart';
import 'package:sportapp_movil/services/models/simulator_api_model.dart';

class SimulatorService {
  Future<SimulatorApiModel?> getAll(http.Client client) async {
    print("CALLING SIMULATOR SERVICE");
    final url = '$baseUrl/simulator/1';

    final response = await client.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return SimulatorApiModel.fromJson(json.decode(response.body));
    } else {
      print("4Request failed with status: ${response.statusCode}");
      return null;
    }
  }
}
