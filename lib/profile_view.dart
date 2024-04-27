import 'package:flutter/material.dart';
import 'package:sportapp_movil/UI/colors.dart';
import 'package:sportapp_movil/current_session_view.dart';
import 'package:sportapp_movil/datamanager.dart';
import 'package:sportapp_movil/login_view.dart';
import 'package:sportapp_movil/schedule_deportologo.dart';
import 'package:sportapp_movil/calendar_activities.dart';
import 'package:sportapp_movil/training_plan_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'UI/components.dart';

class ProfileData {
  double progress = 0;
  int sessions = 0;
  int lastMonthTrainings = 0;
  int lastMonthEvents = 0;
  double weight = 0;
  double imc = 0;
  double newWeight = 0;
  double newImc = 0;
}

class ProfileView extends StatefulWidget {
  ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String title = "";

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
                  child: const Image(
                      image: AssetImage("assets/icon_logout.png"), width: 30)),
              const Spacer(),
              Text(title),
              const Spacer(),
              GestureDetector(
                  onTap: () {
                    reloadData();
                  },
                  child: Container(
                      width: 30,
                      height: 30,
                      key: Key("icon_back"),
                      color: Colors.transparent,
                      child:
                          Icon(Icons.replay_outlined, color: AppColors.orange)))
            ],
          )),
      Expanded(
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(38),
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(AppLocalizations.of(context)!.perfil_title,
                        style: AppTypography.heading,
                        textAlign: TextAlign.left),
                    const SizedBox(height: 60),
                    Text(AppLocalizations.of(context)!.perfil_proceso,
                        style: AppTypography.medium),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Spacer(flex: 1),
                        Text("${DataManager().profileData?.progress ?? 0}%",
                            style: AppTypography.body),
                        const Spacer(flex: 2),
                        Text(
                            "Sesiones:\n${(DataManager().profileData?.sessions ?? 0)}/30",
                            style: AppTypography.body,
                            textAlign: TextAlign.center),
                        const Spacer(flex: 1),
                      ],
                    ),
                    const SizedBox(height: 60),
                    Text(AppLocalizations.of(context)!.perfil_ultimomes,
                        style: AppTypography.medium),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Spacer(flex: 1),
                        Text(
                            "${(DataManager().profileData?.lastMonthTrainings ?? 0)}\nEntrenamientos\ncompletados",
                            style: AppTypography.body,
                            textAlign: TextAlign.center),
                        const Spacer(flex: 2),
                        Text(
                            "${(DataManager().profileData?.lastMonthEvents ?? 0)}\nEventos\nasistidos",
                            style: AppTypography.body,
                            textAlign: TextAlign.center),
                        const Spacer(flex: 1),
                      ],
                    ),
                    const SizedBox(height: 60),
                    Text(AppLocalizations.of(context)!.perfil_avance,
                        style: AppTypography.medium),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Spacer(flex: 1),
                        Text(
                            "${(DataManager().profileData?.weight ?? 0)} KG\nPeso Inicial",
                            style: AppTypography.body,
                            textAlign: TextAlign.center),
                        const Spacer(flex: 2),
                        Text(
                            "${(DataManager().profileData?.newWeight ?? 0)} KG\nPeso Actual",
                            style: AppTypography.body,
                            textAlign: TextAlign.center),
                        const Spacer(flex: 1),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Spacer(flex: 1),
                        Text(
                            "${(DataManager().profileData?.imc ?? 0)} KG\nIMC Inicial",
                            style: AppTypography.body,
                            textAlign: TextAlign.center),
                        const Spacer(flex: 2),
                        Text(
                            "${(DataManager().profileData?.newImc ?? 0)} KG\nIMC Actual",
                            style: AppTypography.body,
                            textAlign: TextAlign.center),
                        const Spacer(flex: 1),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.grey),
                        child: Center(
                          child: Text(
                              AppLocalizations.of(context)!.perfil_message,
                              style: AppTypography.medium,
                              textAlign: TextAlign.center),
                        ))
                  ])))),
      UIComponents.tabBar(context, TabItem.profile)
    ])));
  }

  void signOut() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }

  void reloadData() async {
    title = "Cargando ...";
    setState(() {});
    await DataManager().getProfileData();
    title = "";
    setState(() {});
  }
}
