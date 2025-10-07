import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'dart:convert';
import '../../../../../../Controller/get_translation_controller/get_text_form.dart';

class QrCodeFullScreenView extends StatelessWidget {
  final String qrCodeBase64;
  final String title;

  const QrCodeFullScreenView({
    super.key,
    required this.qrCodeBase64,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(PhosphorIcons.x(PhosphorIconsStyle.regular)),
          onPressed: () => Get.back(),
        ),
        title: GetTranslatableText(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Image.memory(
                base64Decode(qrCodeBase64.split(',')[1]),
                width: 300.w,
                height: 300.w,
                fit: BoxFit.contain,
              ),
            ),
            Gap(24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: GetTranslatableText(
                'Scan this QR code using any UPI app',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Gap(32.h),
          ],
        ),
      ),
    );
  }
}