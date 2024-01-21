import 'package:flutter/material.dart';
import 'package:food_recipe_app/views/Login/comlete_profile.dart';
import 'package:food_recipe_app/views/Login/sign_in_page.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateAccountPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userLoginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

   CreateAccountPage({super.key});
Future<void> register() async {
    
  var headers = {
  'Content-Type': 'application/json'
};
var request = http.Request('POST', Uri.parse('http://192.168.0.108:5000/register'));
request.body = json.encode({
  "username": _nameController.text,
  "email":_userLoginController.text,
  "password":_passwordController.text
});
request.headers.addAll(headers);
request.followRedirects = false;

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
 final responseBody = await response.stream.bytesToString();
 print(responseBody);
 final decodedResponse = json.decode(responseBody);
 final token = decodedResponse['token'];

  await saveToken(token);
 // Get.showSnackbar(GetSnackBar(title: "User register", duration: Duration(seconds: 2),));
 Get.to(() =>CompleteProfile());
}
else {
  print(response.reasonPhrase);
  Get.showSnackbar(GetSnackBar(title: "Error", duration: Duration(seconds: 2),));
}

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
     body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Create Account", style: TextStyle(color: Color(0xff242424), fontWeight: FontWeight.w500, fontSize: 26),),
            const SizedBox(height: 12,),
            Text("Fill your information below or register with your sociaal account.", textAlign: TextAlign.center, style: TextStyle(color: Color(0xff747474),  fontSize: 14),),
          const SizedBox(height: 54,),
           SizedBox(
              height: 52,
              child: TextField(
                controller: _nameController,
               
                decoration: InputDecoration(
                  labelText: 'Name',
                  fillColor: const Color(0xfff6f6f6),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none
                  ),
                  
                ),
                
              ),
            ),
            const SizedBox(height: 18,),
            SizedBox(
              height: 52,
              child: TextField(
            
               controller: _userLoginController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  fillColor: const Color(0xfff6f6f6),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none
                  ),
                  
                ),
                
              ),
            ),
            const SizedBox(height: 18,),
            SizedBox(
              height: 52,
              child: TextField(
            controller: _passwordController,
               
                decoration: InputDecoration(
                  labelText: 'Password',
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
                onPressed: () => register(),
                
                style:const ButtonStyle(
                  elevation: MaterialStatePropertyAll(0),
                  backgroundColor:  MaterialStatePropertyAll(Color(0xffFF7C32))
                ),
                child: Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 18),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}