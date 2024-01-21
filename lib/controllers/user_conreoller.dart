import 'package:food_recipe_app/api/api_recipe.dart';
import 'package:food_recipe_app/api/models/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var isLoading = true.obs;
  var userData =  User(userName: "userName", email: "email", photo: "photo", backProfilePhoto: null).obs;
 void updateBackProfilePhoto(String newPhotoUrl) {
    userData.update((val) {
      val?.backProfilePhoto = newPhotoUrl;
    });
  }
  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() async {
    try {
      isLoading(true);
      var data = await getUserData();
      userData(data);
    } catch (e) {
      // Обробка помилок
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}