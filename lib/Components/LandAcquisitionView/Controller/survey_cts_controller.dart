// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'main_controller.dart';
//
// class LandSecondController extends GetxController with StepValidationMixin, StepDataMixin {
//   // Form Controllers
//   final surveyNumberController = TextEditingController();
//
//   // Dropdown Values
//   final selectedDepartment = 'Land Records Department'.obs;
//   final selectedDistrict = ''.obs;
//   final selectedTaluka = ''.obs;
//   final selectedVillage = ''.obs;
//   final selectedOffice = ''.obs;
//
//   final selectedSurveyNo = 'Survey No.'.obs;
//
//   final surveyCtsNumber = TextEditingController();
//
//
//
//   // Dropdown Options - You can make these dynamic by fetching from API
//   final List<String> departmentOptions = [
//     'Land Records Department'
//   ];
//
//   final List<String> noSelect = ['Survey No.', 'CTS No.'];
//
//
//
//
//   final List<String> districtOptions = [
//     'Pune',
//     'Mumbai',
//     'Nagpur',
//     'Thane'
//   ];
//
//   final List<String> talukaOptions = [
//     'Haveli',
//     'Mulshi',
//     'Pune City',
//     'Bhor'
//   ];
//
//   final List<String> villageOptions = [
//     'Khadakwasla',
//     'Sinhagad',
//     'Panshet',
//     'Lavasa'
//   ];
//
//   final List<String> officeOptions = [
//     'Tahsildar Office',
//     'Collector Office',
//     'Sub-Registrar Office'
//   ];
//
//   @override
//   void onClose() {
//     surveyNumberController.dispose();
//     surveyCtsNumber.dispose();
//     super.onClose();
//   }
//
//   // Update methods for dropdowns
//   void updateDepartment(String? value) {
//     if (value != null) {
//       selectedDepartment.value = value;
//       // Reset dependent dropdowns if needed
//       _resetDependentFields('department');
//     }
//   }
//
//   void updateDistrict(String? value) {
//     if (value != null) {
//       selectedDistrict.value = value;
//       // Reset dependent dropdowns if needed
//       _resetDependentFields('district');
//     }
//   }
//
//   void updateTaluka(String? value) {
//     if (value != null) {
//       selectedTaluka.value = value;
//       // Reset dependent dropdowns if needed
//       _resetDependentFields('taluka');
//     }
//   }
//
//   void updateVillage(String? value) {
//     if (value != null) {
//       selectedVillage.value = value;
//       _resetDependentFields('village');
//     }
//   }
//
//   void updateOffice(String? value) {
//     if (value != null) {
//       selectedOffice.value = value;
//     }
//   }
//
//   void _resetDependentFields(String changedField) {
//     switch (changedField) {
//       case 'department':
//       // Reset district and all subsequent fields
//         selectedDistrict.value = '';
//         selectedTaluka.value = '';
//         selectedVillage.value = '';
//         break;
//       case 'district':
//       // Reset taluka and subsequent fields
//         selectedTaluka.value = '';
//         selectedVillage.value = '';
//         break;
//       case 'taluka':
//       // Reset village
//         selectedVillage.value = '';
//         break;
//     }
//   }
//
//   // Get dynamic options based on previous selections
//   List<String> getTalukaOptions() {
//     // You can implement logic to filter talukas based on selected district
//     return talukaOptions;
//   }
//
//   List<String> getVillageOptions() {
//     // You can implement logic to filter villages based on selected taluka
//     return villageOptions;
//   }
//
//   @override
//   bool validateCurrentSubStep(String field) {
//     switch (field) {
//       case 'government_survey':
//         return true; // Temporarily return true to bypass validation
//       default:
//         return true;
//     }
//   }
//   // bool validateCurrentSubStep(String field) {
//   //   switch (field) {
//   //     case 'survey_number':
//   //       return surveyNumberController.text.trim().isNotEmpty;
//   //     case 'department':
//   //       return selectedDepartment.value.isNotEmpty;
//   //     case 'district':
//   //       return selectedDistrict.value.isNotEmpty;
//   //     case 'taluka':
//   //       return selectedTaluka.value.isNotEmpty;
//   //     case 'village':
//   //       return selectedVillage.value.isNotEmpty;
//   //     case 'office':
//   //       return selectedOffice.value.isNotEmpty;
//   //     default:
//   //       return true;
//   //   }
//   // }
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
//         return 'Please select a district';
//       case 'taluka':
//         return 'Please select a taluka';
//       case 'village':
//         return 'Please select a village';
//       case 'office':
//         return 'Please select an office';
//       default:
//         return 'This field is required';
//     }
//   }
//
//   @override
//   Map<String, dynamic> getStepData() {
//     return {
//       'survey_cts': {
//         'survey_number': surveyNumberController.text.trim(),
//         'department': selectedDepartment.value,
//         'district': selectedDistrict.value,
//         'taluka': selectedTaluka.value,
//         'village': selectedVillage.value,
//         'office': selectedOffice.value,
//         'Number': selectedSurveyNo.value,
//       }
//     };
//   }
//
//   // Utility methods
//   bool get isSurveyNumberValid => surveyNumberController.text.trim().isNotEmpty;
//   bool get isDepartmentSelected => selectedDepartment.value.isNotEmpty;
//   bool get isDistrictSelected => selectedDistrict.value.isNotEmpty;
//   bool get isTalukaSelected => selectedTaluka.value.isNotEmpty;
//   bool get isVillageSelected => selectedVillage.value.isNotEmpty;
//   bool get isOfficeSelected => selectedOffice.value.isNotEmpty;
//
//   // Method to clear all fields
//   void clearAllFields() {
//     surveyNumberController.clear();
//     selectedDepartment.value = '';
//     selectedDistrict.value = '';
//     selectedTaluka.value = '';
//     selectedVillage.value = '';
//     selectedOffice.value = '';
//   }
//
//   // Method to load data from saved state (useful for resuming forms)
//   void loadSavedData(Map<String, dynamic> savedData) {
//     if (savedData.containsKey('survey_cts')) {
//       final ctsData = savedData['survey_cts'];
//       surveyNumberController.text = ctsData['survey_number'] ?? '';
//       selectedDepartment.value = ctsData['department'] ?? '';
//       selectedDistrict.value = ctsData['district'] ?? '';
//       selectedTaluka.value = ctsData['taluka'] ?? '';
//       selectedVillage.value = ctsData['village'] ?? '';
//       selectedOffice.value = ctsData['office'] ?? '';
//     }
//   }
//
//
// }
//
//
//
//
//
//
//


import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'main_controller.dart';

class LandSecondController extends GetxController with StepValidationMixin, StepDataMixin {
  final surveyCtsNumber = TextEditingController();
  final districtController = TextEditingController();
  final talukaController = TextEditingController();
  final villageController = TextEditingController();

  // Dropdown Values (Department only)
  final selectedDepartment = 'Land Records Department'.obs;

  // Dropdown Options
  final List<String> departmentOptions = [
    'Land Records Department'
  ];

  @override
  void onClose() {
    surveyCtsNumber.dispose();
    districtController.dispose();
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
    talukaController.clear();
    villageController.clear();
  }

  // Method to load data from saved state (useful for resuming forms)
  void loadSavedData(Map<String, dynamic> savedData) {
    if (savedData.containsKey('survey_cts')) {
      final ctsData = savedData['survey_cts'];
      surveyCtsNumber.text = ctsData['survey_number'] ?? '';
      selectedDepartment.value = ctsData['department'] ?? 'Land Records Department';
      districtController.text = ctsData['district'] ?? '';
      talukaController.text = ctsData['taluka'] ?? '';
      villageController.text = ctsData['village'] ?? '';
    }
  }
}







