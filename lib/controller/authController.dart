import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexpay/constant/AppUi.dart';
import 'package:flexpay/routes/routes.dart';
import 'package:flexpay/services/user_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  final FirebaseAuthService _authService = FirebaseAuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isLoading = false.obs;
  Future<void> login() async {
    if (emailController.value.text.isEmpty || passwordController.value.text.isEmpty) {
      AppUi.showSnackBar(
        title: 'Warning!',
        message: 'Please enter both email and password.',
      );
      return;
    }
    isLoading.value = true;
    try {
      User? user = await _authService.loginWithEmailAndPassword(
        emailController.value.text.trim(),
        passwordController.value.text.trim(),
      );
      if (user != null) {
        AppUi.showSnackBar(
          title: 'Login Successful',
          message: 'Welcome back, ${user.email}',
          isError: false,
          position: SnackPosition.BOTTOM,
        );
        Get.offNamed(AppRoutes.home);
        emailController.clear();
        passwordController.clear();
      } else {
        AppUi.showSnackBar(
          title: 'Login Failed',
          message: 'User not found',
        );
      }
    } catch (e) {
     debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

}
