import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'admin_page.dart';

class LoginAdminPage extends StatelessWidget {
  LoginAdminPage({super.key});
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  Future<void> loginAdmin(BuildContext context) async {
    String url =
        'http://192.168.18.4/sertifikasi_jmp/user/admin.php'; // URL ke script PHP
    var response = await http.post(Uri.parse(url), body: {
      'username': controllerUsername.text,
      'password': controllerPassword.text,
    });
    print(response.body);
    Map responseBody = jsonDecode(response.body);
    if (responseBody['success']) {
      DInfo.toastSuccess('Login Success');
      // Navigasi ke AdminPage setelah login berhasil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AdminPage(),
        ),
      );
    } else {
      DInfo.toastError(responseBody['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.blue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DView.textTitle('Login Admin', color: Colors.black),
                DView.height(),
                TextField(
                  controller: controllerUsername,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                DView.height(),
                TextField(
                  controller: controllerPassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: true,
                ),
                DView.height(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => loginAdmin(context),
                    child: Text("Login"),
                  ),
                ),
                DView.height(),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Back to Login"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
