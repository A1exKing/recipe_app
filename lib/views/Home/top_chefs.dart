
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_app/views/Auther/auther_page.dart';
import 'package:get/get.dart';


class TopChef{
  late String name;
  late String image;

  TopChef({required this.name, required this.image}); 
}

List <TopChef>topChefList = [
  TopChef(name : "Esther T.", image: "https://images.unsplash.com/photo-1512485800893-b08ec1ea59b1?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  TopChef(name : "Jenny M.", image: "https://images.unsplash.com/photo-1577219491135-ce391730fb2c?q=80&w=1954&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  TopChef(name : "Jacob U.", image: "https://images.unsplash.com/photo-1611657365907-1ca5d9799f59?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  TopChef(name: "Bessi K.", image: "https://images.unsplash.com/photo-1581299894007-aaa50297cf16?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
];



class TopChefsList extends StatelessWidget {
  const TopChefsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 84.sp,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: topChefList.length,
        separatorBuilder: (context, index) => SizedBox(width: 24,),
        itemBuilder: (context, index) => itemChefWidget(topChefList[index]),
      ),
    );
  }

  Widget itemChefWidget(TopChef item){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Get.to(AutherPage()),
          child: Container(
            width: 64.sp,
            height: 64.sp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(item.image),
                fit: BoxFit.cover
              )
            ),
          ),
        ),
        Text(item.name, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, color: Color(0xff2c2c2c)),)
      ],
    );
  }
}