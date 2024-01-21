import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_app/views/Category/recipe_in_category.dart';
import 'package:get/get.dart';


class TopChef{
  late String name;
  late String image;

  TopChef({required this.name, required this.image}); 
}

final  chefs = [
    TopChef(name : "Esther T.", image: "https://images.unsplash.com/photo-1512485800893-b08ec1ea59b1?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  TopChef(name : "Jenny M.", image: "https://images.unsplash.com/photo-1577219491135-ce391730fb2c?q=80&w=1954&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  TopChef(name : "Jacob U.", image: "https://images.unsplash.com/photo-1611657365907-1ca5d9799f59?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  TopChef(name: "Bessi K.", image: "https://images.unsplash.com/photo-1581299894007-aaa50297cf16?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  TopChef(name : "Esther T.", image: "https://images.unsplash.com/photo-1512485800893-b08ec1ea59b1?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  TopChef(name : "Jenny M.", image: "https://images.unsplash.com/photo-1577219491135-ce391730fb2c?q=80&w=1954&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  TopChef(name : "Jacob U.", image: "https://images.unsplash.com/photo-1611657365907-1ca5d9799f59?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  TopChef(name: "Bessi K.", image: "https://images.unsplash.com/photo-1581299894007-aaa50297cf16?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),

    // Додайте більше шеф-кухарів, якщо потрібно
  ];
class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return     GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w,),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Кількість стовпців
          crossAxisSpacing: 12.w, // Відстань між стовпцями
           // Відстань між рядами
          childAspectRatio: 0.9, // Співвідношення сторін для дочірніх елементів
        ),
        itemCount: chefs.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            //onTap: () =>  Get.to(RecipeInCategory()),
            child: Container(
              // Використовуйте 'AssetImage' для завантаження зображень з активів
              // Або 'NetworkImage' для завантаження з мережі
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                   colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), // Затемнення
                    BlendMode.darken,
                  ),
                  image: NetworkImage(chefs[index].image), // Приклад використання зображення з активів
                ),
              ),
              child: Center(
                child: Text(chefs[index].name, style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
              ),
            ),
          );
        },
      
    );
  }
}