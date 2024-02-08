import 'package:flutter/material.dart';
import 'package:food_recipe_app/controllers/auth_controller.dart';
import 'package:food_recipe_app/controllers/auther_contoroller.dart';
import 'package:food_recipe_app/controllers/filter_controller.dart';
import 'package:food_recipe_app/views/Login/sign_in_page.dart';
import 'package:food_recipe_app/views/endpoint.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isAuthenticated = prefs.getBool('isAuthenticated') ?? false;

  final AuthController authController = Get.put(AuthController());
  authController.isAuthenticated(isAuthenticated);
authController.isAuthenticated(false);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
 
    final SelectionController selectionFilterController = Get.put(SelectionController());
     final AuthController authController = Get.put(AuthController());

    return GetMaterialApp (
      debugShowCheckedModeBanner: false,
      title: 'Recipe App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  Obx(() {
        if (authController.isAuthenticated.value) {
          return MainScreen(); // Екран після входу в систему
        } else {
          return SignInPage(); // Екран аутентифікації
        }
      }),
    );
  }
}
