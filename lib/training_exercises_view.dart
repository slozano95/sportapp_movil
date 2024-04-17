import 'package:flutter/material.dart';
import 'package:sportapp_movil/UI/colors.dart';
import 'package:sportapp_movil/current_session_view.dart';
import 'package:sportapp_movil/datamanager.dart';
import 'package:sportapp_movil/login_view.dart';
import 'package:sportapp_movil/plan_selector_view.dart';
import 'package:sportapp_movil/schedule_deportologo.dart';
import 'package:sportapp_movil/services/training_exercises_service.dart';

import 'UI/components.dart';

// ignore: must_be_immutable
class TrainingExercisesView extends StatefulWidget {
  TrainingExercisesView({super.key});

  @override
  _TrainingExercisesViewState createState() => _TrainingExercisesViewState();
}

class _TrainingExercisesViewState extends State<TrainingExercisesView> {
  Map<String, int> counts = {};
  var nombreController = TextEditingController();
  String date = "";
  @override
  void initState() {
    for (var element in DataManager().allExercises) {
      counts[element.nombre ?? ""] = 0;
    }
    super.initState();
  }

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
                    goBack();
                  },
                  child: Container(
                      width: 30,
                      height: 30,
                      key: Key("icon_back"),
                      color: Colors.transparent,
                      child: const Image(
                          image: AssetImage("assets/icon_back.png"),
                          width: 30))),
            ],
          )),
      Expanded(
          child: Container(
              padding: const EdgeInsets.all(38),
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text("Agregar entrenamiento", style: AppTypography.heading),
                    const SizedBox(height: 20),
                    const Text(
                      "Nombre del entrenamiento",
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.grey),
                      child: TextField(
                        controller: nombreController,
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(fontSize: 17),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 8)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Seleccione la fecha",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
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
                    const SizedBox(height: 20),
                    Text("Ejercicios", style: AppTypography.heading),
                    const SizedBox(height: 20),
                    exercisesWidget(),
                    Center(
                        child: UIComponents.button("Guardar", () {
                      saveData();
                    }))
                  ])))),
      UIComponents.tabBar(context, TabItem.home)
    ])));
  }

  Widget exercisesWidget() {
    var data = DataManager().allExercises;
    var widgets = <Widget>[];
    for (var element in data) {
      widgets
          .add(exerciseCell(element.nombre ?? "", element.urlImagen ?? "", ""));
    }
    return Column(children: widgets);
  }

  Widget exerciseCell(String name, String imageUrl, String description) {
    return GestureDetector(
        onTap: () {},
        child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3))
                ]),
            height: 140,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(name, style: AppTypography.medium),
              const SizedBox(height: 12),
              Expanded(
                  child: Row(children: [
                Image.network(imageUrl, height: double.infinity),
                const SizedBox(width: 12),
                Text(description, style: AppTypography.body),
                const Spacer(),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text("Repeticiones"),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        UIComponents.step("-", () {
                          setState(() {
                            if (counts[name]! > 0) {
                              counts[name] = (counts[name]! - 1);
                            }
                          });
                        }),
                        const SizedBox(width: 10),
                        Text(counts[name].toString(),
                            style: AppTypography.body),
                        const SizedBox(width: 10),
                        UIComponents.step("+", () {
                          setState(() {
                            counts[name] = (counts[name]! + 1);
                          });
                        }),
                      ])
                ])
              ]))
            ])));
  }

  void goBack() {
    Navigator.of(context).pop();
  }

  void goToAddExercises() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CurrentSessionView()),
    );
  }

  void saveData() {
    if (nombreController.text.isEmpty || date.isEmpty) {
      showErrorDialog("Todos los campos son necesarios");
      return;
    }
    if (counts.values.where((element) => element == 0).toList().length ==
        counts.length) {
      showErrorDialog("Almenos un ejercicio debe tener repeticiones");
      return;
    }
    var service = TrainingExercisesService();
    var localC = counts;
    service.callCreate(nombreController.text, date, localC).then((value) {
      if (value) {
        showSuccessDialog();
      } else {
        showErrorDialog("Ha ocurrido un error al crear el entrenamiento'");
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

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exito'),
          content: const Text('Entrenamiento creado'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(msg),
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
  }
}
