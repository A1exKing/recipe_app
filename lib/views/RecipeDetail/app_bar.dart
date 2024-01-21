
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_app/api/models/recipe.dart';
import 'package:get/get.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';


void _showImageDialog(BuildContext context, String e) {
  final imageProvider = Image.network(e).image;
showImageViewer(context, imageProvider, onViewerDismissed: () {
  print("dismissed");
}); // або NetworkImage
 
}
List listImage = [
  "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1602253057119-44d745d9b860?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZGlzaHxlbnwwfHwwfHx8MA%3D%3D",
  "https://images.unsplash.com/photo-1574484284002-952d92456975?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8ZGlzaHxlbnwwfHwwfHx8MA%3D%3D",
  //"https://images.usplash.com/photo-1554980291-c3e7cea75872?q=80&w=1996&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://plus.unsplash.com/premium_photo-1664640733996-0051b12f52f3?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
];


class MySliverAppBar extends StatelessWidget {
   MySliverAppBar({
    super.key, required this.imageUrl, required this.recipe
  });

  String imageUrl;
RecipeDetail  recipe;

  @override
  Widget build(BuildContext context) {
    final RecipeController controller = Get.put(RecipeController());
    return SliverAppBar(
      leadingWidth: 68,
      backgroundColor: Colors.white,
      expandedHeight: 300.h,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Stack(
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: double.infinity,
              ),
            Align(
           alignment: Alignment(0, 0.7),
              
              child: Container(
                padding: EdgeInsets.only(left : 4.w, top: 4.h, bottom: 4.h),
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: listImage.map((e) => 
                  GestureDetector(
                    onTap: ()=>_showImageDialog(context, e),
                    child: Container(
                      height: double.infinity,
                      width: 50.w,
                      margin: EdgeInsets.only(right: 4.w),
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(e), fit: BoxFit.cover),
                         borderRadius: BorderRadius.circular(6.r),
                      ),),
                  )
                  ).toList(),
                ),
              ),
            ),
            Positioned(
              bottom: -1,
              left: 0,
              right: 0,
              child: Container(
                height: 12.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                  color: Colors.white
                ),
              ),
            )
          ],
        ),
      ),
      
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin:  EdgeInsets.only(left: 20.w),
          child: CircleAvatar(
            radius: 21.r,
            backgroundColor: Colors.white,
            child: Icon(Icons.arrow_back),
          ),
        ),
      ),
      actions: [
        Padding(
        padding:  EdgeInsets.only(right: 12.w),
        child: CircleAvatar(
          radius: 21.r,
          backgroundColor: Colors.white,
          child: Icon(Icons.share),
        ),
      ),
      Padding(
        padding:  EdgeInsets.only(right: 20.w),
        child: GestureDetector(
          onTap: () {controller.toggleFavorite(recipe.id); print(recipe.isFavorite);},
          child: CircleAvatar(
            radius: 21.r,
            backgroundColor: Colors.white,
           child: Obx(() {
                          return Icon(Icons.favorite, color:controller.favoriteRecipes.contains(recipe.id) ? Colors.red : Color(0xffE6E6E7),size: 18.sp,);
                        }
                      )
          ),
        ),
      ),
      ],
    );
  }
}