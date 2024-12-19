import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexpay/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  final FirebaseAuthService _authService = FirebaseAuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Loading state
  var isLoading = false.obs;

  // Login Method
  Future<void> login() async {
    if (emailController.value.text.isEmpty || passwordController.value.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter both email and password.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      User? user = await _authService.loginWithEmailAndPassword(
        emailController.value.text.trim(),
        passwordController.value.text.trim(),
      );

      Get.offNamed('/HomeScreen'); // Navigate to HomeScreen
        } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
