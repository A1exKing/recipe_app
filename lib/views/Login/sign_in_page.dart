import 'package:flutter/material.dart';
import 'package:food_recipe_app/views/Login/create_account.dart';
import 'package:food_recipe_app/views/endpoint.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}
Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('jwt_token', token);
}
Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwt_token');
}
Future<void> removeToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('jwt_token');
}
void persistLogin() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isAuthenticated', true);
}
class _SignInPageState extends State<SignInPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login() async {
    
  var headers = {
  'Content-Type': 'application/json'
};
var request = http.Request('POST', Uri.parse('http://192.168.0.108:5000/login'));
request.body = json.encode({
  "username": _usernameController.text,
  "password": _passwordController.text  
});
request.headers.addAll(headers);
request.followRedirects = false;

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
 final responseBody = await response.stream.bytesToString();
  final decodedResponse = json.decode(responseBody);
  final token = decodedResponse['token'];
final error = decodedResponse['error'];
print(error);
print(token);
if(token == null){
  Get.showSnackbar(GetSnackBar(title: "Username ore password error",duration: Duration(seconds: 2),));
}
  await saveToken(token);
  persistLogin();

  Get.to(MainScreen());
}
else {
  print(response.reasonPhrase);
}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Вхід", style: TextStyle(color: Color(0xff242424), fontWeight: FontWeight.w500, fontSize: 26),),
            const SizedBox(height: 12,),
            Text("Привіт. Ласкаво просимо, за вами скучили!", style: TextStyle(color: Color(0xff747474),  fontSize: 14),),
          const SizedBox(height: 54,),
           SizedBox(
              height: 52,
              child: TextField(
            
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  fillColor: const Color(0xfff6f6f6),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none
                  ),
                  
                ),
                //obscureText: true,
              ),
            ),
            const SizedBox(height: 18,),
            SizedBox(
              height: 52,
              child: TextField(
            
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Пароль',
                  fillColor: const Color(0xfff6f6f6),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none
                  ),
                  
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 44,),
            SizedBox(
              height: 54,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: login,
                style:const ButtonStyle(
                  elevation: MaterialStatePropertyAll(0),
                  backgroundColor:  MaterialStatePropertyAll(Color(0xffFF7C32))
                ),
                child: Text('Увійти', style: TextStyle(color: Colors.white, fontSize: 18),),
              ),
            ),
            SizedBox(height: 24,),
            Text.rich(
            TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: "Немає облікового запису? ",
                  style: TextStyle(color: Colors.black),
                ),
                WidgetSpan(
                 // alignment: Alignment.,
                  child: InkWell(
                    onTap: () {
                      Get.to(CreateAccountPage());
                    },
                    child: Text(
                      "Зареєструватися",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xffFF7C32), fontWeight: FontWeight.normal, decoration: TextDecoration.underline, decorationColor: Colors.red,),
                    ),
                  ),
                ),
              ],
            ),
          ),
            
          ],
        ),
      ),
    );
  }
}