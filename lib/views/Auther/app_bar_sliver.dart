import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_app/api/models/auther.dart';
import 'package:food_recipe_app/controllers/auther_contoroller.dart';
import 'package:food_recipe_app/views/Auther/auther_page.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';



class AutherSliverAppBar extends StatelessWidget {
   AutherSliverAppBar({
    super.key,required this.author
  });
  AuthorDetail author;
  @override
  Widget build(BuildContext context) {
    
    return 
    SliverAppBarWidget(author: author);
    
    
    
  }
}

class SliverAppBarWidget extends StatelessWidget {
  AuthorDetail author;
   SliverAppBarWidget({
    super.key, required this.author
  });

  @override
  Widget build(BuildContext context) {
     
    
    

    return   SliverAppBar(
      pinned: true,
      floating: false,
      leadingWidth: 68,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      expandedHeight: 430.h,
      flexibleSpace: FlexibleSpaceBar(
       // collapseMode: CollapseMode.pin,
        background: Stack(
          children: [
            Image.network(
              "https://images.unsplash.com/photo-1611657366409-55549160be82?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDN8fHxlbnwwfHx8fHw%3D",
              fit: BoxFit.cover,
              width: double.infinity,
              height: 240,
              ),
          
            Positioned(
              top: 220,
              left: 0,
              right: 0,
              child: Container(
                height: 110.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                  color: Colors.white
                ),
              ),
            ),
             Positioned(child:  Align(
           alignment: Alignment(0, 0.9 ),
              
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                Obx(() {
  var avatarSize = Get.find<AvatarController>().avatarSize.value;
                        return Opacity(
                          opacity: avatarSize > 1 ? 1 / avatarSize : 1 ,
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              
                              child: 
                                     CircleAvatar(
                                      radius: avatarSize > 1 ? 62.r  / avatarSize : 62.r ,
                                      
                                      backgroundImage: NetworkImage( author.profilePhotoUrl,),
                                    ),
                                  
                                
                              
                            ),
                          ),
                          Text(author.name, style: TextStyle(color: Color(0xff242424), fontSize: 16.sp, fontWeight: FontWeight.w500),),
                          Text("Chef", style: TextStyle(color: Color(0xff747474), fontSize: 14.sp,)),
                        ],
                        ));
                    }
                  ),
                  SizedBox(height : 16),
                  SizedBox(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(author.recipeCount.toString(), style: TextStyle(color: Color(0xff242424), fontSize: 28.sp, fontWeight: FontWeight.w500),),
                            Text("Recipes", style: TextStyle(color: Color(0xff747474), fontSize: 12.sp,)),
                          ],
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 12.w),
                          child: VerticalDivider(
                            color:  Color(0xfff6f6f6)
                          ),
                        ),
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(author.followers.toString(), style: TextStyle(color: Color(0xff242424), fontSize: 28.sp, fontWeight: FontWeight.w500),),
                            Text("Followers", style: TextStyle(color: Color(0xff747474), fontSize: 12.sp,)),
                          ],
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 12.w),
                          child: VerticalDivider(
                            color:  Color(0xfff6f6f6)
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(author.following.toString(), style: TextStyle(color: Color(0xff242424), fontSize: 28.sp, fontWeight: FontWeight.w500),),
                            Text("Following", style: TextStyle(color: Color(0xff747474), fontSize: 12.sp,)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 46,
                            child: ElevatedButton(
                              onPressed: (){},
                              child: Center(child: Row(children: [Icon(Icons.follow_the_signs_outlined, color: Colors.white,),Text("Follow", style: TextStyle(color: Colors.white),)],)),
                              style: ButtonStyle(
                                elevation: MaterialStatePropertyAll(0),
                                backgroundColor: MaterialStatePropertyAll(Color(0xffF4612D))
                              ),
                              )
                            )
                          ),
                        SizedBox(width: 14,),
                         Expanded(
                          child: SizedBox(
                            height: 46,
                            child: OutlinedButton(
                              onPressed: (){},
                              child: Center(child: Row(children: [Icon(Icons.message, color: Color(0xffF4612D),),Text("Message", style: TextStyle(color: Color(0xffF4612D)),)],)),
                              style: ButtonStyle(
                                side: MaterialStatePropertyAll(
          BorderSide(color: Color(0xffF4612D), width: 1.0), // Тут встановлюється колір і товщина обводки
        ),
                                elevation: MaterialStatePropertyAll(0),
                               // backgroundColor: MaterialStatePropertyAll(Color)
                              ),
                              )
                            )
                          ),
                      ],
                    ),
                  ),
                 
                
                ],
              )
            ),),
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
        child: CircleAvatar(
          radius: 21.r,
          backgroundColor: Colors.white,
          child: Icon(Icons.favorite_outline),
        ),
      ),
      ],
    ); 
  }
}

