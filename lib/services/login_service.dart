import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sportapp_movil/constants.dart';
import 'package:sportapp_movil/datamanager.dart';
import 'package:sportapp_movil/services/models/entrenamiento_api_model.dart';
import 'package:sportapp_movil/services/models/simulator_api_model.dart';

class SecurityService {
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

  Future<bool> sendOtp(
      http.Client client, String email, String session, String otp) async {
    print("CALLING OTP SERVICE");
    final url = '$baseUrl/security/desafio-mfa';

    final response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode({"email": email, "session": session, "mfa_code": otp}),
    );

    if (response.statusCode == 200) {
      //LOGIN OK
      var accessToken =
          json.decode(response.body)["AuthenticationResult"]["AccessToken"];
      var refreshToken =
          json.decode(response.body)["AuthenticationResult"]["RefreshToken"];
      var expiresIn =
          json.decode(response.body)["AuthenticationResult"]["ExpiresIn"];
      //DataManager().setSession(accessToken, refreshToken, expiresIn);
      await getMe(client, accessToken, refreshToken, expiresIn);
      return true;
    } else {
      //FAILED
      print("42Request failed with status: ${response.statusCode}");
      return false;
    }
  }

  Future<void> getMe(
      http.Client client, accessToken, refreshToken, expiresIn) async {
    print("CALLING ME SERVICE");
    final url = '$baseUrl/security/me';
    final response = await client.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      //LOGIN OK
      var userId = json.decode(response.body)["Username"];
      DataManager().setSession(accessToken, refreshToken, expiresIn, userId);
      return;
    } else {
      //FAILED
      print("42Request failed with status: ${response.statusCode}");
      return;
    }
  }
}
