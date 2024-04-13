import 'package:flutter/material.dart';
import 'package:sportapp_movil/UI/colors.dart';
import 'package:sportapp_movil/plan_selector_view.dart';

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
                  child: const Image(
                      image: AssetImage("assets/icon_back.png"), width: 30))
            ],
          )),
      Expanded(
          child: Container(
              padding: const EdgeInsets.all(38),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Cita Deportólogo",
                        style: AppTypography.heading,
                        textAlign: TextAlign.start),
                    const SizedBox(height: 40),
                    const Text(
                      "Agendar sesión",
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
                          child: const Row(children: [
                            Text(
                              "Selecciona la opción",
                              style: TextStyle(fontSize: 16),
                            ),
                            Spacer(),
                            Icon(Icons.arrow_drop_down_circle_outlined)
                          ])),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Seleccione la fecha",
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
                        child: UIComponents.button('Guardar', () {
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
          title: const Text('Exitoso'),
          content: const Text('Sesion Agendada'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => PlanSelector()),
    // );
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
              title: const Text('Selecciona la opción'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: const Text('Santiago no sabe que poner acá 1'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: const Text('Santiago no sabe que poner acá 2'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: const Text('Santiago no sabe que poner acá 3'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
        });
  }
}
