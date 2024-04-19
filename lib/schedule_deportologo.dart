import 'package:flutter/material.dart';
import 'package:sportapp_movil/UI/colors.dart';
import 'package:sportapp_movil/plan_selector_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'UI/components.dart';

class ScheduleDeportologo extends StatefulWidget {
  const ScheduleDeportologo({super.key});

  @override
  _ScheduleDeportologoState createState() => _ScheduleDeportologoState();
}

class _ScheduleDeportologoState extends State<ScheduleDeportologo> {
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
                    Text(AppLocalizations.of(context)!.dep_agendar,
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
                          child: 
                          Row(children:[
                            Text(
                              AppLocalizations.of(context)!.dep_opcion,
                              style: TextStyle(fontSize: 16),
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
                          child: const Row(children: [
                            Text(
                              "",
                              style: TextStyle(fontSize: 16),
                            ),
                            Spacer(),
                            Icon(Icons.calendar_month)
                          ])),
                    ),
                    const SizedBox(height: 50),
                    Center(
                        child: UIComponents.button(AppLocalizations.of(context)!.dep_guardar, () {
                      saveSession();
                    }))
                  ]))),
      UIComponents.tabBar(context, TabItem.home)
    ])));
  }

  void goBack() {
    Navigator.of(context).pop();
  }

  void saveSession() {
    //SHow sucess modal
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
              child:Text(AppLocalizations.of(context)!.dep_exitoso_Aceptar),
            ),
          ],
        );
      },
    );
  }

  void openCalendar() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
  }

  void openDropdown() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(AppLocalizations.of(context)!.dep_opcion,),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.dep_prensent),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.dep_virtual),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
        });
  }
}
