import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sportapp_movil/constants.dart';
import 'package:sportapp_movil/services/models/entrenamiento_api_model.dart';
import 'package:sportapp_movil/services/models/simulator_api_model.dart';

class LoginService {
  Future<String?> login(http.Client client, String admin, String pwd) async {
    print("CALLING LOGIN SERVICE");
    final url = '$baseUrl/security/login';

    final response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode({
        "username": admin,
        "password": pwd,
      }),
    );

    if (response.statusCode == 201) {
      //LOGIN
      return json.decode(response.body)["Session"];
    } else {
      //FAILED
      print("41Request failed with status: ${response.statusCode}");
      return null;
    }
  }
}
