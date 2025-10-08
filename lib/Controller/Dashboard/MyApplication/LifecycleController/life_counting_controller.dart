// import 'package:get/get.dart';
// import 'dart:developer' as developer;
//
// import '../../../../API Service/api_service.dart';
// import '../../../../Constants/api_constant.dart';
// import '../../../../Models/payment_model.dart';
// import '../../../../View/Dashboard/MyApplication/AllPagesLifecycle/FormLifecycle/components/qr_code_view.dart';
//
// class LifeCountingController extends GetxController with StateMixin<PaymentData> {
//   final int formId;
//
//   LifeCountingController({required this.formId});
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchPaymentDetails();
//   }
//
//   Future<void> fetchPaymentDetails() async {
//     try {
//       change(null, status: RxStatus.loading());
//
//       final response = await ApiService.get<PaymentResponse>(
//         endpoint: lifeCycleCountingLand(formId),
//         fromJson: (json) => PaymentResponse.fromJson(json),
//         includeToken: true,
//       );
//
//       developer.log('Response success: ${response.success}');
//       developer.log('Response data: ${response.data}');
//
//       if (response.success && response.data != null) {
//         // The response.data is PaymentResponse, so we need to get the nested data field
//         final paymentData = response.data!.data;
//
//         developer.log('Payment Data: $paymentData');
//
//         if (paymentData != null) {
//           change(paymentData, status: RxStatus.success());
//         } else {
//           change(null, status: RxStatus.empty());
//         }
//       } else {
//         throw Exception(response.errorMessage ?? 'Failed to load payment details');
//       }
//     } catch (e, stackTrace) {
//       developer.log('Error fetching payment: $e', error: e, stackTrace: stackTrace);
//       change(null, status: RxStatus.error('Failed to fetch payment: ${e.toString()}'));
//     }
//   }
//
//   Future<void> refreshPaymentStatus() async {
//     await fetchPaymentDetails();
//   }
//
//   void openQrCodeFullScreen(String qrCodeBase64, String title) {
//     Get.to(() => QrCodeFullScreenView(
//       qrCodeBase64: qrCodeBase64,
//       title: title,
//     ));
//   }
// }

import 'package:get/get.dart';
import 'dart:developer' as developer;
import '../../../../API Service/api_service.dart';
import '../../../../Constants/api_constant.dart';
import '../../../../Models/payment_model.dart';
import '../../../../View/Dashboard/MyApplication/AllPagesLifecycle/FormLifecycle/components/qr_code_view.dart';

class LifeCountingController extends GetxController with StateMixin<PaymentData> {
  final int formId;


  LifeCountingController({required this.formId});

  // File upload observables
  final measurementChalanFiles = <String>[].obs;
  final convenienceChalanFiles = <String>[].obs;


  @override
  void onInit() {
    super.onInit();
    fetchPaymentDetails();
  }

  Future<void> fetchPaymentDetails() async {
    try {
      change(null, status: RxStatus.loading());

      final response = await ApiService.get<PaymentResponse>(
        endpoint: lifeCycleCountingLand(formId),
        fromJson: (json) => PaymentResponse.fromJson(json),
        includeToken: true,
      );

      developer.log('Response success: ${response.success}');
      developer.log('Response data: ${response.data}');

      if (response.success && response.data != null) {
        final paymentData = response.data!.data;

        developer.log('Payment Data: $paymentData');

        if (paymentData != null) {
          change(paymentData, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.empty());
        }
      } else {
        throw Exception(response.errorMessage ?? 'Failed to load payment details');
      }
    } catch (e, stackTrace) {
      developer.log('Error fetching payment: $e', error: e, stackTrace: stackTrace);
      change(null, status: RxStatus.error('Failed to fetch payment: ${e.toString()}'));
    }
  }

  Future<void> uploadMeasurementChalan() async {
    if (measurementChalanFiles.isEmpty) {
      Get.snackbar('Error', 'Please select a file to upload');
      return;
    }

    if (state?.id == null) {
      Get.snackbar('Error', 'Payment ID not found');
      return;
    }

    try {
      // isMeasurementUploading.value = true;

      final response = await ApiService.multipartPost(
        endpoint: lifeCycleCountingLandChalanSubmission(state!.id),
        fields: {}, // Empty fields map if no additional text fields
        files: [
          MultipartFiles(
            field: 'chalan_file',
            filePath: measurementChalanFiles.first,
          ),
        ],
        fromJson: (json) => json, // Return raw json
        includeToken: true,
      );

      developer.log('Measurement Chalan Upload Response: ${response.data}');

      if (response.success) {
        // measurementUploadSuccess.value = true;
        Get.snackbar(
          'Success',
          'Measurement chalan uploaded successfully',
          snackPosition: SnackPosition.TOP,
        );
        // Refresh payment details
        await fetchPaymentDetails();
      } else {
        throw Exception(response.errorMessage ?? 'Upload failed');
      }
    } catch (e, stackTrace) {
      developer.log('Error uploading measurement chalan: $e', error: e, stackTrace: stackTrace);
      Get.snackbar(
        'Error',
        'Failed to upload measurement chalan: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      // isMeasurementUploading.value = false;
    }
  }

  Future<void> uploadConvenienceChalan() async {
    if (convenienceChalanFiles.isEmpty) {
      Get.snackbar('Error', 'Please select a file to upload');
      return;
    }

    if (state?.id == null) {
      Get.snackbar('Error', 'Payment ID not found');
      return;
    }

    try {
      // isConvenienceUploading.value = true;

      final response = await ApiService.multipartPost(
        endpoint: lifeCycleCountingLandConvenienceSubmission(state!.id),
        fields: {}, // Empty fields map if no additional text fields
        files: [
          MultipartFiles(
            field: 'chalan_file',
            filePath: convenienceChalanFiles.first,
          ),
        ],
        fromJson: (json) => json, // Return raw json
        includeToken: true,
      );

      developer.log('Convenience Chalan Upload Response: ${response.data}');

      if (response.success) {
        // convenienceUploadSuccess.value = true;
        Get.snackbar(
          'Success',
          'Convenience chalan uploaded successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        // Refresh payment details
        await fetchPaymentDetails();
      } else {
        throw Exception(response.errorMessage ?? 'Upload failed');
      }
    } catch (e, stackTrace) {
      developer.log('Error uploading convenience chalan: $e', error: e, stackTrace: stackTrace);
      Get.snackbar(
        'Error',
        'Failed to upload convenience chalan: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      // isConvenienceUploading.value = false;
    }
  }


  Future<void> refreshPaymentStatus() async {
    await fetchPaymentDetails();
  }

  void openQrCodeFullScreen(String qrCodeBase64, String title) {
    Get.to(() => QrCodeFullScreenView(
      qrCodeBase64: qrCodeBase64,
      title: title,
    ));
  }
}