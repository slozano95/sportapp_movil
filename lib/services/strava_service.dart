import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sportapp_movil/constants.dart';
import 'package:sportapp_movil/datamanager.dart';
import 'package:sportapp_movil/services/models/exercises_api_model.dart';
import 'package:sportapp_movil/services/models/strava_activity_api_model.dart';
import 'package:sportapp_movil/services/models/strava_new_activity_api_model.dart';
import 'package:sportapp_movil/services/models/strava_token_api_model.dart';

class StravaService {
  Future<StravaTokenApiModel?> getToken(bool shouldRefreshToken) async {
    const url = 'https://www.strava.com/oauth/token';
    var body = json.encode({
      'client_id': '125569',
      'client_secret': 'b07b595cbb16ee1df30d46fe2970225c4d903438',
      'code': DataManager().stravaCode,
      'grant_type': 'authorization_code'
    });
    if (shouldRefreshToken) {
      body = json.encode({
        'client_id': '125569',
        'client_secret': 'b07b595cbb16ee1df30d46fe2970225c4d903438',
        'refresh_token': DataManager().stravaRefreshToken,
        'grant_type': 'refresh_token'
      });
    }
    print(body);
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      var data = StravaTokenApiModel.fromJson(json.decode(response.body));
      DataManager().stravaToken = data.accessToken ?? "";
      DataManager().stravaRefreshToken = data.refreshToken ?? "";
      DataManager().expiresAt = data.expiresAt ?? 0;
      DataManager().saveData();
      DateTime now = DateTime.now();

      int epochTime = now.millisecondsSinceEpoch ~/ 1000;
      print('Epoch time: $epochTime');
      print('Expire epoch time: ${DataManager().expiresAt}');
      return data;
    } else {
      print("5Request failed with status: ${response.statusCode}");
      return null;
    }
  }

  Future<bool> addActivity(StravaNewActivityApiModel model) async {
    print("SENDING ACTIVITY ${model.id}");
    const url = 'https://www.strava.com/api/v3/activities';
    var headers2 = headers;
    headers2['Authorization'] = 'Bearer ${DataManager().stravaToken}';

    final response = await http.post(Uri.parse(url),
        headers: headers2, body: json.encode(model.toJson()));
    print(response.body);
    if (response.statusCode == 201) {
      print("REMOVE ACTIVITY ${model.id}");
      // DataManager().allPendingActivities.remove(model);
      return true;
    } else {
      print("6Request failed with status: ${response.statusCode}");
      return false;
    }
  }

  Future<void> getActivities() async {
    const url = 'https://www.strava.com/api/v3/athlete/activities?per_page=100';
    var headers2 = headers;
    headers2['Authorization'] = 'Bearer ${DataManager().stravaToken}';

    final response = await http.get(Uri.parse(url), headers: headers2);
    print(response.body);
    if (response.statusCode == 200) {
      var data = List<StravaNewActivityApiModel>.from(json
          .decode(response.body)
          .map((x) => StravaNewActivityApiModel.fromJson(x)));
      DataManager().stravaActivities = data;
      return;
    } else {
      print("7Request failed with status: ${response.statusCode}");
      return;
    }
  }
}
