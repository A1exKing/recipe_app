

  import 'package:food_recipe_app/api/models/review_recipe.dart';
  import 'package:get/get.dart';
  import 'package:shared_preferences/shared_preferences.dart';
  import 'package:http/http.dart' as http;
  import 'dart:convert';
  class ReviewRecipeController extends GetxController {
    var isLoading = false.obs;
    var status = "".obs;
    var reviewRecipeList = <ReviewRecipe>[].obs;

    @override
    void onInit() {
      super.onInit();
      // Ви можете запустити завантаження даних тут, якщо потрібно
    }

Future<List<ReviewRecipe>> getReviewRecipe(String idRecipe) async {
  final token = await getToken();
  if (token == null) {
    Get.snackbar('Помилка', 'Токен не знайдений');
    return []; // Повернути порожній список
  }

  try {
    final response = await http.get(
      Uri.parse('http://192.168.0.108:5000/api/getReviewsRecipe?idRecipe=$idRecipe'),
      headers: {
        'Content-Type': 'application/json',
        'authorization': token,
      },
    );

   if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body) as List;
    var res = jsonResponse.map((recipeJson) => ReviewRecipe.fromMap(recipeJson)).toList();
    reviewRecipeList.value = res;
    return res;
  } else {
      Get.snackbar('Помилка', 'Не вдалося завантажити дані з сервера');
      return []; // Повернути порожній список
    }
  } catch (e) {
    Get.snackbar('Помилка', 'Виникла помилка при зверненні до сервера');
    return []; // Повернути порожній список у разі винятку
  }
}

    Future<String?> getToken() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('jwt_token');
    }
  }