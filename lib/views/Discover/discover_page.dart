import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_app/controllers/filter_controller.dart';
import 'package:food_recipe_app/views/Discover/search_page.dart';
import 'package:food_recipe_app/views/Filter/filter_page.dart';
import 'package:food_recipe_app/views/Home/top_chefs.dart';
import 'package:food_recipe_app/views/RecipeDetail/recipe_detail_page.dart';
import 'package:get/get.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Пошук"),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SearchAndFilter(),
             Padding(
               padding:  EdgeInsets.only(left: 20.w ,bottom: 12.h, right: 20.w),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text("Популярні повари", style: TextStyle(color: Color(0xff242424), fontSize: 16.sp, fontWeight: FontWeight.w500),),
                   Text("Більше", style: TextStyle(color: Color(0xffF46735), fontSize: 14.sp),)
                 ],
               ),
             ),
             TopChefsList(),
             Padding(
               padding:  EdgeInsets.only(left: 20.w ,bottom: 12.h, right: 20.w, top: 24.h),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text("Популярні теги", style: TextStyle(color: Color(0xff242424), fontSize: 16.sp, fontWeight: FontWeight.w500),),
                   Text("Більше", style: TextStyle(color: Color(0xffF46735), fontSize: 14.sp),)
                 ],
               ),
             ),
             Padding(
               padding:  EdgeInsets.symmetric(horizontal: 20.w),
               child: Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: tags.map((e) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 6.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(66),
                      color: Color(0xfff6f6f6)
                    ),
                    child: Text(e, style: TextStyle(color: Color(0xff797979), fontSize: 16),),
                  ),).toList()
               ),
             ),
              Padding(
               padding:  EdgeInsets.only(left: 20.w ,bottom: 12.h, right: 20.w, top: 24.h),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text("Популярні рецепти", style: TextStyle(color: Color(0xff242424), fontSize: 16.sp, fontWeight: FontWeight.w500),),
                   Text("Більше", style: TextStyle(color: Color(0xffF46735), fontSize: 14.sp),),
      
                 ],
               ),
             ),
             SizedBox(
              height: 200.h,
               child: ListView.builder(
                padding: EdgeInsets.only(left: 20.w,right: 20.w),
                scrollDirection: Axis.horizontal,
                //separatorBuilder: (context, index) => SizedBox(width: 12.w,),
                itemCount: 4,
                itemExtent: 280.w,
                itemBuilder: (context, index) => itemTrending(context),
               ),
             )
          ],
        ),
      ),
    );
  }
  Widget itemTrending(context){
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipeDetailPage()));
      },
      child: Container(
        width: 324.w,
        margin: EdgeInsets.only(right: 16.w),
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

List tags = [
  "Здоровий", "Невегетарианский", "Гострий", "Фастфуд", "Вечеря", "Десерт"
];

class SearchAndFilter extends StatelessWidget {
  final SelectionController controller = Get.find<SelectionController>();

   SearchAndFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 20.w, right: 20.w, top: 16.h, bottom: 24.h),
      child: Row(
         children: [
           Expanded(
             child: Container(
              height: 45.sp,
               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
               decoration: const BoxDecoration(
                 color: Color(0xfff6f6f6),
                 borderRadius: BorderRadius.all(Radius.circular(8))
               ),
               child: Row(
               // /  mainAxisAlignment: MainAxisAlignment.center,
                 mainAxisSize: MainAxisSize.min,
                 children: [
                    Image.asset("assets/icons/search.png", width: 22.sp, height: 22.sp, color: Color(0xffF4612D),),
                    const SizedBox(width: 8,),
                    Expanded(
                      child: TextField(
                        readOnly : true,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage())),
                       textAlignVertical: TextAlignVertical.center,
                       onTapOutside: (v)=> FocusScope.of(context).requestFocus(FocusNode()),
                       decoration: InputDecoration(
                        
                         border: InputBorder.none,
                         hintText: 'Search Any Recipe...',
                         hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp, fontWeight: FontWeight.w400)
                       ),
                      ),
                    )
                 ],
               ),
             ),
           ),
          SizedBox(width: 8.sp,),
           GestureDetector(
             onTap: () => Get.to(FilterPage()),
             child: Container(
               width: 45.sp,
               height: 45.sp,
               decoration: BoxDecoration(
                 color: Color(0xffF4612D),
                 borderRadius: BorderRadius.circular(12)
               ),
               child: Obx(() {
                            return Center(
                              child: Badge(
                              isLabelVisible: controller.hasActiveFilters ,
                             // label: Text("${selectionController.countActiveFilters()}"),
                             backgroundColor: Colors.white,
                             smallSize: 8,
                             alignment: Alignment(2, -1.4),
                              
                                child: Image.asset('assets/icons/filter.png', width: 20.sp, height: 20.sp,  color:   Colors.white))
                            );
               }
               )
             ),
           )
         ],
       ),
    );
  }
}