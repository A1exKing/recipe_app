import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_app/views/RecipeDetail/recipe_detail_page.dart';


class PopularList extends StatelessWidget {
  const PopularList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          separatorBuilder: (context, index) =>  SizedBox(width: 12.w), 
          itemCount: 4,
          itemBuilder: (context, index) => itemPopular(context)
      ),
    );
  }



  Widget itemPopular(context){
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipeDetailPage()));
      },
      child: Container(
        width: 324.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          image: DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1573225342350-16731dd9bf3d?q=80&w=1962&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"), fit: BoxFit.cover)
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
                        Text("4.8 (1k+ Відгуків)", style: TextStyle(fontSize: 12.sp),),
                      ],
                    )
                  ),
                  Center(
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                      ),
                      child: Icon(Icons.favorite, color: Color(0xffE6E6E7),size: 18.sp,)
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
                        Text("Tomato Pasta", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Color(0xff2c2c2c)),),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.timer, color: Color(0xffF4612D),size: 14.sp,),
                        SizedBox(width: 4,),
                        Text("35 min", style: TextStyle(fontSize: 12.sp, color: Color(0xff7A7A7A)),),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Icon(Icons.circle, color: Color(0xff7A7A7A), size: 5.sp,),
                        ),
                        Text("Easy", style: TextStyle(fontSize: 12.sp, color: Color(0xff7A7A7A)),),
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