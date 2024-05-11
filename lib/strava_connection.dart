import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportapp_movil/UI/colors.dart';
import 'package:sportapp_movil/UI/components.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sportapp_movil/current_session_view.dart';
import 'package:sportapp_movil/datamanager.dart';
import 'package:sportapp_movil/login_view.dart';
import 'package:sportapp_movil/schedule_deportologo.dart';
import 'package:sportapp_movil/services/strava_service.dart';
import 'package:sportapp_movil/strava_connected.dart';
import 'package:sportapp_movil/training_exercises_view.dart';
import 'package:sportapp_movil/web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StravaConnectionView extends StatefulWidget {
  @override
  _StravaConnectionViewState createState() => _StravaConnectionViewState();
}

class _StravaConnectionViewState extends State<StravaConnectionView> {
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
                    const Text(
                      "Puedes compartir tus actividades con Strava  vinculando\ntu cuenta\n\n¿Deseas establecer una conexion con Strava?\n\nAl establecer una conexión con Strava, aceptas compartir la información de tu cuenta para mejorar tu experincia con Strava. Esto puede incluir actividades, ubicación, calorias, ritmo cardiaco y otra información relevante.",
                    ),
                    const SizedBox(height: 20),
                    const Text(
                        "¿Aceptas compartir la informacón de tu cuenta de SportApp con Strava?\n\nPuedes retirar este consentimiento y dejar de estar conectado a Strava en cualquier momento desde el menu de Strava"),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                                onTap: () {
                                  openModalWithWebview();
                                },
                                child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: AppColors.orange,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Center(
                                        child: Text("Aceptar",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: AppColors.white,
                                                fontWeight:
                                                    FontWeight.w700)))))),
                        const SizedBox(width: 30),
                        Expanded(
                            child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: AppColors.orange,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Center(
                                        child: Text("Cancelar",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: AppColors.white,
                                                fontWeight:
                                                    FontWeight.w700))))))
                      ],
                    )
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
      StravaService().getToken(DataManager().client, false);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StravaConnectedView()),
      );
    }
  }
}
