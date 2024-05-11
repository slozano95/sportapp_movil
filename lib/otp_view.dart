import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:sportapp_movil/UI/colors.dart';
import 'package:sportapp_movil/constants.dart';
import 'package:sportapp_movil/datamanager.dart';
import 'package:sportapp_movil/plan_selector_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sportapp_movil/services/login_service.dart';
import 'package:sportapp_movil/services/otp_service.dart';
import 'UI/components.dart';

class OTPView extends StatefulWidget {
  OTPView({super.key, required this.session, required this.email});
  String session;
  String email;

  @override
  _OTPViewState createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  var otpController = TextEditingController();

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
                    Navigator.of(context).pop();
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
      Container(
          padding: const EdgeInsets.all(38),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 120),
            const Text(
              "Ingresa el código obtenido de tu aplicación de autenticación",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 50),
            const Text(
              "Código OTP",
              style: TextStyle(fontSize: 16),
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.grey),
              child: TextField(
                key: const Key("otp"),
                controller: otpController,
                decoration: const InputDecoration(
                    hintStyle: TextStyle(fontSize: 17),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 12)),
              ),
            ),
            const SizedBox(height: 50),
            Center(
                child: UIComponents.button("Continuar", () {
              onContinue();
            }))
          ]))
    ])));
  }

  void onContinue() async {
    http.Client _client = http.Client();
    if (otpController.text != "") {
      var service = OTPService();
      var wasSuccesfull = await service.sendOtp(
          _client, widget.email, widget.session, otpController.text);
      if (wasSuccesfull) {
        // DataManager().setSession(session);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlanSelector()),
        );
      } else {
        showError();
      }
    } else {
      showError();
    }
  }

  void showError() {
    if (mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Código OTP incorrecto"),
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
}
