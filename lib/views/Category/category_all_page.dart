import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_app/views/Category/list_category.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:Text("Categories"),
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
      body: CategoryGrid(),
    );
  }
}

