// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
 // Для роботи з json

import 'package:flutter/material.dart';
import 'package:food_recipe_app/api/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:food_recipe_app/api/models/recipe.dart';

Future<List<Recipe>> fetchRecipes() async {
  final response = await http.get(Uri.parse('http://192.168.0.108:3000/api/popular_recipe'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((recipe) => Recipe.fromJson(recipe)).toList();
  } else {
    throw Exception('Failed to load recipes');
  }
}




Future<void> toggleFavorite(int recipeId) async {
    final String token = 'YOUR_TOKEN'; // Токен аутентифікації користувача
    final response = await http.post(
        Uri.parse('http://192.168.0.108:3000/api/favorites/toggle'),
        headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    },
        body: json.encode({'recipeId': recipeId}),
    );

    if (response.statusCode == 200) {
        // Успішне додавання або видалення
    } else {
        // Обробка помилок
    }
}



Future<RecipeDetail> fetchDetailsRecipe(recipeId) async {
  final response = await http.get(Uri.parse('http://192.168.0.108:5000/api/details_recipe?id=${recipeId}'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return  RecipeDetail.fromJson(jsonResponse[0]);
  } else {
       throw Exception('Failed to load recipes');
  }
}


Future<List<Recipe>> fetchData2() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('jwt_token');

  if (token == null) {
    throw Exception("Токен не знайдений");
  }

  final response = await http.get(
    Uri.parse('http://192.168.0.108:5000/api/popular_recipe'),
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






  Future <User> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if (token == null) {
      throw Exception("Токен не знайдений");
    }
      var url = Uri.parse('http://192.168.0.108:5000/user_info');
      var response = await http.get(url, headers: {
          'authorization': token,
      });

      if (response.statusCode == 200) {
        
        
        var jsonResponse = json.decode(response.body);
         print(jsonResponse);
    return User.fromJson(response.body );
          
      } else {
          throw Exception('Failed to load user data');
      }
  }