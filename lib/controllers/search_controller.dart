
import 'package:food_recipe_app/api/models/recipe.dart';
import 'package:food_recipe_app/controllers/filter_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class SearchRecipeController extends GetxController {
  var isLoading = true.obs;
  var status = "".obs;
  var recipesList = <Recipe>[].obs;

  @override
  void onInit() {
    super.onInit();
    //fetchRecipes();
  }
Future<List<Recipe>> getSearch(String searchText) async {
  

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('jwt_token');

  if (token == null) {
    throw Exception("Токен не знайдений");
  }

  final response = await http.get(
    Uri.parse('http://192.168.0.108:5000/api/searchRecipe?search=$searchText'),
    // Додаємо токен у заголовки
    headers: {
      'Content-Type': 'application/json',
      'authorization': token,
    },
  );

   if (response.statusCode == 200) { 
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((recipe) => Recipe.fromJson(recipe)).toList();
  } else {
    throw Exception('Не вдалося завантажити дані з сервера');
  }
}

Future<List<Recipe>> getSearchFilet(String filter) async {
  

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('jwt_token');

  if (token == null) {
    throw Exception("Токен не знайдений");
  }

  final response = await http.get(
    Uri.parse('http://192.168.0.108:5000/api/recipesFilter?$filter'),//category=Dessert&cookingTime=30'),
    // Додаємо токен у заголовки
    headers: {
      'Content-Type': 'application/json',
      'authorization': token,
    },
  );

   if (response.statusCode == 200) { 
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((recipe) => Recipe.fromJson(recipe)).toList();
  } else {
    throw Exception('Не вдалося завантажити дані з сервера');
  }
}

  void fetchRecipes(String nameCategory) async {
    final SelectionController controller = Get.find<SelectionController>();
    try {
      isLoading(true);

      var recipes =  controller.hasActiveFilters ? await getSearchFilet("category=${controller.selectedCategory}&cookingTime=${controller.selectedRangeValues.value.end.toInt()}") :await  getSearch(nameCategory);
      if (recipes.isNotEmpty) {
      //  recipesList.assignAll(recipes);
      recipesList.value = recipes;
      status.value = "ok";
      }
      if (recipes.isEmpty) {
      //  recipesList.assignAll(recipes);
     // recipesList.value = recipes;
      //Get.showSnackbar(GetSnackBar(title: "List Empty",));
      status.value = "empty";
      }
    } finally {
      isLoading(false);
    }
  }
}