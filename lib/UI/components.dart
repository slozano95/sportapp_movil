import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sportapp_movil/UI/colors.dart';

class UIComponents {
  static Widget navBar() {
    return Container(
        margin: const EdgeInsets.fromLTRB(7, 0, 7, 0),
        decoration: BoxDecoration(
            color: AppColors.orange, borderRadius: BorderRadius.circular(16)),
        height: 54,
        child: const Center(
            child: Text('SportApp',
                style: TextStyle(
                    fontSize: 32,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600))));
  }

  static Widget button(String title, VoidCallback onPressed) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
            width: 166,
            decoration: BoxDecoration(
                color: AppColors.orange,
                borderRadius: BorderRadius.circular(5)),
            height: 51,
            child: Center(
                child: Text(title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.white,
                        fontWeight: FontWeight.w700)))));
  }

  static Widget tabBar() {
    return Container(
        child: Row(children: [
      Expanded(
          child: Container(
              height: 54,
              child: const Center(
                  child: Image(
                      image: AssetImage("assets/icon_home.png"), width: 35)))),
      Expanded(
          child: Container(
              height: 54,
              child: const Center(
                  child: Image(
                      image: AssetImage("assets/icon_profile.png"),
                      width: 35)))),
      Expanded(
          child: Container(
              height: 54,
              child: const Center(
                  child: Image(
                      image: AssetImage("assets/icon_book.png"), width: 35)))),
      Expanded(
          child: Container(
              height: 54,
              child: const Center(
                  child: Image(
                      image: AssetImage("assets/icon_calendar.png"),
                      width: 35)),
                )),
    ]));
  }
}
