import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../API Service/api_service.dart';
import '../Constants/api_constant.dart';
import '../Route Manager/app_routes.dart';

class SignUpViewController extends GetxController {

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
      isLoading.value = true;

      try {
        // Prepare request body
        final requestBody = {
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
          "phone_number": phoneController.text.trim(),
          "full_name": fullNameController.text.trim(),
          "username": usernameController.text.trim(),
        };

        // Make API call
        final response = await ApiService.post<Map<String, dynamic>>(
          endpoint: setuSignUp,
          body: requestBody,
          fromJson: (json) => json as Map<String, dynamic>,
          includeToken: false, // No token needed for registration
        );

        if (response.success && response.data != null) {

          Get.snackbar(
            'Success',
            'Account created successfully!',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3),
          );

          // Clear form fields
          _clearFields();

          // Navigate to login or home
          Get.offAllNamed(AppRoutes.login);

        } else {
          // Handle API error
          Get.snackbar(
            'Error',
            response.errorMessage ?? 'Failed to create account. Please try again.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3),
          );
        }

      } catch (e) {
        Get.snackbar(
          'Error',
          'An unexpected error occurred: ${e.toString()}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      } finally {
        isLoading.value = false;
      }

  }

  void _clearFields() {
    usernameController.clear();
    fullNameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
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
