import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

void showSuccessAnimationGetX({String? message}) {
  Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/animations/Success.json',
              width: 150,
              height: 150,
              repeat: false,
            ),
            SizedBox(height: 10),
            Text(
              message ?? 'Success!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );

  // Auto close after 2 seconds
  Future.delayed(Duration(seconds: 2), () {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  });
}