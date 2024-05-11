import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sportapp_movil/constants.dart';
import 'package:sportapp_movil/services/models/entrenamiento_api_model.dart';
import 'package:sportapp_movil/services/models/simulator_api_model.dart';

class OTPService {
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
          json.decode(response.body)["AuthenticationResult"]["expiresIn"];
      return true;
    } else {
      //FAILED
      print("42Request failed with status: ${response.statusCode}");
      return false;
    }
  }
}
