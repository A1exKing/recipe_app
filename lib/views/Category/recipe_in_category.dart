import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_app/api/api_recipe.dart';
import 'package:food_recipe_app/api/models/recipe.dart';
import 'package:food_recipe_app/controllers/category_controller.dart';
import 'package:food_recipe_app/views/RecipeDetail/recipe_detail_page.dart';
import 'package:get/get.dart';

class RecipeInCategory extends StatelessWidget {
   RecipeInCategory({super.key, required this.categoryName, required this.categoryLabel});
    final CategoryController recipesController = Get.put(CategoryController());
  String categoryName;
   String categoryLabel;
  @override
  Widget build(BuildContext context) {
     recipesController.fetchRecipes(categoryName);
    return Scaffold(
      appBar: AppBar(
        title:Text(categoryLabel),
        centerTitle: true,
        leadingWidth: 70.w,
        leading: Container(
          margin: EdgeInsets.only(left: 20.w),
          width: 20.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Color(0xfff6f6f6))
          ),
          child: Icon(Icons.arrow_back),
        ),
      ),
      body:     
     Obx(() {
        if (recipesController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        else {
          print(recipesController.status);
         
          return  recipesController.status == "ok".obs ? ListView.builder(
          shrinkWrap: true,
          itemCount:  recipesController.recipesList.length,
          itemExtent: 220.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          itemBuilder:(context, index) => itemPopular( recipesController.recipesList[index],context),
         ) : Center(child:  Text("List is Empty"),) ;
        }
    })
      
      
      
      
     
    );
  }

  
  Widget itemPopular(Recipe recipe, context){
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipeDetailPage(recipeID: recipe.id)));
      },
      child: Container(
        width: 324.w,
        margin: EdgeInsets.only(bottom: 18.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          image: DecorationImage(image: NetworkImage(recipe.imageUrl), fit: BoxFit.cover)
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
                        Text("${recipe.rating} (1k+ Reviews)", style: TextStyle(fontSize: 12.sp),),
                      ],
                    )
                  ),
                  Container(
                    width: 32.w,
                    height: 32.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white
                    ),
                    child: Icon(Icons.favorite, color: Color(0xffE6E6E7),size: 18.sp,)
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
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.timer, color: Color(0xffF4612D),size: 14.sp,),
                        SizedBox(width: 4,),
                        Text("${recipe.cookingTime} min", style: TextStyle(fontSize: 12.sp, color: Color(0xff7A7A7A)),),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Icon(Icons.circle, color: Color(0xff7A7A7A), size: 5.sp,),
                        ),
                        Text(recipe.difficulty, style: TextStyle(fontSize: 12.sp, color: Color(0xff7A7A7A)),),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Icon(Icons.circle, color: Color(0xff7A7A7A), size: 5.sp,),
                        ),
                        Text("by Arlene McCoy", style: TextStyle(fontSize: 12.sp, color: Color(0xff7A7A7A)),),
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