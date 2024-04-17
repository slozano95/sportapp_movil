import 'package:flutter/material.dart';
import 'package:sportapp_movil/UI/colors.dart';
import 'package:sportapp_movil/current_session_view.dart';
import 'package:sportapp_movil/login_view.dart';
import 'package:sportapp_movil/schedule_deportologo.dart';
import 'package:sportapp_movil/training_plan_view.dart';

import 'UI/components.dart';

enum PlanOption { premium, basic, medium }

enum PlanFeatures { scheduleSession, heartRate, trainingPlan, events }

extension PlanFeaturesExtension on PlanFeatures {
  String get name {
    switch (this) {
      case PlanFeatures.scheduleSession:
        return "Agendar Sesion Deportologo";
      case PlanFeatures.heartRate:
        return "Monitorea Ritmo Cardico";
      case PlanFeatures.trainingPlan:
        return "Plan Entrenamiento";
      case PlanFeatures.events:
        return "Eventos";
    }
  }

  String get imageName {
    switch (this) {
      case PlanFeatures.scheduleSession:
        return "assets/session.png";
      case PlanFeatures.heartRate:
        return "assets/heart.png";
      case PlanFeatures.trainingPlan:
        return "assets/plan.png";
      case PlanFeatures.events:
        return "assets/events.png";
    }
  }
}

extension PlanOptionExtension on PlanOption {
  String get name {
    switch (this) {
      case PlanOption.premium:
        return "Plan Premium";
      case PlanOption.basic:
        return "Plan Basico";
      case PlanOption.medium:
        return "Plan Medio";
    }
  }

  List<PlanFeatures> features() {
    switch (this) {
      case PlanOption.premium:
        return [
          PlanFeatures.scheduleSession,
          PlanFeatures.heartRate,
          PlanFeatures.trainingPlan,
          PlanFeatures.events
        ];
      case PlanOption.basic:
        return [PlanFeatures.trainingPlan, PlanFeatures.events];
      case PlanOption.medium:
        return [
          PlanFeatures.events,
          PlanFeatures.heartRate,
          PlanFeatures.trainingPlan
        ];
    }
  }
}

class PlanSelector extends StatefulWidget {
  PlanSelector({super.key});

  PlanOption selectedOption = PlanOption.premium;

  @override
  _PlanSelectorState createState() => _PlanSelectorState();
}

class _PlanSelectorState extends State<PlanSelector> {
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
                    signOut();
                  },
                  child: const Image(
                      image: AssetImage("assets/icon_logout.png"), width: 30))
            ],
          )),
      Expanded(
          child: Container(
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(widget.selectedOption.name,
                        style: AppTypography.heading),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        Expanded(child: planCell(PlanFeatures.scheduleSession)),
                        const SizedBox(width: 12),
                        Expanded(child: planCell(PlanFeatures.heartRate)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: planCell(PlanFeatures.trainingPlan)),
                        const SizedBox(width: 12),
                        Expanded(child: planCell(PlanFeatures.events)),
                      ],
                    )
                  ])))),
      UIComponents.tabBar(context, TabItem.home)
    ])));
  }

  Widget planCell(PlanFeatures planFeature) {
    return GestureDetector(
        onTap: () {
          switch (planFeature) {
            case PlanFeatures.scheduleSession:
              goToScheduleDeportologo();
              break;
            case PlanFeatures.trainingPlan:
              goToTrainingPlan();
              break;
            default:
              break;
          }
        },
        child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 10),
                  )
                ]),
            height: 220,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(planFeature.name, style: AppTypography.body),
              SizedBox(height: 4),
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(planFeature.imageName),
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(widget.selectedOption
                                      .features()
                                      .contains(planFeature)
                                  ? 0
                                  : 0.7),
                              BlendMode.srcOver,
                            ),
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

  void goToTrainingPlan() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TrainingPlanView()),
    );
  }
}
