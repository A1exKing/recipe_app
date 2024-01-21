import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_app/api/api_recipe.dart';
import 'package:food_recipe_app/api/models/user.dart';
import 'package:food_recipe_app/controllers/filter_controller.dart';
import 'package:food_recipe_app/controllers/user_conreoller.dart';
import 'package:food_recipe_app/views/Discover/search_page.dart';
import 'package:food_recipe_app/views/Filter/filter_page.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget {
    
   final SelectionController controller = Get.find<SelectionController>();

  final UserController userController = Get.put(UserController());

   HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    getUserData();
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 18.sp, vertical: 22.sp),
      decoration:  BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(18)),
        color: Color(0xffF4612D),
        boxShadow: [
          BoxShadow(
            spreadRadius: 3,
            blurRadius: 12,
            offset: const Offset(0, 3),
            color: const Color(0xffF4612D).withOpacity(0.2)
          )
        ]
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
           Obx(() {
            User user  = userController.userData.value;
                return Row(
                  children: [
                    user.photo == "photo" ?
                      CircularProgressIndicator()
                     :
                       CircleAvatar(
                      backgroundImage: NetworkImage("http://192.168.0.108:5000/api/user/photo?photo=${user.photo}"),
                      radius: 20.r, 
                      backgroundColor: Colors.white,),
                    
                    
                    const SizedBox(width: 12,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Привіт ${user.userName}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14.sp),),
                        Text("Подивіться дивовижні рецепти...", style: TextStyle(color: Colors.white, fontSize: 12.sp), overflow: TextOverflow.clip,),
                      ],
                    ),
                     const Spacer(),
                     Container(
                      width: 40.sp,
                      height: 40.sp,
                      //padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                      ),
                      child: Center(
                        child: Badge(
                          alignment: const Alignment(0.6, -0.8),
                          backgroundColor: Colors.red,
                          child: Image.asset('assets/icons/bell.png', width: 18.sp, height: 18.sp, )
                          ),
                      ),
                     )
                  ],
                );
              }
            ),
            const SizedBox(height: 24,),
            Row(
              children: [
                Expanded(
                  child: Container(
                   height: 45.sp,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
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
                            readOnly: true,
                            textAlignVertical: TextAlignVertical.center,
                            onTap: () => Get.to(SearchPage()),
                           // onTapOutside: (v)=> FocusScope.of(context).requestFocus(FocusNode()),
                            decoration: InputDecoration(
                             
                              border: InputBorder.none,
                              hintText: 'Пошук будь-яких рецептів...',
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp, fontWeight: FontWeight.w400)
                            ),
                           ),
                         )
                      ],
                    ),
                  ),
                ),
               SizedBox(width: 8.sp,),
                Container(
                  child: GestureDetector(
                    onTap: () => Get.to(FilterPage()),
                    child: Container(
                      width: 45.sp,
                      height: 45.sp,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child:  Obx(() {
                          return Center(
                            child: Badge(
                            isLabelVisible: controller.hasActiveFilters ,
                           // label: Text("${selectionController.countActiveFilters()}"),
                           backgroundColor: Colors.red,
                           smallSize: 8,
                           alignment: Alignment(2, -1.4),
                            
                              child: Image.asset('assets/icons/filter.png', width: 20.sp, height: 20.sp,  color: const  Color(0xffF4612D)))
                          );
                        }
                      ),
                    ),
                  ),
                )
              ],
            ),
          
          ],
        ),
      ),
    );
  }
}
