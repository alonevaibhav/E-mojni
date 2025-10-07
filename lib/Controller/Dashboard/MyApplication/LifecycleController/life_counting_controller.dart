import 'package:get/get.dart';
import 'dart:developer' as developer;

import '../../../../API Service/api_service.dart';
import '../../../../Constants/api_constant.dart';
import '../../../../Models/payment_model.dart';
import '../../../../View/Dashboard/MyApplication/AllPagesLifecycle/FormLifecycle/components/qr_code_view.dart';

class LifeCountingController extends GetxController with StateMixin<PaymentData> {
  final int formId;

  LifeCountingController({required this.formId});

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
        // The response.data is PaymentResponse, so we need to get the nested data field
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