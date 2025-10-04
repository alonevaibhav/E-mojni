import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../API Service/api_service.dart';
import '../../../Constants/api_constant.dart';
import '../../../Models/preview_model.dart';

class PreviewController extends GetxController with StateMixin<List<CountingLandForm>> {
  late String formType;
  late String formName;

  @override
  void onInit() {
    super.onInit();

    // Get arguments passed from navigation
    final args = Get.arguments as Map<String, dynamic>?;

    if (args != null) {
      formType = args['formType'] ?? ''; // e.g., 'counting_land'
      formName = args['formName'] ?? ''; // e.g., 'Counting Land'

      developer.log(
          'PreviewController initialized with formType: $formType, formName: $formName');

      // Fetch forms data
      fetchFormsByType();
    } else {
      change(null, status: RxStatus.error('No arguments provided'));
    }
  }

  Future<void> fetchFormsByType() async {
    try {
      change(null, status: RxStatus.loading());

      // Get user ID
      String userId = (await ApiService.getUid()) ?? "0";
      developer.log('🆔 User ID: $userId');

      // Make API call
      final response = await ApiService.get<CountingLandFormResponse>(
        endpoint: getPreviewData(int.parse(userId), formType),
        fromJson: (json) => CountingLandFormResponse.fromJson(json),
        includeToken: true,
      );

      developer.log('API Response received');

      // Validate response
      if (response.success && response.data != null) {
        final formsData = response.data!.data.forms;

        if (formsData.isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          change(formsData, status: RxStatus.success());
        }
      } else {
        throw Exception(response.errorMessage ?? 'Failed to load forms');
      }
    } catch (e, stackTrace) {
      developer.log('Error fetching forms: $e',
          error: e, stackTrace: stackTrace);
      change(null, status: RxStatus.error('Failed to fetch forms: ${e.toString()}'));
    }
  }

  Future<void> refreshForms() async {
    await fetchFormsByType();
  }

  // Helper method to get status icon
  IconData getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'verified':
        return Icons.check_circle;
      case 'pending':
        return Icons.pending;
      case 'rejected':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  // Helper method to filter forms by status
  List<CountingLandForm> getFormsByStatus(String status) {
    return state?.where((form) => form.status.toLowerCase() == status.toLowerCase()).toList() ?? [];
  }

  // Get count of forms by status
  int getCountByStatus(String status) {
    return getFormsByStatus(status).length;
  }
}