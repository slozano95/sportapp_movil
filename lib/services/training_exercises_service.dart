import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sportapp_movil/constants.dart';
import 'package:sportapp_movil/datamanager.dart';

class TrainingExercisesService {
  Future<bool> callCreate(
      String nombre, String fecha, Map<String, int> exerciseCount) async {
    Map<String, dynamic> data = {};
    data['id_usuario'] = id_user;
    data['estado'] = true;
    data['nombre'] = nombre;
    data['fecha_entrenamiento'] = fecha;
    data['ejercicios'] = [];
    exerciseCount.removeWhere((key, value) => value == 0);
    exerciseCount.forEach((key, value) {
      data['ejercicios'].add({
        "estado": true,
        "id_ejercicio": DataManager()
            .allExercises
            .firstWhere((element) => element.nombre == key)
            .idEjercicio,
        "nombre": key,
        "url_imagen": DataManager()
            .allExercises
            .firstWhere((element) => element.nombre == key)
            .urlImagen,
        "numero_repeticiones": value.toString()
      });
    });
    print(data);
    final url = '${baseUrl}/entrenamientos';
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      print("Request successful");
      print(response.body);
      return true;
    } else {
      print("Request failed with status: ${response.statusCode}");
      return false;
    }
  }
}
