import 'package:flutter/material.dart';
import 'package:sportapp_movil/UI/colors.dart';
import 'package:sportapp_movil/current_session_view.dart';
import 'package:sportapp_movil/login_view.dart';
import 'package:sportapp_movil/plan_selector_view.dart';
import 'package:sportapp_movil/schedule_deportologo.dart';
import 'package:sportapp_movil/training_exercises_view.dart';

import 'UI/components.dart';

// ignore: must_be_immutable
class TrainingPlanView extends StatefulWidget {
  TrainingPlanView({super.key});

  @override
  _TrainingPlanViewState createState() => _TrainingPlanViewState();
}

class _TrainingPlanViewState extends State<TrainingPlanView> {
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
              Spacer(),
              GestureDetector(
                  onTap: () {
                    goToAddExercises();
                  },
                  child: Container(
                      key: Key("icon_add"),
                      width: 30,
                      height: 30,
                      child: const Image(
                          image: AssetImage("assets/icon_add.png"), width: 30)))
            ],
          )),
      Expanded(
          child: Container(
              padding: const EdgeInsets.all(38),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Plan de Entrenamiento", style: AppTypography.heading),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        Expanded(
                            child: activityCell(
                                "Ciclismo", "assets/plan_ciclismo.png"))
                      ],
                    ),
                    const SizedBox(height: 55),
                    Row(
                      children: [
                        Expanded(
                            child: activityCell(
                                "Atletismo", "assets/plan_atletismo.png"))
                      ],
                    )
                  ]))),
      UIComponents.tabBar(context, TabItem.home)
    ])));
  }

  Widget activityCell(String name, String image) {
    return GestureDetector(
        onTap: () {
          goToCurrentSession();
        },
        child: Container(
            height: 200,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(name, style: AppTypography.body),
              SizedBox(height: 25),
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(image),
                          ))))
            ])));
  }

  void signOut() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }

  void goToScheduleDeportologo() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScheduleDeportologo()),
    );
  }

  void goToCurrentSession() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CurrentSessionView()),
    );
  }

  void goBack() {
    Navigator.of(context).pop();
  }

  void goToAddExercises() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TrainingExercisesView()),
    );
  }
}
