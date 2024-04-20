import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sportapp_movil/UI/colors.dart';
import 'package:sportapp_movil/plan_selector_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'UI/components.dart';

class CurrentSessionView extends StatefulWidget {
  CurrentSessionView({super.key, this.title = ""});
  String title = "";
  @override
  _CurrentSessionViewState createState() => _CurrentSessionViewState();
}

class _CurrentSessionViewState extends State<CurrentSessionView> {
  bool _isSessionActive = false;
  bool _isSessionEnded = false;

  Stopwatch? _stopwatch;
  Timer? _viewTimer;
  Timer? _heartRateTimer;
  int _totalCals = 0;
  int _activeCals = 0;
  int _totalCalsRate = 500;
  int _activeCalsRate = 2;
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
              width: double.infinity,
              padding: const EdgeInsets.all(38),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title,
                        style: AppTypography.heading,
                        textAlign: TextAlign.start),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        getCurrentTimerValue(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          getActiveCaloriesValue(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 32),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context)!.entr_cals_activas,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        ),
                        const SizedBox(width: 40),
                        Text(
                          getTotalCaloriesValue(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 32),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context)!.entr_cals,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(getHeartrateValue(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 32)),
                      const SizedBox(width: 10),
                      Container(
                          height: 54,
                          child: const Center(
                              child: Image(
                                  image:
                                      AssetImage("assets/icon_heartbeat.png"),
                                  width: 35)))
                    ]),
                    const SizedBox(height: 50),
                    !_isSessionEnded
                        ? SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                getFTPValue(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 32),
                              ),
                              const SizedBox(width: 10),
                               Text(
                                AppLocalizations.of(context)!.entr_ftp,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15),
                              ),
                              const SizedBox(width: 40),
                              Text(
                                getVO2Max(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 32),
                              ),
                              const SizedBox(width: 10),
                               Text(
                                AppLocalizations.of(context)!.entr_max,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                    const SizedBox(height: 50),
                    !_isSessionEnded
                        ? Center(
                            child: UIComponents.button(
                                _isSessionActive
                                    ? AppLocalizations.of(context)!.entr_end_session
                                    : AppLocalizations.of(context)!.entr_start_session, () {
                            toggleSession();
                          }))
                        : Column(children: [
                            Center(
                                child:
                                    UIComponents.button(AppLocalizations.of(context)!.entr_plan_nutricional, () {
                              //TODO
                            })),
                            const SizedBox(height: 34),
                            Center(
                                child: UIComponents.button(
                                    AppLocalizations.of(context)!.entr_plan_recuperacion,
                                     () {
                              //TODO
                            }))
                          ])
                  ]))),
      UIComponents.tabBar(context, TabItem.home)
    ])));
  }

  void goBack() {
    Navigator.of(context).pop();
  }

  void saveSession() {
    //SHow sucess modal
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(AppLocalizations.of(context)!.dep_exitoso),
          content: Text(AppLocalizations.of(context)!.dep_exitoso_desc),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => PlanSelector()),
    // );
  }

  void openCalendar() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
  }

  String getCurrentTimerValue() {
    return getFormattedText();
  }

  String getFormattedText() {
    var milli = _stopwatch?.elapsed.inMilliseconds ?? 0;

    String milliseconds = (milli % 1000).toString().padLeft(3, "0");
    String seconds = ((milli ~/ 1000) % 60).toString().padLeft(2, "0");
    String minutes = ((milli ~/ 1000) ~/ 60).toString().padLeft(2, "0");
    return "$minutes:$seconds:$milliseconds";
  }

  String getActiveCaloriesValue() {
    return _activeCals.toString();
  }

  String getTotalCaloriesValue() {
    return _totalCals.toString();
  }

  String getHeartrateValue() {
    return _heartRate.toString();
  }

  void startStopwatch() {
    _totalCals = 0;
    _activeCals = 0;
    _heartRate = 120;
    _viewTimer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
      var random = Random().nextInt(_totalCalsRate);
      if (random == 0) {
        incrementCalories();
      }
    });
    _stopwatch = Stopwatch();
    _stopwatch?.start();
    _simulateHeartRate();
  }

  void stopStopwatch() {
    _viewTimer?.cancel();
    _heartRateTimer?.cancel();
    _stopwatch?.stop();
  }

  void toggleSession() {
    _isSessionActive = !_isSessionActive;
    if (!_isSessionActive) {
      stopStopwatch();
      setState(() {
        _isSessionEnded = true;
      });
    } else {
      startStopwatch();
    }
  }

  void incrementCalories() {
    var random = Random().nextInt(_activeCalsRate);
    if (random == 0) {
      _activeCals += 1;
    }
    _totalCals += 1;
  }

  void _simulateHeartRate() {
    _heartRateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      var randomInit = Random().nextInt(2);
      if (_heartRate >= 160) {
        _heartRate = _heartRate - Random().nextInt(10);
      } else if (_heartRate <= 70) {
        _heartRate = _heartRate + Random().nextInt(10);
      } else {
        _heartRate =
            _heartRate + (Random().nextInt(5) * (randomInit == 0 ? -1 : 1));
      }
    });
  }

  String getVO2Max() {
    return (Random().nextInt(20) + 50).toString();
  }

  String getFTPValue() {
    return (Random().nextInt(20) + 100).toString();
  }
}
