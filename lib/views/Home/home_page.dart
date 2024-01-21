import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_app/views/Category/category_all_page.dart';
import 'package:food_recipe_app/views/Home/category.dart';
import 'package:food_recipe_app/views/Home/home_app_bar.dart';
import 'package:food_recipe_app/views/Home/popular.dart';
import 'package:food_recipe_app/views/Home/top_chefs.dart';
import 'package:get/get.dart';


class HomePage extends StatelessWidget {
  
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              HomeAppBar(),
              TitleWidget(title: "Категорії",),
              CategoryList(),
              TitleWidget(title: "Популярні Рецепти",),
              PopularList(),
              TitleWidget(title: "Топ Кухарів",),
              TopChefsList()
            ],
          ),
        );
      }
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget(
    {
    super.key, required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 20.sp, right: 20.sp, top: 20.sp, bottom: 12.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Color(0xff252525), fontSize: 16.sp, fontWeight: FontWeight.w500),),
          GestureDetector(
            onTap: () => Get.to(CategoryPage()),
            child: Text("Більше", style: TextStyle(color: Color(0xffF46735), fontSize: 14.sp),)
            )
        ],
      ),
    );
  }
}

