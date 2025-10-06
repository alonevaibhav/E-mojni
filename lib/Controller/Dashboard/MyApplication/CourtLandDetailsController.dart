import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../API Service/api_service.dart';
import '../../../Constants/api_constant.dart';
import '../../../Models/court_land_model.dart';

class CourtLandDetailsController extends GetxController with StateMixin<List<CourtLandDetailsForm>> {
  late String formType;
  late String formName;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;

    if (args != null) {
      formType = args['formType'] ?? 'court_land_details';
      formName = args['formName'] ?? 'Court Land Details';

      developer.log('Arguments received: formType=$formType, formName=$formName');
    } else {
      formType = 'court_land_details';
      formName = 'Court Land Details';
    }

    fetchFormsByType();
  }

  Future<void> fetchFormsByType() async {
    try {
      change(null, status: RxStatus.loading());

      String userId = (await ApiService.getUid()) ?? "0";

      final response = await ApiService.get<CourtLandDetailsFormResponse>(
        endpoint: getPreviewData(int.parse(userId), formType),
        fromJson: (json) => CourtLandDetailsFormResponse.fromJson(json),
        includeToken: true,
      );

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
      developer.log('Error fetching forms: $e', error: e, stackTrace: stackTrace);
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
      case 'approved':
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
  List<CourtLandDetailsForm> getFormsByStatus(String status) {
    return state?.where((form) => form.status.toLowerCase() == status.toLowerCase()).toList() ?? [];
  }

  // Get count of forms by status
  int getCountByStatus(String status) {
    return getFormsByStatus(status).length;
  }

  // Get fee confirmed forms
  List<CourtLandDetailsForm> getFeeConfirmedForms() {
    return state?.where((form) => form.isFeeConfirmed).toList() ?? [];
  }

  int getFeeConfirmedCount() {
    return getFeeConfirmedForms().length;
  }

  // ============ File Helper Methods ============

  /// Get file name from path
  String getFileName(String path) {
    return path.split('/').last;
  }

  /// Check if file is an image
  bool isImageFile(String fileName) {
    final extension = fileName.toLowerCase().split('.').last;
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(extension);
  }

  /// Check if file is a PDF
  bool isPdfFile(String fileName) {
    return fileName.toLowerCase().endsWith('.pdf');
  }

  /// Check if file is a Word document
  bool isWordFile(String fileName) {
    final extension = fileName.toLowerCase().split('.').last;
    return ['doc', 'docx'].contains(extension);
  }

  /// Get file type icon color
  Color getFileIconColor(String fileName) {
    if (isImageFile(fileName)) {
      return Colors.blue;
    } else if (isPdfFile(fileName)) {
      return Colors.red;
    } else if (isWordFile(fileName)) {
      return Colors.blue.shade800;
    } else {
      return Colors.grey;
    }
  }

  /// Get file type icon
  IconData getFileIcon(String fileName) {
    if (isImageFile(fileName)) {
      return Icons.image;
    } else if (isPdfFile(fileName)) {
      return Icons.picture_as_pdf;
    } else if (isWordFile(fileName)) {
      return Icons.description;
    } else {
      return Icons.insert_drive_file;
    }
  }
}
