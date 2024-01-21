import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_recipe_app/views/Login/sign_in_page.dart';
import 'package:food_recipe_app/views/endpoint.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
//import 'package:fluttertoast/fluttertoast.dart';


class HomeController extends GetxController {
  var selectedGender = Rx<String?>(null);

  void selectGender(String? gender) {
    if (gender != null) {
      selectedGender.value = gender;
    }
  }
}

class ImagePickerController extends GetxController {
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
    final controller = Get.find<ImagePickerController>();
    controller.setImage(imageFile);
    
    // Оновлюємо стан завантаження
    controller.isLoading(true);
final String? token = await getToken();
 if (token == null) throw Exception("Токен не отримано");
    // Відправлення на сервер
    var uri = Uri.parse('http://192.168.0.108:5000/uploadPhoto');
    var request = http.MultipartRequest('POST', uri)
     ..headers.addAll({
    'authorization': token, // Додаємо токен як Bearer token
  })
      ..files.add(await http.MultipartFile.fromPath('picture', imageFile.path));
      
    try {
      var response = await request.send();

      if (response.statusCode == 200) {
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

class CompleteProfile extends StatelessWidget {
  const CompleteProfile({super.key});


  @override
  Widget build(BuildContext context) {
     final ImagePickerController controllerPhoto = Get.put(ImagePickerController());
   final HomeController controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: [
              Text("Create Account", style: TextStyle(color: Color(0xff242424), fontWeight: FontWeight.w500, fontSize: 26),),
              const SizedBox(height: 12,),
              Text("Fill your information below or register with your sociaal account.", textAlign: TextAlign.center, style: TextStyle(color: Color(0xff747474),  fontSize: 14),),
              const SizedBox(height: 22,),
               Obx(()  {
                
                  return GestureDetector(
                    onTap: () => uploadImage(),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                           backgroundImage: controllerPhoto.imageProvider.value != null 
    ? controllerPhoto.imageProvider.value as ImageProvider 
    : null,
                          backgroundColor: Color(0xfff6f6f6),
                          child: Icon(Icons.photo_camera, color: Color(0xffFF7C32),),
                        ),
                        Transform.translate(
                          offset: Offset(35,35),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2)
                            ),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Color(0xffFF7C32),
                              child: Icon(Icons.edit_outlined, color: Colors.white,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              ),
               const SizedBox(height: 44,),
               SizedBox(
              height: 52,
              child: TextField(
            
               
                decoration: InputDecoration(
                  labelText: 'Name',
                  fillColor: const Color(0xfff6f6f6),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none
                  ),
                  
                ),
                
              ),
            ),
            const SizedBox(height: 18,),
             SizedBox(
              height: 52,
              child: TextField(               
                decoration: InputDecoration(
                  labelText: 'Username',
                  fillColor: const Color(0xfff6f6f6),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none
                  ),
                  
                ),
                
              ),
            ),
            const SizedBox(height: 18,),
             SizedBox(
              height: 52,
              child:  Obx(() => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 52,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xfff6f6f6),
                  borderRadius: BorderRadius.circular(14)
                ),
                child: DropdownButton<String>(
                    elevation: 2,
                    underline: Container(),
                    isExpanded: true,
                        hint: Text(controller.selectedGender.value ?? 'Select'),
                        value: controller.selectedGender.value,
                        onChanged: (String? newValue) {
                          controller.selectGender(newValue);
                        },
                        items: <String>['Male', 'Female', 'Other']
                .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
                          );
                        }).toList(),
                      ),
              )),
            ),
            const SizedBox(height: 18,),
             SizedBox(
              height: 54,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ()=> Get.to(MainScreen()),
                style:const ButtonStyle(
                  elevation: MaterialStatePropertyAll(0),
                  backgroundColor:  MaterialStatePropertyAll(Color(0xffFF7C32))
                ),
                child: Text('Complete', style: TextStyle(color: Colors.white, fontSize: 18),),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}