import 'dart:convert';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();

  register(BuildContext context) async {
    String url = 'http://172.16.94.239/sertifikasi_jmp/user/register.php';
    var response = await http.post(Uri.parse(url), body: {
      'username': controllerUsername.text,
      'password': controllerPassword.text,
    });
    Map responseBody = jsonDecode(response.body);
    if (responseBody['success']) {
      DInfo.toastSuccess('Success Register');
      Navigator.pop(context);
    } else {
      if (responseBody['message'] == 'username') {
        DInfo.toastError('Username has already exist');
      } else {
        DInfo.toastError('Failed Register');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DView.textTitle(
              'Register Page',
              color: Colors.black,
            ),
            DView.height(),
            DInput(controller: controllerUsername, hint: 'Username'),
            DView.height(),
            DInput(controller: controllerPassword, hint: 'Password'),
            DView.height(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => register(context),
                child: const Text('Register'),
              ),
            ),
            DView.height(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
