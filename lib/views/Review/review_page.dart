import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_app/api/models/recipe.dart';
import 'package:food_recipe_app/api/models/review_recipe.dart';
import 'package:food_recipe_app/controllers/reviwRecipeController.dart';
import 'package:food_recipe_app/views/Review/write_review_page.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReviewPage extends StatelessWidget {
   ReviewPage({super.key, required this.id_recipe});
  final String id_recipe;
  @override
  Widget build(BuildContext context) {
    final ReviewRecipeController reviewRecipeController = Get.put(ReviewRecipeController());
    reviewRecipeController.getReviewRecipe(id_recipe.toString());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:Text("Review"),
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                RetingWidget(),
                  Divider(color: Color(0xfff6f6f6),indent: 20.w, endIndent: 20.w,),
                  Padding(
                    padding:  EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Row(
                    children: [
                      Expanded(
                        child: Container(
                         height: 45.sp,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: const BoxDecoration(
                            color: Color(0xfff6f6f6),
                            borderRadius: BorderRadius.all(Radius.circular(16))
                          ),
                          child: Row(
                          // /  mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                               Image.asset("assets/icons/search.png", width: 22.sp, height: 22.sp, color: Color(0xffF4612D),),
                               const SizedBox(width: 8,),
                               Expanded(
                                 child: TextField(
                  
                                  textAlignVertical: TextAlignVertical.center,
                                  onTapOutside: (v)=> FocusScope.of(context).requestFocus(FocusNode()),
                                  decoration: InputDecoration(
                                   
                                    border: InputBorder.none,
                                    hintText: 'Search in reviews',
                                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp, fontWeight: FontWeight.w400)
                                  ),
                                 ),
                               )
                            ],
                          ),
                        ),
                    )]
                      ),
                  ),
                  SizedBox(
                    height: 60.h,
                    child: ListView(
                      
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: false,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 8.w),
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                          decoration: 
                          BoxDecoration(
                            borderRadius: BorderRadius.circular(44),
                            color: Color(0xfff6f6f6)
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset("assets/icons/filter.png", width: 16.w, color: Color(0xff242424)),
                              SizedBox(width: 6.w,), 
                              Text("Filter", style: TextStyle(color: Color(0xff242424), fontWeight: FontWeight.w500),),
                              Icon(Icons.arrow_drop_down, color: Color(0xff242424))
                            ],
                          ),
                        ),
                        ...List.generate(3, (index) => Container(
                          margin: EdgeInsets.only(right: 8.w),
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                          decoration: 
                          BoxDecoration(
                            borderRadius: BorderRadius.circular(44),
                            color: Color(0xffF4612D)
                          ),
                          child: Center(child: Text("Latest", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),)),
                        ),)
                      ],
                    ),
                  ),
                  Divider(color: Color(0xfff6f6f6),),
 Obx(() {
       return
Skeletonizer(
  enabled: reviewRecipeController.isLoading.value,
  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(color: Color(0xfff6f6f6),),
                    itemCount: reviewRecipeController.reviewRecipeList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ItemReview(reviewRecipe:  reviewRecipeController.reviewRecipeList[index]);
                    },
                  )
    //    SizedBox(
    //   height: 180.h,
    //   child: ListView.separated(
    //       scrollDirection: Axis.horizontal,
    //       padding: EdgeInsets.symmetric(horizontal: 20.w),
    //       separatorBuilder: (context, index) =>  SizedBox(width: 12.w), 
    //       itemCount: controller.recipes.length,
    //       itemBuilder: (context, index) => itemPopular(context, controller.recipes[index])
    //   ),
    // )
    );},

        
        
          
        
     ) 


                 
                  
              ],
            ),
          ),
          Align(
            alignment: Alignment(0,1),
            child: Container(
              height: 68.h,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Color(0xfff6f6f6), offset: Offset(0, 2), blurRadius: 8, spreadRadius: 4)
                ]
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>WriteReviewPage()));
                },
                style: ButtonStyle(
                  //textStyle: MaterialStatePropertyAll(TextStyle(color: Colors.white)),
                  backgroundColor: MaterialStatePropertyAll(Color(0xffF4612D))
                ),
                child: Text("Write Review",style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w500)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ItemReview extends StatelessWidget {
   ItemReview( {required this.reviewRecipe,
    super.key,
  });
ReviewRecipe reviewRecipe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 20.w, right: 20.w, bottom: 8.h, top: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(reviewRecipe.photoUser,
                ),
                radius: 21.r,
              ),
              SizedBox(width: 8.w,),
              Text(reviewRecipe.nameUser, style: TextStyle(fontSize: 14.sp, color: Color(0xff242424), fontWeight: FontWeight.w500),),
              const Spacer(),
              Text(reviewRecipe.create_at, style: TextStyle(fontSize: 12.sp, color: Color(0xff797979)),),
            ],
          ),
          Padding(
            padding:  EdgeInsets.only(top: 8.h, bottom: 6.h),
            child: Text(reviewRecipe.textReview,
              style: TextStyle(fontSize: 12.sp, color: Color(0xff797979)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...List.generate(5, (index) => Icon(Icons.star,color: Colors.amber,size: 16.w,)),
              Text(reviewRecipe.rating.toString(), style: TextStyle(fontSize: 12.sp, color: Color(0xff797979)),),
            ]
          ),
        ],
      ),
    );
  }
}

class RetingWidget extends StatelessWidget {
  const RetingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 20.w, right: 20.w, top: 12.h),
      child: SizedBox(
        height: 140.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
         // direction: Axis.horizontal,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("4.7", style: TextStyle(fontSize: 28.sp, color: Color(0xff242424), fontWeight: FontWeight.w500),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) => Icon(Icons.star,color: Colors.amber,size: 28.w,)),
                  ),
                  Text("(107) Reviews", style: TextStyle(fontSize: 16.sp, color: Color(0xff797979)),),
                ],
                        
              ),
            ),
           VerticalDivider(
              thickness: 1,
              endIndent: 12.h,
              
              color: Color(0xfff6f6f6),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 BarRating(number: 5, rating: 0.8,),
                 BarRating(number: 4, rating: 0.6,),
                 BarRating(number: 3, rating: 0.3,),
                 BarRating(number: 2, rating: 0.1,),
                 BarRating(number: 1, rating: 0.0,),
                ],
                        
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BarRating extends StatelessWidget {
  
  const BarRating({
    super.key, required this.number, required this.rating,
  });

  final num number;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 6.h),
      child: Row(
       children: [
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 4.0),
           child: Text(number.toString()),
         ),
         Expanded(
           child: Container(
            
             width: double.infinity,
             height: 8.h,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(20),
               color: Color(0xfff6f6f6)
             ),
             child: FractionallySizedBox(
               alignment: Alignment.centerLeft,
               widthFactor: rating,
               child: Container(
                 
                 height: 8.h,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(20),
                   color: Color(0xffF4612D)
                 ),
               ),
             )
           ),
         )
       ],
      ),
    );
  }
}