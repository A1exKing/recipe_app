import 'package:food_recipe_app/api/api_recipe.dart';
import 'package:food_recipe_app/api/models/recipe.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class CategoryController extends GetxController {
  var isLoading = false.obs;
  var status = "".obs;
  var recipesList = <Recipe>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Ви можете запустити завантаження даних тут, якщо потрібно
  }

  Future<List<Recipe>> getRecipeInCategory(String nameCategory) async {
    final token = await getToken();
    if (token == null) {
      Get.snackbar('Помилка', 'Токен не знайдений');
      return [];
    }

    try {
      final response = await http.get(
        Uri.parse('http://192.168.0.108:5000/api/recipeInCategory?name=$nameCategory'),
        headers: {
          'Content-Type': 'application/json',
          'authorization': token,
        },
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((recipe) => Recipe.fromJson(recipe)).toList();
      } else {
        Get.snackbar('Помилка', 'Не вдалося завантажити дані з сервера');
        return [];
      }
    } catch (e) {
      Get.snackbar('Помилка', 'Виникла помилка при зверненні до сервера');
      return [];
    }
  }

  void fetchRecipes(String nameCategory) async {
    try {
      isLoading(true);
      var recipes = await getRecipeInCategory(nameCategory);
      recipesList.value = recipes;
      status.value = recipes.isNotEmpty ? "ok" : "empty";
    } finally {
      isLoading(false);
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }
}