import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportapp_movil/UI/colors.dart';
import 'package:sportapp_movil/UI/components.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sportapp_movil/current_session_view.dart';
import 'package:sportapp_movil/datamanager.dart';
import 'package:sportapp_movil/login_view.dart';
import 'package:sportapp_movil/schedule_deportologo.dart';
import 'package:sportapp_movil/training_exercises_view.dart';
import 'package:sportapp_movil/web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StravaConnectedView extends StatefulWidget {
  @override
  _StravaConnectionViewState createState() => _StravaConnectionViewState();
}

class _StravaConnectionViewState extends State<StravaConnectedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Container(
          padding: const EdgeInsets.fromLTRB(38, 12, 38, 0),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    goBack();
                  },
                  child: Container(
                      width: 30,
                      height: 30,
                      key: Key("icon_back"),
                      color: Colors.transparent,
                      child: const Image(
                          image: AssetImage("assets/icon_back.png"),
                          width: 30))),
              Spacer()
            ],
          )),
      Expanded(
          child: Container(
              padding: const EdgeInsets.all(38),
              child: SingleChildScrollView(
                  child: Container(
                      // color: Colors.red[100],
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                    Image.asset("assets/icon_strava.png", width: 120),
                    const SizedBox(height: 40),
                    const Text("Estas conectado con Strava",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 20),
                    const Text(
                        "¿Desconectarte de Strava?\n\nActualmente, SportApp comparte tu infomación con Strava, Esto puede incluir actividades, ubicación, calorias.\nAl desconectarse de Strava, retiras tu consentimiento para compartir información. los datos compartidos con aterioridad con Strava no se veran afectados."),
                    const SizedBox(height: 40),
                    UIComponents.button("Desconectar", () => {disconnect()}),
                  ]))))),
      UIComponents.tabBar(context, TabItem.book)
    ])));
  }

  void goBack() {
    Navigator.pop(context);
  }

  void goToStravaConnect() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScheduleDeportologo()),
    );
  }

  void openModalWithWebview() async {
    var code = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WebView()),
    );
    if ((code as String) != "") {
      print("CODE FROM STRAVA: $code");
      DataManager().stravaCode = code;
    }
  }

  void disconnect() {
    DataManager().stravaCode = "";
    Navigator.pop(context);
  }
}
