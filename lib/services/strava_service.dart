import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sportapp_movil/constants.dart';
import 'package:sportapp_movil/datamanager.dart';
import 'package:sportapp_movil/services/models/exercises_api_model.dart';
import 'package:sportapp_movil/services/models/strava_token_api_model.dart';

class StravaService {
  Future<StravaTokenApiModel?> getToken() async {
    const url = 'https://www.strava.com/oauth/token';
    final response = await http.post(Uri.parse(url),
        headers: headers,
        body: json.encode({
          'client_id': '125569',
          'client_secret': 'b07b595cbb16ee1df30d46fe2970225c4d903438',
          'code': DataManager().stravaCode,
          'grant_type': 'authorization_code'
        }));

    if (response.statusCode == 200) {
      var data = StravaTokenApiModel.fromJson(json.decode(response.body));
      return data;
    } else {
      print("Request failed with status: ${response.statusCode}");
      return null;
    }
  }
}
