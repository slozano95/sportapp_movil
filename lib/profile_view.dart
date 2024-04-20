import 'package:flutter/material.dart';
import 'package:sportapp_movil/UI/colors.dart';
import 'package:sportapp_movil/current_session_view.dart';
import 'package:sportapp_movil/login_view.dart';
import 'package:sportapp_movil/schedule_deportologo.dart';
import 'package:sportapp_movil/calendar_activities.dart';
import 'package:sportapp_movil/training_plan_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'UI/components.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
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
                    Text( AppLocalizations.of(context)!.perfil_proceso, style: AppTypography.medium),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(width: 50),
                        Text("35%", style: AppTypography.body),
                        Spacer(),
                        Text("Sesiones:\n17/30",
                            style: AppTypography.body,
                            textAlign: TextAlign.center),
                        SizedBox(width: 50),
                      ],
                    ),
                    const SizedBox(height: 60),
                    Text( AppLocalizations.of(context)!.perfil_ultimomes, style: AppTypography.medium),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(width: 50),
                        Text("10\nEntrenamientos\ncompletados",
                            style: AppTypography.body,
                            textAlign: TextAlign.center),
                        Spacer(),
                        Text("2\nEventos\nasistidos",
                            style: AppTypography.body,
                            textAlign: TextAlign.center),
                        SizedBox(width: 50),
                      ],
                    ),
                    const SizedBox(height: 60),
                    Text( AppLocalizations.of(context)!.perfil_avance, style: AppTypography.medium),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const SizedBox(width: 50),
                        Text("50 KG\nPeso",
                            style: AppTypography.body,
                            textAlign: TextAlign.center),
                        const Spacer(),
                        Text("43 KG\nPeso",
                            style: AppTypography.body,
                            textAlign: TextAlign.center),
                        const SizedBox(width: 50),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const SizedBox(width: 50),
                        Text("30 KG\nIMC",
                            style: AppTypography.body,
                            textAlign: TextAlign.center),
                        const Spacer(),
                        Text("26 KG\nIMC",
                            style: AppTypography.body,
                            textAlign: TextAlign.center),
                        const SizedBox(width: 50),
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
                          child: Text(AppLocalizations.of(context)!.perfil_message,
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
}