import 'package:flutter/material.dart';

import 'package:food_recipe_app/controllers/tab_controller.dart';
import 'package:food_recipe_app/views/Discover/discover_page.dart';
import 'package:food_recipe_app/views/Favorite/favorite_page.dart';

import 'package:food_recipe_app/views/Home/home_page.dart';
import 'package:food_recipe_app/views/Profile/user_profile_page.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List <Widget>pageList = [
    HomePage(),
    DiscoverPage(),
    FavoritePage(),
    UserProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TabIndexController());


    return WillPopScope(
      onWillPop: () async {
        // Перевіряємо, чи не на першій вкладці
        if (controller.tabIndex != 0) {
          // Якщо не на першій вкладці, переходимо на попередню
          controller.setTabIndex = controller.tabIndex - 1;
          return false; // Забороняємо системі закрити додаток
        }

        return true; // Дозволяємо системі закрити додаток, якщо на першій вкладці
      },
      child: Obx(() => Scaffold(
            body: IndexedStack(
            index: controller.tabIndex,
            children: pageList,
          ),
            bottomNavigationBar: Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    spreadRadius: 8,
                    blurRadius: 12,
                    offset: Offset(0, -3),
                    color: Color(0xfff4f4f4))
              ], borderRadius: BorderRadius.vertical(top: Radius.circular(14))),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 12,
                onTap: (value) {
                  controller.setTabIndex = value;
                },
                currentIndex: controller.tabIndex,
                selectedItemColor: Color(0xffF4612D),
                unselectedItemColor: Color(0xffC9C9C9),
                // showSelectedLabels: false,
                //  showUnselectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                      icon: Column(
                        children: [
                          if (controller.tabIndex == 0)
                            Transform.translate(
                              offset: Offset(0, -8),
                              child: Container(
                                width: 18,
                                height: 8,
                                decoration: BoxDecoration(
                                    color: Color(0xffF4612D),
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(44))),
                              ),
                            ),
                          controller.tabIndex == 0
                              ? Image.asset(
                                  "assets/icons/home_1.png",
                                  width: 20,
                                  color: Color(0xffF9C0AC),
                                )
                              : Image.asset(
                                  "assets/icons/home_0.png",
                                  width: 20,
                                  color: Color(0xffC9C9CA),
                                )
                        ],
                      ),
                      label: "Головна"),
                  BottomNavigationBarItem(
                      icon: Column(
                        children: [
                          if (controller.tabIndex == 1)
                            Transform.translate(
                              offset: Offset(0, -8),
                              child: Container(
                                width: 18,
                                height: 8,
                                decoration: BoxDecoration(
                                    color: Color(0xffF4612D),
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(44))),
                              ),
                            ),
                          controller.tabIndex == 1
                              ? Image.asset(
                                  "assets/icons/discover_1.png",
                                  width: 20,
                                  color: Color(0xffF9C0AC),
                                )
                              : Image.asset(
                                  "assets/icons/discover_0.png",
                                  width: 20,
                                  color: Color(0xffC9C9CA),
                                )
                        ],
                      ),
                      label: "Пошук"),
                  BottomNavigationBarItem(
                      icon: Column(
                        children: [
                          if (controller.tabIndex == 2)
                            Transform.translate(
                              offset: Offset(0, -8),
                              child: Container(
                                width: 18,
                                height: 8,
                                decoration: BoxDecoration(
                                    color: Color(0xffF4612D),
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(44))),
                              ),
                            ),
                          controller.tabIndex == 2
                              ? Image.asset(
                                  "assets/icons/favorite_1.png",
                                  width: 20,
                                  color: Color(0xffF9C0AC),
                                )
                              : Image.asset(
                                  "assets/icons/favorite_0.png",
                                  width: 20,
                                  color: Color(0xffC9C9CA),
                                )
                        ],
                      ),
                      label: "Вибрані"),
                        BottomNavigationBarItem(
                      icon: Column(
                        children: [
                          if (controller.tabIndex == 3)
                            Transform.translate(
                              offset: Offset(0, -8),
                              child: Container(
                                width: 18,
                                height: 8,
                                decoration: BoxDecoration(
                                    color: Color(0xffF4612D),
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(44))),
                              ),
                            ),
                          controller.tabIndex == 3
                              ? Image.asset(
                                  "assets/icons/profile_1.png",
                                  width: 20,
                                  color: Color(0xffF9C0AC),
                                )
                              : Image.asset(
                                  "assets/icons/profile_0.png",
                                  width: 20,
                                  color: Color(0xffC9C9CA),
                                )
                        ],
                      ),
                      label: "Профіль")
                ],
              ),
            ),
          )),
    );
  }
}
