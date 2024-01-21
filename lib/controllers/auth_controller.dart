
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isAuthenticated = false.obs;

  void login() {
    isAuthenticated(true);
    // Додатковий код для аутентифікації...
  }

  void logout() {
    isAuthenticated(false);
    // Додатковий код для виходу з системи...
  }
}