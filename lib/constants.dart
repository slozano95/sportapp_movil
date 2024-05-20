import 'package:sportapp_movil/datamanager.dart';

var baseUrl = "https://qii9n6y9h0.execute-api.us-east-1.amazonaws.com/prod";

Map<String, String> headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${DataManager().loginAccessToken}'
};

Map<String, String> getHeaders() {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${DataManager().loginAccessToken}'
  };
  return headers;
}
