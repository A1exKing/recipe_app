import 'package:food_recipe_app/api/api_recipe.dart';
import 'package:food_recipe_app/api/models/auther.dart';
import 'package:food_recipe_app/api/models/recipe.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';




class AutherController extends GetxController {
  var isLoading = false.obs;
  var status = "".obs;
  var authorsList = <AuthorDetail>[].obs;

  @override
  void onInit() {
    super.onInit();
    
  }

  Future<List<AuthorDetail>> getAutherDetail(String id) async {
    final token = await getToken();
    if (token == null) {
      Get.snackbar('Помилка', 'Токен не знайдений');
      return [];
    }

    try {
      final response = await http.get(
        Uri.parse('http://192.168.0.108:5000/api/getAthourDetail?id=$id'),
        headers: {
          'Content-Type': 'application/json',
          'authorization': token,
        },
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse. map((author) => AuthorDetail.fromJson(author)).toList();
      } else {
        Get.snackbar('Помилка', 'Не вдалося завантажити дані з сервера');
        return [];
      }
    } catch (e) {
      Get.snackbar('Помилка', 'Виникла помилка при зверненні до сервера $e');
      return [];
    }
  }

    Future<AuthorDetail?> getAutherDetailByID(String id) async {
    final token = await getToken();
    if (token == null) {
      Get.snackbar('Помилка', 'Токен не знайдений');
      return null;
    }

    try {
      final response = await http.get(
        Uri.parse('http://192.168.0.108:5000/api/getAthourDetailID?id=$id'),
        headers: {
          'Content-Type': 'application/json',
          'authorization': token,
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return AuthorDetail.fromJson(jsonResponse);
      } else {
        Get.snackbar('Помилка', 'Не вдалося завантажити дані з сервера');
        return null;
      }
    } catch (e) {
      Get.snackbar('Помилка', 'Виникла помилка при зверненні до сервера $e');
      return null;
    }
  }

 
  void fetchAuthors(String idAuthor) async {
    try {
      isLoading(true);
      var authors = await getAutherDetail(idAuthor);
      authorsList.value = authors;
      status.value = authors.isNotEmpty ? "ok" : "empty";
    } finally {
      isLoading(false);
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }
}



class AutherDetailController extends GetxController {
  var isLoading = false.obs;
  var status = "".obs;

var author = AuthorDetail.empty().obs;


  @override
  void onInit() {
    super.onInit();
    
  }

  

    Future<AuthorDetail?> getAutherDetailByID(String id) async {
    final token = await getToken();
    if (token == null) {
      Get.snackbar('Помилка', 'Токен не знайдений');
      return null;
    }

    try {
      final response = await http.get(
        Uri.parse('http://192.168.0.108:5000/api/getAthourDetailID?id=$id'),
        headers: {
          'Content-Type': 'application/json',
          'authorization': token,
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        var jsonResponse = json.decode(response.body);
        return AuthorDetail.fromJson(jsonResponse);
      } else {
        Get.snackbar('Помилка', 'Не вдалося завантажити дані з сервера');
        return null;
      }
    } catch (e) {
      Get.snackbar('Помилка', 'Виникла помилка при зверненні до сервера $e');
      return null;
    }
  }

 
  void fetchAuthorDetail(String idAuthor) async {
    try {
      isLoading(true);
      var thisAuthor = await getAutherDetailByID(idAuthor);
      author.value = thisAuthor!;
      status.value = thisAuthor != null ? "ok" : "empty";
    } finally {
      isLoading(false);
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }
}