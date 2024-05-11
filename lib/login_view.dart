import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sportapp_movil/UI/colors.dart';
import 'package:sportapp_movil/constants.dart';
import 'package:sportapp_movil/datamanager.dart';
import 'package:sportapp_movil/otp_view.dart';
import 'package:sportapp_movil/plan_selector_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sportapp_movil/services/login_service.dart';
import 'UI/components.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var userController = TextEditingController();
  var pwdController = TextEditingController();
  bool loginNeeded = false;
  @override
  void initState() {
    tryToLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      UIComponents.navBar(),
      loginNeeded ? loginForm() : loadingView()
    ])));
  }

  Widget loadingView() {
    return Expanded(
        child: Container(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text("Iniciando sesión...")
        ]))));
  }

  Widget loginForm() {
    return Container(
        padding: const EdgeInsets.all(38),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 120),
          Text(
            AppLocalizations.of(context)!.user,
            style: const TextStyle(fontSize: 16),
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: AppColors.grey),
            child: TextField(
              key: const Key("user"),
              controller: userController,
              decoration: const InputDecoration(
                  hintStyle: TextStyle(fontSize: 17),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 12)),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            AppLocalizations.of(context)!.password,
            style: const TextStyle(fontSize: 16),
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: AppColors.grey),
            child: TextField(
              controller: pwdController,
              obscureText: true,
              decoration: const InputDecoration(
                  hintStyle: TextStyle(fontSize: 17),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 12)),
            ),
          ),
          const SizedBox(height: 50),
          Center(
              child: UIComponents.button(AppLocalizations.of(context)!.sign_in,
                  () {
            onSignIn();
          }))
        ]));
  }

  void onSignIn() async {
    userController.text = "slozano95@gmail.com";
    pwdController.text = "Colombia2024@@";

    if (userController.text != "" && pwdController.text != "") {
      var service = SecurityService();
      var session = await service.login(
          DataManager().client, userController.text, pwdController.text);
      if (session != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  OTPView(session: session, email: userController.text)),
        );
      } else {
        showError();
      }
    }
  }

  void showError() {
    if (mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Usuario o contraseña incorrectos"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(AppLocalizations.of(context)!.dep_exitoso_Aceptar),
              ),
            ],
          );
        },
      );
    }
  }

  void tryToLogin() async {
    await DataManager().readSessionData();
    var loginExpiresAt = DataManager().loginExpiresAt;
    var now = DateTime.now().millisecondsSinceEpoch;
    print(loginExpiresAt);
    print(now);
    if (loginExpiresAt == 0) {
      //NOT LOGGED IN
      setState(() {
        loginNeeded = true;
      });
    } else if (loginExpiresAt > now) {
      //LOGGED IN
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PlanSelector()),
      );
    } else {
      //REFRESH TOKEN
      setState(() {
        loginNeeded = true;
      });
    }
  }
}
