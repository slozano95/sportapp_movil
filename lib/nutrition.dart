import 'package:flutter/material.dart';
import 'package:sportapp_movil/UI/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sportapp_movil/current_session_view.dart';

import 'UI/components.dart';

class Nutrition extends StatefulWidget {
  const Nutrition({super.key});

  @override
  _NutritionState createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {
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
              padding: const EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.entr_plan_nutricional_title,
                        style: AppTypography.heading,),
                      const SizedBox(height: 10),
                      Row(
                      children: [
                        Expanded(
                            child: activityCell(
                                AppLocalizations.of(context)!.entr_plan_nutricional_protein, "assets/protein.png"))
                      ],
                    ),
                    const SizedBox(height: 10),
                          Row(
                      children: [
                        Expanded(
                            child: activityCell(
                                AppLocalizations.of(context)!.entr_plan_nutricional_vegetables, "assets/vegetable.png"))
                      ],
                    ),
                     const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                            child: activityCell(
                                AppLocalizations.of(context)!.entr_plan_nutricional_fats, "assets/fats.png"))
                      ],
                    )
                  ]))),
      UIComponents.tabBar(context, TabItem.home)
    ])));
  }


  Widget activityCell(String name, String image) {
    return GestureDetector(
        onTap: () {
          goToCurrentSession(name);
        },
        child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 10),
                  )
                ]),
            height: 200,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(name, style: AppTypography.heading),
              const SizedBox(height: 4),
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(image),
                          ))))
            ])));
  }

    void goToCurrentSession(String title) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CurrentSessionView(title: title)),
    );
  }
  void goBack() {
    Navigator.of(context).pop();
  }

}
