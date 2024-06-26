import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sportapp_movil/constants.dart';
import 'package:sportapp_movil/services/models/exercises_api_model.dart';

class ExercisesService {
  Future<List<ExercisesApiModel>> getAll(http.Client client) async {
    final url = '${baseUrl}/ejercicios/all';
    final response = await client.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = List<ExercisesApiModel>.from(
          json.decode(response.body).map((x) => ExercisesApiModel.fromJson(x)));
      // print("Request successful getAll exercises");
      // print(response.body);
      return data;
    } else {
      print("3Request failed with status: ${response.statusCode}");
      return [];
    }
  }
}
