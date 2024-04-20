import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sportapp_movil/UI/colors.dart';
import 'package:sportapp_movil/calendar_activities.dart';
import 'package:sportapp_movil/plan_selector_view.dart';
import 'package:sportapp_movil/profile_view.dart';

enum TabItem { home, profile, calendar, book }

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
            height: 50,
            decoration: BoxDecoration(
                color: AppColors.orange,
                borderRadius: BorderRadius.circular(5)),
            child: Center(
                child: Text(title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.white,
                        fontWeight: FontWeight.w700)))));
  }

  static Widget step(String title, VoidCallback onPressed) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                color: AppColors.orange,
                borderRadius: BorderRadius.circular(5)),
            child: Center(
                child: Text(title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.white,
                        fontWeight: FontWeight.w700)))));
  }

  static Widget tabBar(
    BuildContext context,
    TabItem currentTab,
  ) {
    return Row(children: [
      Expanded(
          child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlanSelector()),
                );
              },
              child: Container(
                  key: const Key('home_navbar_button'),
                  color: Colors.transparent,
                  height: 54,
                  child: Center(
                      child: Image(
                          image: const AssetImage("assets/icon_home.png"),
                          color: currentTab == TabItem.home
                              ? AppColors.darkOrange
                              : AppColors.orange.withAlpha(120),
                          width: 35))))),
      Expanded(
          child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileView()),
                );
              },
              child: Container(
                  key: const Key('profile_navbar_button'),
                  color: Colors.transparent,
                  height: 54,
                  child: Center(
                      child: Image(
                          image: const AssetImage("assets/icon_profile.png"),
                          color: currentTab == TabItem.profile
                              ? AppColors.darkOrange
                              : AppColors.orange.withAlpha(120),
                          width: 35))))),
      Expanded(
          child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarActivities()),
                );
              },
              child: Container(
                  key: const Key('book_navbar_button'),
                  color: Colors.transparent,
                  height: 54,
                  child: Center(
                      child: Image(
                          image: const AssetImage("assets/icon_book.png"),
                          color: currentTab == TabItem.book
                              ? AppColors.darkOrange
                              : AppColors.orange.withAlpha(120),
                          width: 35))))),
      Expanded(
          child: GestureDetector(
              onTap: () {
                print("NAV");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarActivities()),
                );
              },
              child: Container(
                key: Key('calendar_navbar_button'),
                color: Colors.transparent,
                height: 54,
                child: Center(
                    child: Image(
                        image: const AssetImage(
                          "assets/icon_calendar.png",
                        ),
                        color: currentTab == TabItem.calendar
                            ? AppColors.darkOrange
                            : AppColors.orange.withAlpha(120),
                        width: 35)),
              ))),
    ]);
  }
}
