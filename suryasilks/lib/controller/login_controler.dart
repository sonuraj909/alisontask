import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var isLoading = false.obs;

  var statusMessage = ''.obs;

  final String loginUrl = 'https://swan.alisonsnewdemo.online/api/login';

  Future<void> login() async {
    final emailPhone = emailController.text.trim();
    final password = passwordController.text.trim();

    if (emailPhone.isEmpty || password.isEmpty) {
      statusMessage.value = 'Email/Phone and Password cannot be empty';
      return;
    }

    try {
      isLoading(true);

      final response = await http.post(
        Uri.parse('$loginUrl?email_phone=$emailPhone&password=$password'),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData['success'] == 1) {
        statusMessage.value = 'Login Success';
        final customerData = responseData['customerdata'];

        print('User Token: ${customerData['token']}');
      } else {
        statusMessage.value = responseData['message'] ?? 'Login failed';
      }
    } catch (e) {
      statusMessage.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }
}
