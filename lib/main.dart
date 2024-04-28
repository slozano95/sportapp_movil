import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sportapp_movil/UI/colors.dart';
import 'package:sportapp_movil/datamanager.dart';
import 'package:sportapp_movil/language_selector_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp(http.Client()));
}

class MyApp extends StatefulWidget {
  final http.Client client;

  MyApp(this.client);

  @override
  _MyAppState createState() {
    DataManager().setClient(this.client);
    return _MyAppState();
  }

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale("es");

  @override
  void initState() {
    // TODO: implement initState
    //DataManager().initData();
    super.initState();
  }

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: _locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.orange),
          useMaterial3: true,
        ),
        home: LanguageSelector());
  }
}
