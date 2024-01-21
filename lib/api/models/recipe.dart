import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class Recipe {
   String id;
  String imageUrl; // Шлях або URL до зображення страви
  double rating; // Рейтинг страви
  String name; // Назва страви
  int cookingTime; // Час приготування у хвилинах
  String difficulty; // Складність страви
  String author; // Автор рецепту
  List<String>?  tags; // Позначки або категорії до яких належить страва
   RxBool isFavorite;

  Recipe({
    required this.id,
    required this.imageUrl,
    required this.rating,
    required this.name,
    required this.cookingTime,
    required this.difficulty,
    required this.author,
    required this.tags,
     bool isFavorite = false,
  }) : this.isFavorite = RxBool(isFavorite);
 void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
    // Тут ви можете додати логіку для синхронізації з сервером
  }
    Recipe.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
      imageUrl =  json['imageurl'] ,
        rating = json['rating'].toDouble(), // Переконайтеся, що рейтинг конвертовано в double
        name = json['name'],
        cookingTime = json['cookingtime'],
        difficulty = json['difficulty'],
        author = json['author'] ?? "",
       // tags = List<String>.from(json['tags']),
         isFavorite = false.obs;
}



class RecipeDetail {
   String id;
  String imageUrl; // Шлях або URL до зображення страви
  double rating; // Рейтинг страви
  String name; // Назва страви
   String description;
  int cookingTime; // Час приготування у хвилинах
  String difficulty; // Складність страви
  String author; // Автор рецепту
  String? plan;
  List<String> ingridients;
  List<String> tags; // Позначки або категорії до яких належить страва
   RxBool isFavorite;

  RecipeDetail({
    required this.id,
    required this.imageUrl,
    required this.rating,
    required this.name,
     required this.description,
    required this.cookingTime,
    required this.difficulty,
    required this.author,
    required this.ingridients,
    required this.tags,
    required this.plan,
     bool isFavorite = false,
  }) : this.isFavorite = RxBool(isFavorite);

    RecipeDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
      imageUrl = json['imageurl'],
        rating = json['rating'].toDouble(), // Переконайтеся, що рейтинг конвертовано в double
        name = json['name'],
        description = json['description'],
        cookingTime = json['cookingtime'],
        difficulty = json['difficulty'],
        author = json['author'] ?? "auther",
      tags = json['tags'].split(','),
        plan = json["instructions"],
       ingridients = (json['ingredients'] as List).map((ing) {
        String name = ing.keys.first;
        String quantity = ing.values.first;
       
        return "$name: $quantity";  
      }).toList(),
         isFavorite = RxBool(json['is_favorite']);
}

class RecipeController extends GetxController {
   var recipes = <Recipe>[].obs;
  var favoriteRecipes = <String>[].obs; // Зберігає ID улюблених рецептів
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchRecipes();
    getFavoriteRecipesList();
  }



void getFavoriteRecipesList() async {
    try {
      // Тут реалізуйте запит до сервера для отримання улюблених рецептів
      var response = await http.get(Uri.parse('http://192.168.0.108:5000/api/favoritesId/26'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;
    favoriteRecipes.value = data.map((item) => item['recipe_id'].toString()).toList();
      }
    } catch (e) {
      // Обробка помилок
    }
  }








  Future<List<Recipe>> fetchRecipesAuthor(idAuthor) async {
   final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('jwt_token');

  if (token == null) {
    throw Exception("Токен не знайдений");
  }
isLoading(true);
try{
  final response = await http.get(
    Uri.parse('http://192.168.0.108:5000/api/getAthourRecipe?id=$idAuthor'),
    // Додаємо токен у заголовки
    headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    },
  );

   if (response.statusCode == 200) {
     List jsonResponse = json.decode(response.body);
     recipes.value = jsonResponse.map((json) => Recipe.fromJson(json)).toList();
    return jsonResponse.map((recipe) => Recipe.fromJson(recipe)).toList();
  } else {
    throw Exception('Не вдалося завантажити дані з сервера');
  }
  } finally {
      isLoading(false);
    }
  }













  Future<List<Recipe>> fetchRecipes() async {
   final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('jwt_token');

  if (token == null) {
    throw Exception("Токен не знайдений");
  }
isLoading(true);
try{
  final response = await http.get(
    Uri.parse('http://192.168.0.108:5000/api/popular_recipe'),
    // Додаємо токен у заголовки
    headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    },
  );

   if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
     recipes.value = jsonResponse.map((json) => Recipe.fromJson(json)).toList();
    return jsonResponse.map((recipe) => Recipe.fromJson(recipe)).toList();
  } else {
    throw Exception('Не вдалося завантажити дані з сервера');
  }
  } finally {
      isLoading(false);
    }
  }
  void toggleFavorite(String recipeId) {
    toggleFavoriteR(recipeId);
    if (favoriteRecipes.contains(recipeId)) {
      favoriteRecipes.remove(recipeId);
      
    } else {
      favoriteRecipes.add(recipeId);
    }
    update(); // Оновлює UI
  }
Future<RecipeDetail> fetchRecipeDetails(String recipeId) async {
   final response = await http.get(Uri.parse('http://192.168.0.108:5000/api/details_recipe?id=${recipeId}'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return  RecipeDetail.fromJson(jsonResponse[0]);
  } else {
    throw Exception('Failed to load recipes');
  }
  }


  Future<void> toggleFavoriteR(String  recipeId) async {
    // Перемикання стану локально
    
    //recipe.isFavorite.value = !recipe.isFavorite.value;
 final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('jwt_token')!;
    try {
      // Відправлення запиту на сервер
      final response = await http.post(
        Uri.parse('http://192.168.0.108:5000/api/favorites/toggle'),
        headers: <String, String>{ 
        'Content-Type': 'application/json',
      'authorization': token,
        },
        
        body: json.encode({'recipeId': recipeId}),
      );

      if (response.statusCode != 200) {
     // Recipe? recipe = recipes.firstWhereOrNull((r) => r.id == recipeId);
          //recipe?.isFavorite.value = !recipe.isFavorite.value;
          //  recipe?.isFavorite.toggle(); 
        // Якщо сталася помилка, повернути стан назад
       // recipe.isFavorite.value = !recipe.isFavorite.value;
        // Можете додати обробку помилок тут
      }else{
          print("toggle favorite");
        //  Recipe? recipe = recipes.firstWhereOrNull((r) => r.id == recipeId);
         //recipe?.isFavorite.value = !recipe.isFavorite.value;
         
      }
    } catch (e) {
     
      // Якщо сталася помилка, повернути стан назад
      //recipe.isFavorite.value = !recipe.isFavorite.value;
      // Можете додати обробку помилок тут
    }
  }
}