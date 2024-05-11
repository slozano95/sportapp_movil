import 'package:sportapp_movil/datamanager.dart';

var baseUrl =
    "http://a30e8ad80d7ce496f87c317e39919031-393841883.us-east-1.elb.amazonaws.com";
var id_user = DataManager().userId ?? "";
Map<String, String> headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${DataManager().loginAccessToken}'
};
