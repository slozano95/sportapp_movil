import 'package:flutter/material.dart';
import 'package:sportapp_movil/UI/colors.dart';
import 'package:sportapp_movil/current_session_view.dart';
import 'package:sportapp_movil/login_view.dart';
import 'package:sportapp_movil/plan_selector_view.dart';
import 'package:sportapp_movil/schedule_deportologo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'UI/components.dart';

// ignore: must_be_immutable
class TrainingExercisesView extends StatefulWidget {
  TrainingExercisesView({super.key});

  @override
  _TrainingExercisesViewState createState() => _TrainingExercisesViewState();
}

class _TrainingExercisesViewState extends State<TrainingExercisesView> {
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
            ],
          )),
      Expanded(
          child: Container(
              padding: const EdgeInsets.all(38),
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(AppLocalizations.of(context)!.entr_add_title, style: AppTypography.heading),
                    const SizedBox(height: 40),
                          Text(AppLocalizations.of(context)!.entr_add_nombre,
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.grey),
                      child: const TextField(
                        decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 17),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 12)),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(AppLocalizations.of(context)!.entr_add_ejercicios, style: AppTypography.heading),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                            child: exerciseCell(
                                AppLocalizations.of(context)!.entr_add_pierna, "assets/exe_pierna.png", "3x 12"))
                      ],
                    ),
                    const SizedBox(height: 55),
                    Row(
                      children: [
                        Expanded(
                            child: exerciseCell(
                                AppLocalizations.of(context)!.entr_add_abdomen, "assets/exe_abdomen.png", "3x 12"))
                      ],
                    ),
                    const SizedBox(height: 55),
                    Row(
                      children: [
                        Expanded(
                            child: exerciseCell(
                                AppLocalizations.of(context)!.entr_add_lumbar, "assets/exe_lumbar.png", "3x 12"))
                      ],
                    ),
                    const SizedBox(height: 55),
                    Row(
                      children: [
                        Expanded(
                            child: exerciseCell(
                                AppLocalizations.of(context)!.entr_add_cardio, "assets/exe_cardio.png", "3x 12"))
                      ],
                    )
                  ])))),
      UIComponents.tabBar(context, TabItem.home)
    ])));
  }

  Widget exerciseCell(String name, String image, String description) {
    return GestureDetector(
        onTap: () {},
        child: SizedBox(
            height: 140,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(name, style: AppTypography.body),
              const SizedBox(height: 25),
              Expanded(
                  child: Row(children: [
                Image(image: AssetImage(image), width: 110, height: 140),
                const SizedBox(width: 50),
                Text(description, style: AppTypography.body),
                const Spacer(),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(AppLocalizations.of(context)!.entr_add_reps),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        UIComponents.step("-", () {}),
                        const SizedBox(width: 10),
                        Text("0", style: AppTypography.body),
                        const SizedBox(width: 10),
                        UIComponents.step("+", () {}),
                      ])
                ])
              ]))
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
      MaterialPageRoute(builder: (context) => CurrentSessionView()),
    );
  }
}
