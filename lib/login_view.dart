import 'package:flutter/material.dart';
import 'package:sportapp_movil/UI/colors.dart';
import 'package:sportapp_movil/constants.dart';
import 'package:sportapp_movil/datamanager.dart';
import 'package:sportapp_movil/plan_selector_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'UI/components.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      UIComponents.navBar(),
      Container(
          padding: const EdgeInsets.all(38),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 120),
            Text(
              AppLocalizations.of(context)!.user,
              style: TextStyle(fontSize: 20),
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.grey),
              child: TextField(
                key: const Key("user"),
                controller: controller,
                decoration: const InputDecoration(
                    hintStyle: TextStyle(fontSize: 17),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 12)),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              AppLocalizations.of(context)!.password,
              style: const TextStyle(fontSize: 20),
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.grey),
              child: const TextField(
                obscureText: true,
                decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 17),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 12)),
              ),
            ),
            const SizedBox(height: 50),
            Center(
                child: UIComponents.button(
                    AppLocalizations.of(context)!.sign_in, () {
              onSignIn();
            }))
          ]))
    ])));
  }

  void onSignIn() {
    if (controller.text != "") {
      switch (controller.text) {
        case "1":
          id_user = "07adc016-82eb-4c92-b722-0e80ebfdcfe5";
        default:
          id_user = "87adc016-82eb-4c92-b722-0e80ebfdcfe5";
      }
      DataManager().initData();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PlanSelector()),
      );
    }
  }
}
