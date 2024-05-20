import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sportapp_movil/constants.dart';
import 'package:sportapp_movil/datamanager.dart';

class SociosService {
  Future<bool> createCita(String fecha, String agenda) async {
    Map<String, dynamic> data = {};
    data['id_deportista'] = DataManager().getUserId();
    data['fecha_cita'] = fecha;
    data['tipo_agenda'] = agenda;
    final url = '$baseUrl/socios/cita-deportologo';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    print(data);
    print(response.body);
    if (response.statusCode == 201) {
      return true;
    } else {
      print("10Request failed with status: ${response.statusCode}");
      return false;
    }
  }
}
