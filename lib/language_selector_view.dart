import 'package:flutter/material.dart';
import 'package:sportapp_movil/login_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'UI/components.dart';
import 'main.dart';

class LanguageSelector extends StatefulWidget {
  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      UIComponents.navBar(),
      Container(
          padding: const EdgeInsets.all(38),
          child: Column(children: [
            const SizedBox(height: 120),
             Text(AppLocalizations.of(context)!.idioma,
                  style: TextStyle(fontSize: 20),
                  ),
            const SizedBox(height: 20),
            UIComponents.button("Español", () {
              onSelectedLanguage(context, "es");
            }),
            const SizedBox(height: 50),
            UIComponents.button('English', () {
              onSelectedLanguage(context, "en");
            }),
          ]))
    ])));
  }

  void onSelectedLanguage(BuildContext context, String code) {
    MyApp.of(context)?.setLocale(Locale(code));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }
}
