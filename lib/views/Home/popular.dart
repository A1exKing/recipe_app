import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_app/api/models/recipe.dart';
import 'package:food_recipe_app/views/RecipeDetail/recipe_detail_page.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';


class PopularList extends StatelessWidget {
  
   final RecipeController controller = Get.put(RecipeController());
   PopularList({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchRecipes();
    return Obx(() {
       return
Skeletonizer(
  enabled: controller.isLoading.value,
  child:
       SizedBox(
      height: 180.h,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          separatorBuilder: (context, index) =>  SizedBox(width: 12.w), 
          itemCount: controller.recipes.length,
          itemBuilder: (context, index) => itemPopular(context, controller.recipes[index])
      ),
    )
    );},

        
        
          
        
     ) ;
//     return FutureBuilder<List<Recipe>>(
//   future: fetchData2(), // Функція запиту даних
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return CircularProgressIndicator(); // Показуємо індикатор завантаження
//     } else if (snapshot.hasError) {
//       return Text("Error: ${snapshot.error}");
//     } else if (snapshot.hasData) {
//       List<Recipe> recipes = snapshot.data!;
//      return SizedBox(
//       height: 180.h,
//       child: ListView.separated(
//           scrollDirection: Axis.horizontal,
//           padding: EdgeInsets.symmetric(horizontal: 20.w),
//           separatorBuilder: (context, index) =>  SizedBox(width: 12.w), 
//           itemCount: recipes.length,
//           itemBuilder: (context, index) => itemPopular(context, recipes[index])
//       ),
//     );
//     } else {
//       return Text('Не знайдено жодного рецепту.');
//     }
//   },
// );
    
    
    // SizedBox(
    //   height: 180.h,
    //   child: ListView.separated(
    //       scrollDirection: Axis.horizontal,
    //       padding: EdgeInsets.symmetric(horizontal: 20.w),
    //       separatorBuilder: (context, index) =>  SizedBox(width: 12.w), 
    //       itemCount: 4,
    //       itemBuilder: (context, index) => itemPopular(context)
    //   ),
    // );


  }



  Widget itemPopular(context, Recipe recipe){
     final RecipeController controller = Get.put(RecipeController());
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipeDetailPage(recipeID: recipe.id,)));
      },
      child: Container(
        width: 324.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          image: DecorationImage(image: NetworkImage(recipe.imageUrl  ), fit: BoxFit.cover)
        ),
        child: Stack(
          children: [
            Padding(
              padding:  EdgeInsets.all(8.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16.sp,),
                        Text("${recipe.rating} (1k+ Відгуків)", style: TextStyle(fontSize: 12.sp),),
                      ],
                    )
                  ),
                  GestureDetector(
                    onTap: () =>  controller.toggleFavorite(recipe.id),
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                      ),
                      child: Obx(() {
                          return Icon(Icons.favorite, color: controller.favoriteRecipes.contains(recipe.id) ? Colors.red : Color(0xffE6E6E7),size: 18.sp,);
                        }
                      )
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: const  Alignment(0, 1),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 9.h),
                height: 60.sp,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.sp),
                  color: const Color(0xffF6F6F6)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                         Text(recipe.name, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Color(0xff2c2c2c)),),
                       // Text("Tomato Pasta", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Color(0xff2c2c2c)),),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.timer, color: Color(0xffF4612D),size: 14.sp,),
                        SizedBox(width: 4,),
                        Text("${recipe.cookingTime} мін.", style: TextStyle(fontSize: 12.sp, color: Color(0xff7A7A7A)),),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Icon(Icons.circle, color: Color(0xff7A7A7A), size: 5.sp,),
                        ),
                        Text("Easy", style: TextStyle(fontSize: 12.sp, color: Color(0xff7A7A7A)),),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Icon(Icons.circle, color: Color(0xff7A7A7A), size: 5.sp,),
                        ),
                        Text("by ${recipe.author}", style: TextStyle(fontSize: 12.sp, color: Color(0xff7A7A7A)),),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}