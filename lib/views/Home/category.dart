import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_app/views/Category/recipe_in_category.dart';
import 'package:get/get.dart';

  class Category{
     late String label;
    late String name;
    late String image;

    Category({required this.label, required this.name,required this.image});
  }
  List <Category>categoryList = [
    Category(label : "Сніданок", name: "Breakfast", image: "assets/images/categories/breakfast.png"),
    Category(label : "Десерт", name: "Dessert", image: "assets/images/categories/dessert.jpg"),
    Category(label : "Обід", name: "Lunch", image: "assets/images/categories/lunch.jpg")
  ];


class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.sp,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        separatorBuilder: (context, index) => const SizedBox(width: 12), 
        itemCount: categoryList.length,
        itemBuilder: (context, index) => itemCategory(categoryList[index])
        
      ),
    );
  }

  Widget itemCategory(Category item){
    return Material(
      borderRadius: BorderRadius.circular(50.sp),
      clipBehavior: Clip.antiAlias,
      child: Ink(
        width: 96.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.sp),
          image: DecorationImage(
            image: AssetImage(item.image),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3), // Затемнення
              BlendMode.darken,
            ),
          ),
        ),
        child: InkWell(
          onTap: () {
            Get.to(RecipeInCategory(categoryName:  item.name, categoryLabel : item.label));
            print("Tapped on ${item.label}");
          },
          child: Center(
            child: Text(
              item.label, 
              style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

}