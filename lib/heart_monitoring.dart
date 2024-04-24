import 'dart:async';


import 'package:flutter/material.dart';
import 'package:sportapp_movil/UI/colors.dart';
import 'package:sportapp_movil/datamanager.dart';
import 'package:sportapp_movil/plan_selector_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sportapp_movil/animation_monitoring.dart';
import 'package:sportapp_movil/services/models/simulator_api_model.dart';

import 'UI/components.dart';

class HeartMonitoring extends StatefulWidget {
  const HeartMonitoring({super.key});

  @override
  _HeartMonitoringState createState() => _HeartMonitoringState();
}

class _HeartMonitoringState extends State<HeartMonitoring> {
  bool _isSessionActive = false;
  bool _isSessionEnded = true;
  bool _isRunning = false;
  String _heartRate = "Loading ...";
  Timer? _timer;
  int counter = 1;

  SimulatorApiModel? jsonValue;

  @override
  void initState() {
    super.initState();
    initTimer();
  }

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
                    GestureDetector(
                        onTap: () {
                          addCount();
                        },
                        child: Container(
                            color: Colors.transparent,
                            child: Text(
                                AppLocalizations.of(context)!.menu_ritmo,
                                style: AppTypography.heading,
                                textAlign: TextAlign.start))),
                    const SizedBox(height: 60),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(
                          height: 54,
                          child: Center(
                              child:
                                  AnimationMonitoring(isRunning: _isRunning)))
                    ]),
                    const SizedBox(height: 90),
                    _isRunning
                        ? Column(children: [
                            Center(
                                child: Text("Actual",
                                    style: TextStyle(fontSize: 20))),
                            Center(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                  Text(_heartRate.toString(),
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 40,
                                      )),
                                  const Text("BPM",
                                      style: TextStyle(fontSize: 14))
                                ]))
                          ])
                        : SizedBox(),
                    const SizedBox(height: 20),
                    _isSessionEnded
                        ? Center(
                            child: UIComponents.button(
                                AppLocalizations.of(context)!.heart_start, () {
                            startSession();
                          }))
                        : Center(
                            child: UIComponents.button(
                                AppLocalizations.of(context)!.heart_stop, () {
                            stopSession();
                          })),
                    SizedBox(height: 40),
                    (counter % 7 == 0)
                        ? Text(jsonValue?.toJson().toString() ?? "")
                        : SizedBox()
                  ]))),
      UIComponents.tabBar(context, TabItem.home)
    ])));
  }

  void goBack() {
    Navigator.of(context).pop();
  }

  String getHeartrateValue() {
    return _heartRate.toString();
  }

  void startSession() {
    setState(() {
      _isSessionActive = true;
      _isSessionEnded = false;
      _isRunning = true;
    });
  }

  void stopSession() {
    setState(() {
      _isSessionActive = false;
      _isSessionEnded = true;
      _isRunning = false;
    });
  }

  void initTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_isRunning) {
        print("CALLING");
        DataManager().getHeartRate().then((value) {
          jsonValue = value;
          setState(() {
            _heartRate = value?.heartRate.toString() ?? "Loading...";
          });
        });
      }
    });
  }

  void addCount() {
    setState(() {
      counter++;
    });
  }
}
