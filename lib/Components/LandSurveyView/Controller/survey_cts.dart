// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'main_controller.dart';
//
// class SurveyCTSController extends GetxController
//     with StepValidationMixin, StepDataMixin {
//   // Form Controllers
//   final surveyCtsNumber = TextEditingController();
//   final districtController = TextEditingController();
//   final talukaController = TextEditingController();
//   final villageController = TextEditingController();
//
//   // Dropdown Values (Department only)
//   final selectedDepartment = 'Land Records Department'.obs;
//
//   // Dropdown Options
//   final List<String> departmentOptions = ['Land Records Department'];
//
//   @override
//   void onClose() {
//     surveyCtsNumber.dispose();
//     districtController.dispose();
//     talukaController.dispose();
//     villageController.dispose();
//     super.onClose();
//   }
//
//   // Update method for department dropdown
//   void updateDepartment(String? value) {
//     if (value != null) {
//       selectedDepartment.value = value;
//     }
//   }
//
//   @override
//   bool validateCurrentSubStep(String field) {
//     switch (field) {
//       case 'survey_number':
//         return surveyCtsNumber.text.trim().isNotEmpty;
//       case 'department':
//         return selectedDepartment.value.isNotEmpty;
//       case 'district':
//         return districtController.text.trim().isNotEmpty;
//       case 'taluka':
//         return talukaController.text.trim().isNotEmpty;
//       case 'village':
//         return villageController.text.trim().isNotEmpty;
//
//       default:
//         return true;
//     }
//   }
//
//   @override
//   bool isStepCompleted(List<String> fields) {
//     for (String field in fields) {
//       if (!validateCurrentSubStep(field)) return false;
//     }
//     return true;
//   }
//
//   @override
//   String getFieldError(String field) {
//     switch (field) {
//       case 'survey_number':
//         return 'Survey number is required';
//       case 'department':
//         return 'Please select a department';
//       case 'district':
//         return 'Please enter a district';
//       case 'taluka':
//         return 'Please enter a taluka';
//       case 'village':
//         return 'Please enter a village';
//       default:
//         return 'This field is required';
//     }
//   }
//
//   @override
//   Map<String, dynamic> getStepData() {
//     return {
//       'survey_cts': {
//         'survey_number': surveyCtsNumber.text.trim(),
//         'department': selectedDepartment.value,
//         'district': districtController.text.trim(),
//         'taluka': talukaController.text.trim(),
//         'village': villageController.text.trim(),
//       }
//     };
//   }
//
//   // Method to clear all fields
//   void clearAllFields() {
//     surveyCtsNumber.clear();
//     selectedDepartment.value = 'Land Records Department';
//     districtController.clear();
//     talukaController.clear();
//     villageController.clear();
//   }
//
//   // Method to load data from saved state (useful for resuming forms)
//   void loadSavedData(Map<String, dynamic> savedData) {
//     if (savedData.containsKey('survey_cts')) {
//       final ctsData = savedData['survey_cts'];
//       surveyCtsNumber.text = ctsData['survey_number'] ?? '';
//       selectedDepartment.value =
//           ctsData['department'] ?? 'Land Records Department';
//       districtController.text = ctsData['district'] ?? '';
//       talukaController.text = ctsData['taluka'] ?? '';
//       villageController.text = ctsData['village'] ?? '';
//     }
//   }
// }


import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'main_controller.dart';

class SurveyCTSController extends GetxController
    with StepValidationMixin, StepDataMixin {


  // Form Controllers
  final surveyCtsNumber = TextEditingController();
  final districtController = TextEditingController();
  final divisionController = TextEditingController();
  final talukaController = TextEditingController();
  final villageController = TextEditingController();

  // Dropdown Values (Department only)
  final selectedDepartment = 'Land Records Department'.obs;

  // Dropdown Options
  final List<String> departmentOptions = ['Land Records Department'];

  @override
  void onClose() {
    surveyCtsNumber.dispose();
    districtController.dispose();
    divisionController.dispose();
    talukaController.dispose();
    villageController.dispose();
    super.onClose();
  }

  // Update method for department dropdown
  void updateDepartment(String? value) {
    if (value != null) {
      selectedDepartment.value = value;
    }
  }

  @override
  bool validateCurrentSubStep(String field) {
    switch (field) {
      case 'survey_number':
        return surveyCtsNumber.text.trim().isNotEmpty;
      case 'department':
        return selectedDepartment.value.isNotEmpty;
      case 'district':
        return districtController.text.trim().isNotEmpty;
      case 'division':
        return divisionController.text.trim().isNotEmpty;
      case 'taluka':
        return talukaController.text.trim().isNotEmpty;
      case 'village':
        return villageController.text.trim().isNotEmpty;

      default:
        return true;
    }
  }

  @override
  bool isStepCompleted(List<String> fields) {
    for (String field in fields) {
      if (!validateCurrentSubStep(field)) return false;
    }
    return true;
  }

  @override
  String getFieldError(String field) {
    switch (field) {
      case 'survey_number':
        return 'Survey number is required';
      case 'department':
        return 'Please select a department';
      case 'district':
        return 'Please enter a district';
      case 'division':
        return 'Please enter a division';
      case 'taluka':
        return 'Please enter a taluka';
      case 'village':
        return 'Please enter a village';
      default:
        return 'This field is required';
    }
  }

  @override
  Map<String, dynamic> getStepData() {
    return {
      'survey_cts': {
        'survey_number': surveyCtsNumber.text.trim(),
        'department': selectedDepartment.value,
        'district': districtController.text.trim(),
        'division': divisionController.text.trim(),
        'taluka': talukaController.text.trim(),
        'village': villageController.text.trim(),
      }
    };
  }

  // Method to clear all fields
  void clearAllFields() {
    surveyCtsNumber.clear();
    selectedDepartment.value = 'Land Records Department';
    districtController.clear();
    divisionController.clear();
    talukaController.clear();
    villageController.clear();
  }

  // Method to load data from saved state (useful for resuming forms)
  void loadSavedData(Map<String, dynamic> savedData) {
    if (savedData.containsKey('survey_cts')) {
      final ctsData = savedData['survey_cts'];
      surveyCtsNumber.text = ctsData['survey_number'] ?? '';
      selectedDepartment.value =
          ctsData['department'] ?? 'Land Records Department';
      districtController.text = ctsData['district'] ?? '';
      divisionController.text = ctsData['division'] ?? '';
      talukaController.text = ctsData['taluka'] ?? '';
      villageController.text = ctsData['village'] ?? '';
    }
  }
}