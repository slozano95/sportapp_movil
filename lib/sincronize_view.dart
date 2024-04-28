import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportapp_movil/UI/colors.dart';
import 'package:sportapp_movil/UI/components.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sportapp_movil/current_session_view.dart';
import 'package:sportapp_movil/datamanager.dart';
import 'package:sportapp_movil/login_view.dart';
import 'package:sportapp_movil/schedule_deportologo.dart';
import 'package:sportapp_movil/strava_connected.dart';
import 'package:sportapp_movil/strava_connection.dart';
import 'package:sportapp_movil/training_exercises_view.dart';

class SincronizeView extends StatefulWidget {
  @override
  _SincronizeViewState createState() => _SincronizeViewState();
}

class _SincronizeViewState extends State<SincronizeView> {
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
                    signOut();
                  },
                  child: Container(
                      width: 30,
                      height: 30,
                      key: Key("icon_back"),
                      color: Colors.transparent,
                      child: const Image(
                          image: AssetImage("assets/icon_logout.png"),
                          width: 30))),
              Spacer(),
            ],
          )),
      Expanded(
          child: Container(
              padding: const EdgeInsets.all(38),
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    Text("Sincronizar", style: AppTypography.heading),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              goToStravaConnect();
                            },
                            child: Image.asset(
                              "assets/logo_strava.png",
                              width: 90,
                              key: Key("strava_logo"),
                            ))
                      ],
                    )
                  ])))),
      UIComponents.tabBar(context, TabItem.book)
    ])));
  }

  void signOut() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }

  void goToStravaConnect() {
    var code = DataManager().stravaCode;
    if (code != "") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StravaConnectedView()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StravaConnectionView()),
      );
    }
  }
}
