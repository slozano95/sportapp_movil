import 'package:flutter/material.dart';
import 'package:sportapp_movil/UI/colors.dart';
import 'package:sportapp_movil/plan_selector_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sportapp_movil/services/socios_service.dart';

import 'UI/components.dart';

class ScheduleDeportologo extends StatefulWidget {
  const ScheduleDeportologo({super.key});

  @override
  _ScheduleDeportologoState createState() => _ScheduleDeportologoState();
}

class _ScheduleDeportologoState extends State<ScheduleDeportologo> {
  String optionsTitle = "Selecciona la opción";
  String date = "";

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
                    goBack();
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
      Expanded(
          child: Container(
              padding: const EdgeInsets.all(38),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.dep_titulo,
                        style: AppTypography.heading,
                        textAlign: TextAlign.start),
                    const SizedBox(height: 40),
                    Text(
                      AppLocalizations.of(context)!.dep_agendar,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 14),
                    GestureDetector(
                      onTap: () {
                        openDropdown();
                      },
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.grey),
                          child: Row(children: [
                            Text(
                              optionsTitle,
                              style: const TextStyle(fontSize: 16),
                            ),
                            Spacer(),
                            Icon(Icons.arrow_drop_down_circle_outlined)
                          ])),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      AppLocalizations.of(context)!.dep_fecha,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 14),
                    GestureDetector(
                      onTap: () {
                        openCalendar();
                      },
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.grey),
                          child: Row(children: [
                            Text(
                              date,
                              style: TextStyle(fontSize: 16),
                            ),
                            Spacer(),
                            Icon(Icons.calendar_month)
                          ])),
                    ),
                    const SizedBox(height: 50),
                    Center(
                        child: UIComponents.button(
                            AppLocalizations.of(context)!.dep_guardar, () {
                      saveSession();
                    }))
                  ]))),
      UIComponents.tabBar(context, TabItem.home)
    ])));
  }

  void goBack() {
    Navigator.of(context).pop();
  }

  void saveSession() async {
    if (date.isEmpty || optionsTitle == "Selecciona la opción") {
      showFieldsError();
      return;
    }
    await SociosService().createCita(date, optionsTitle).then((value) {
      if (value) {
        showSuccessModal();
      } else {
        showError();
      }
    });
  }

  void openCalendar() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    ).then((value) {
      setState(() {
        date = value.toString().replaceAll(" 00:00:00.000", "");
      });
    });
  }

  void openDropdown() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                AppLocalizations.of(context)!.dep_opcion,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.dep_prensent),
                    onTap: () {
                      setState(() {
                        optionsTitle = "Presencial";
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.dep_virtual),
                    onTap: () {
                      setState(() {
                        optionsTitle = "Virtual";
                      });
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
        });
  }

  void showSuccessModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.dep_exitoso),
          content: Text(AppLocalizations.of(context)!.dep_exitoso_desc),
          actions: [
            TextButton(
              onPressed: () {
                goBack();
              },
              child: Text(AppLocalizations.of(context)!.dep_exitoso_Aceptar),
            ),
          ],
        );
      },
    );
  }

  void showError() {
    if (mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Ha ocurrido un error, por favor intenta de nuevo"),
            actions: [
              TextButton(
                onPressed: () {
                  goBack();
                },
                child: Text(AppLocalizations.of(context)!.dep_exitoso_Aceptar),
              ),
            ],
          );
        },
      );
    }
  }

  void showFieldsError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text("Todos los campos son necesarios para continuar"),
          actions: [
            TextButton(
              onPressed: () {
                goBack();
              },
              child: Text(AppLocalizations.of(context)!.dep_exitoso_Aceptar),
            ),
          ],
        );
      },
    );
  }
}
