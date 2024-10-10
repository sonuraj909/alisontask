import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:suryasilks/home_page.dart';
import 'dart:convert';

class LoginController extends GetxController {
  var isLoading = false.obs;

  Future<void> login(String emailPhone, String password) async {
    isLoading(true);
    final url = Uri.parse(
        'https://swan.alisonsnewdemo.online/api/login?email_phone=$emailPhone&password=$password');

    try {
      final response = await http.post(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == 1) {
          final customerData = data['customerdata'];
          final id = customerData['id'];
          final token = customerData['token'];

          Get.off(() => HomePage(id: id, token: token));
        } else {
          Get.snackbar('Login Failed', data['message']);
        }
      } else {
        Get.snackbar('Error', 'Failed to login. Please try again.');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred. Please try again later.');
    } finally {
      isLoading(false);
    }
  }
}

class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email or Phone'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            Obx(() {
              return loginController.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        final emailPhone = emailController.text;
                        final password = passwordController.text;
                        loginController.login(emailPhone, password);
                      },
                      child: const Text('Login'),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
