import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Route Manager/app_routes.dart';

class SignUpViewController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void signUp() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      try {
        // Simulate API call
        await Future.delayed(const Duration(seconds: 2));

        // Add your sign-up API logic here
        // Example:
        // final response = await apiService.signUp(
        //   username: usernameController.text,
        //   fullName: fullNameController.text,
        //   email: emailController.text,
        //   phone: phoneController.text,
        //   password: passwordController.text,
        // );

        Get.snackbar(
          'Success',
          'Account created successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to login or home
        Get.offAllNamed(AppRoutes.login);

      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to create account. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}