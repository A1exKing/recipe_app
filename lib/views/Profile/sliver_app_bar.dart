
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_app/api/models/auther.dart';
import 'package:food_recipe_app/controllers/user_conreoller.dart';
import 'package:food_recipe_app/views/Login/sign_in_page.dart';
import 'package:food_recipe_app/views/Profile/user_profile_page.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


class ImagePickerBackController extends GetxController {
  Rx<ImageProvider?> imageProvider = Rx<FileImage?>(null);
  var isLoading = false.obs;
  void setImage(File file) {
    imageProvider.value = FileImage(file);
  }
}
// Вибір фото
Future<void> uploadImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  
  if (pickedFile != null) {
    File imageFile = File(pickedFile.path); 
    final ImagePickerBackController controller = Get.find<ImagePickerBackController>();
    
    controller.setImage(imageFile);
    
    // Оновлюємо стан завантаження
    controller.isLoading(true);
final String? token = await getToken();
 if (token == null) throw Exception("Токен не отримано");
    // Відправлення на сервер
    var uri = Uri.parse('http://192.168.0.108:5000/uploadBackPhotoProfile');
    var request = http.MultipartRequest('POST', uri)
     ..headers.addAll({
    'authorization': token, // Додаємо токен як Bearer token
  })
      ..files.add(await http.MultipartFile.fromPath('picture', imageFile.path));
      
    try {
      var response = await request.send();

      if (response.statusCode == 200) {
         final responseBytes = await response.stream.toBytes();
    final responseBody = String.fromCharCodes(responseBytes);
     final parsedResponse = json.decode(responseBody);
    print(parsedResponse["back_profile_photo"]);
        final UserController userController = Get.find<UserController>();
        userController.updateBackProfilePhoto(parsedResponse["back_profile_photo"]);
        Get.showSnackbar(GetSnackBar(
          message: 'Фото завантажено успішно',
          duration: Duration(seconds: 2),
        ));
      } else {
        Get.showSnackbar(GetSnackBar(
          message: 'Помилка завантаження',
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: 'Виникла помилка: $e',
        duration: Duration(seconds: 2),
      ));
    } finally {
      controller.isLoading(false);
    }
  }
}





class UserSliverAppBar extends StatelessWidget {
   UserSliverAppBar({
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
  final controllerPhotoBack = Get.put(ImagePickerBackController());
      final UserController userController = Get.find<UserController>();
  AuthorDetail author;
   SliverAppBarWidget({
    super.key, required this.author
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
           Obx(() {
                return userController.userData.value.backProfilePhoto == null? 
                Image.network(
                  
                  "https://media.istockphoto.com/id/1316145932/photo/table-top-view-of-spicy-food.webp?b=1&s=170667a&w=0&k=20&c=P3jIQq8gVqlXjd4kP2OrXYyzqEXSWCwwYtwrd81psDY=",
                  
                  
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 240,
                  ) :
                   Image.network(
                  
                  "http://192.168.0.108:5000/api/user/photo?photo=${userController.userData.value.backProfilePhoto}",
                   fit: BoxFit.cover,
                  width: double.infinity,
                  height: 240,
                  );
                  // Image(image:  controllerPhotoBack.imageProvider.value!,
                  // fit: BoxFit.cover,
                  // width: double.infinity,
                  // height: 240,
                  // );
              }
            )
              ,
            Positioned(
              top: 175,
              right: 20,
              child:  GestureDetector(
                onTap: () => uploadImage(),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6
                  ),
                
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
                    color: Colors.white
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.photo_camera, color: Color(0xffF4612D),size: 18,),
                      SizedBox(width: 6,),
                      Text("Edit", style: TextStyle(fontSize: 12, color: Color(0xff242424)),)
                    ],
                  ),
                ),
              )
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
  var avatarSize = Get.find<PrifileAvatarController>().avatarSize.value;
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
                                      
                                      backgroundImage: NetworkImage("http://192.168.0.108:5000/api/user/photo?photo=${userController.userData.value.photo}"),
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
                              child: Center(child: Row(children: [Icon(Icons.edit, color: Colors.white,),Text("Edit Profile", style: TextStyle(color: Colors.white),)],)),
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
                              child: Center(child: Row(children: [Icon(Icons.qr_code, color: Color(0xffF4612D),),Text("QR-Code", style: TextStyle(color: Color(0xffF4612D)),)],)),
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
        padding:  EdgeInsets.only(right: 20.w),
        child: CircleAvatar(
          radius: 21.r,
          backgroundColor: Colors.white,
          child: Icon(Icons.settings_outlined),
        ),
      ),
      ],
    );
  }
}

