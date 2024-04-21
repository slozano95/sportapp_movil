import 'package:flutter/material.dart';
import 'package:sportapp_movil/UI/colors.dart';
import 'package:sportapp_movil/plan_selector_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sportapp_movil/animation_monitoring.dart';

import 'UI/components.dart';

class HeartMonitoring extends StatefulWidget {
  const HeartMonitoring({super.key});

  @override
  _HeartMonitoringState createState() => _HeartMonitoringState();
}

class _HeartMonitoringState extends State<HeartMonitoring> {
  bool _isSessionActive = false;
  bool _isSessionEnded = false;
  bool _isRunning = false;

  int _heartRate = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Container(
          padding: const EdgeInsets.fromLTRB(38, 12, 0, 0),
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
                          width: 30)))
            ],
          )),
      Expanded(
          child: Container(
              padding: const EdgeInsets.all(38),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.plan_medio,
                        style: AppTypography.heading,
                        textAlign: TextAlign.start),
                    const SizedBox(height: 40),
                    Text(AppLocalizations.of(context)!.menu_ritmo,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 60),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                          height: 54,
                          child: Center(
                              child: AnimationMonitoring(isRunning: _isRunning)
                                  ))
                    ]),
                     const SizedBox(height: 90),
                    !_isSessionEnded
                    ?
                    Center(
                       
                            child: UIComponents.button(
                                _isSessionActive
                                    ? AppLocalizations.of(context)!.heart_start
                                    : AppLocalizations.of(context)!.heart_start, () {
                            toggleSession();
                          }))
                     :  Center(
                                child:
                                    UIComponents.button(AppLocalizations.of(context)!.heart_stop, () {
                              //TODO
                            })),
                  ])
                  )),
      UIComponents.tabBar(context, TabItem.home)
    ])));
  }

  void goBack() {
    Navigator.of(context).pop();
  }

  String getHeartrateValue() {
    return _heartRate.toString();
  }

  void startStopwatch() {
    _heartRate = 120;
    _isRunning = true;
    //_simulateHeartRate();

  }



   void toggleSession() {
    _isSessionActive = !_isSessionActive;
    if (!_isSessionActive) {
      setState(() {
        _isSessionEnded = true;
      });
    } else {
      startStopwatch();
    }
  }

} 

