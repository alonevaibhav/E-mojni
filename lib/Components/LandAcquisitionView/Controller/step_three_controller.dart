// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import '../../LandAcquisitionView/Controller/main_controller.dart';
//
// class CalculationController extends GetxController
//     with StepValidationMixin, StepDataMixin {
//   // Village Selection
//   final selectedVillage = ''.obs;
//
//
//   // Survey Entries List
//   final surveyEntries = <Map<String, dynamic>>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     addSurveyEntry(); // Add initial entry
//   }
//
//   // Village Methods
//   void updateSelectedVillage(String village) {
//     selectedVillage.value = village;
//   }
//
//   // Survey Entry Methods
//   void addSurveyEntry() {
//     surveyEntries.add({
//       'villageController': TextEditingController(), // Add thisc
//       'surveyNoController': TextEditingController(),
//       'shareController': TextEditingController(),
//       'areaController': TextEditingController(),
//       'landAcquisitionAreaController': TextEditingController(),
//       'abdominalSectionController': TextEditingController(),
//       'surveyNo': '',
//       'share': '',
//       'area': '',
//       'landAcquisitionArea': '',
//       'abdominalSection': '',
//     });
//   }
//
//   void removeSurveyEntry(int index) {
//     if (surveyEntries.length > 1 && index < surveyEntries.length) {
//       // Dispose controllers to prevent memory leaks
//       final entry = surveyEntries[index];
//       entry['villageController']?.dispose(); // Add this
//       entry['surveyNoController']?.dispose();
//       entry['shareController']?.dispose();
//       entry['areaController']?.dispose();
//       entry['landAcquisitionAreaController']?.dispose();
//       entry['abdominalSectionController']?.dispose();
//
//       surveyEntries.removeAt(index);
//     }
//   }
//
//   void updateSurveyEntry(int index, String field, String value) {
//     if (index < surveyEntries.length) {
//       surveyEntries[index][field] = value;
//       surveyEntries.refresh();
//     }
//   }
//
//   // Clear all entries
//   void clearAllEntries() {
//     // Dispose all controllers
//     for (var entry in surveyEntries) {
//       entry['surveyNoController']?.dispose();
//       entry['shareController']?.dispose();
//       entry['areaController']?.dispose();
//       entry['landAcquisitionAreaController']?.dispose();
//       entry['abdominalSectionController']?.dispose();
//     }
//     surveyEntries.clear();
//     addSurveyEntry(); // Add back initial entry
//   }
//
//   // Get entry summary
//   String getEntrySummary(int index) {
//     if (index < surveyEntries.length) {
//       final entry = surveyEntries[index];
//       final surveyNo = entry['surveyNo'] ?? '';
//       final area = entry['area'] ?? '';
//       final landAcqArea = entry['landAcquisitionArea'] ?? '';
//
//       if (surveyNo.isNotEmpty && area.isNotEmpty && landAcqArea.isNotEmpty) {
//         return 'Survey: $surveyNo, Area: $area, Land Acq: $landAcqArea';
//       }
//     }
//     return 'Entry ${index + 1} - Incomplete';
//   }
//
//   // Calculate total area
//   double get totalArea {
//     double total = 0.0;
//     for (var entry in surveyEntries) {
//       final areaStr = entry['area'] ?? '';
//       if (areaStr.isNotEmpty) {
//         total += double.tryParse(areaStr) ?? 0.0;
//       }
//     }
//     return total;
//   }
//
//   // Calculate total land acquisition area
//   double get totalLandAcquisitionArea {
//     double total = 0.0;
//     for (var entry in surveyEntries) {
//       final areaStr = entry['landAcquisitionArea'] ?? '';
//       if (areaStr.isNotEmpty) {
//         total += double.tryParse(areaStr) ?? 0.0;
//       }
//     }
//     return total;
//   }
//
//   // Get completed entries count
//   int get completedEntriesCount {
//     int count = 0;
//     for (var entry in surveyEntries) {
//       if (isEntryComplete(entry)) {
//         count++;
//       }
//     }
//     return count;
//   }
//
//   // Check if entry is complete
//   bool isEntryComplete(Map<String, dynamic> entry) {
//     final requiredFields = [
//       'village', // Add this
//       'surveyNo',
//       'share',
//       'area',
//       'landAcquisitionArea',
//       'abdominalSection'
//     ];
//     for (String field in requiredFields) {
//       final value = entry[field] ?? '';
//       if (value.isEmpty) {
//         return false;
//       }
//     }
//     return true;
//   }
//
//   @override
//   void onClose() {
//     // Dispose all controllers
//     for (var entry in surveyEntries) {
//       entry['surveyNoController']?.dispose();
//       entry['shareController']?.dispose();
//       entry['areaController']?.dispose();
//       entry['landAcquisitionAreaController']?.dispose();
//       entry['abdominalSectionController']?.dispose();
//     }
//     super.onClose();
//   }
//
//   // StepValidationMixin Implementation
//   @override
//   // bool validateCurrentSubStep(String field) {
//   //   switch (field) {
//   //     case 'government_survey':
//   //       return true; // Temporarily return true to bypass validation
//   //     default:
//   //       return true;
//   //   }
//   // }
//   bool validateCurrentSubStep(String field) {
//     switch (field) {
//       case 'calculation':
//         return validateCalculationStep();
//       default:
//         return true;
//     }
//   }
//
//   @override
//   bool isStepCompleted(List<String> fields) {
//     for (String field in fields) {
//       if (!validateCurrentSubStep(field)) {
//         return false;
//       }
//     }
//     return true;
//   }
//
//   @override
//   String getFieldError(String field) {
//     switch (field) {
//       case 'calculation':
//         return getCalculationError();
//       default:
//         return 'This field is required';
//     }
//   }
//
//   // Private validation methods
//   bool validateCalculationStep() {
//     // Check if village is selected
//     if (selectedVillage.value.isEmpty) {
//       return false;
//     }
//
//     // Check if at least one entry exists and is complete
//     if (surveyEntries.isEmpty) {
//       return false;
//     }
//
//     // Check if at least one entry is complete
//     bool hasCompleteEntry = false;
//     for (var entry in surveyEntries) {
//       if (isEntryComplete(entry)) {
//         hasCompleteEntry = true;
//         break;
//       }
//     }
//
//     return hasCompleteEntry;
//   }
//
//   String getCalculationError() {
//     if (selectedVillage.value.isEmpty) {
//       return 'Please select a village';
//     }
//
//     if (surveyEntries.isEmpty) {
//       return 'Please add at least one survey entry';
//     }
//
//     bool hasCompleteEntry = false;
//     for (var entry in surveyEntries) {
//       if (isEntryComplete(entry)) {
//         hasCompleteEntry = true;
//         break;
//       }
//     }
//
//     if (!hasCompleteEntry) {
//       return 'Please complete at least one survey entry with all required fields';
//     }
//
//     return 'Validation passed';
//   }
//
//   // StepDataMixin Implementation
//   @override
//   Map<String, dynamic> getStepData() {
//     List<Map<String, dynamic>> entriesData = [];
//
//     for (int i = 0; i < surveyEntries.length; i++) {
//       final entry = surveyEntries[i];
//       entriesData.add({
//         'index': i,
//         'surveyNo': entry['surveyNo'] ?? '',
//         'share': entry['share'] ?? '',
//         'area': entry['area'] ?? '',
//         'landAcquisitionArea': entry['landAcquisitionArea'] ?? '',
//         'abdominalSection': entry['abdominalSection'] ?? '',
//         'isComplete': isEntryComplete(entry),
//       });
//     }
//
//     return {
//       'step': 'calculation',
//       'selectedVillage': selectedVillage.value,
//       'surveyEntries': entriesData,
//       'totalArea': totalArea,
//       'totalLandAcquisitionArea': totalLandAcquisitionArea,
//       'completedEntriesCount': completedEntriesCount,
//       'totalEntriesCount': surveyEntries.length,
//       'isStepCompleted': validateCalculationStep(),
//       'timestamp': DateTime.now().toIso8601String(),
//     };
//   }
//
//   // Reset form
//   void resetForm() {
//     selectedVillage.value = '';
//     clearAllEntries();
//   }
//
//   // Load data from saved state
//   void loadData(Map<String, dynamic> data) {
//     if (data.containsKey('selectedVillage')) {
//       selectedVillage.value = data['selectedVillage'] ?? '';
//     }
//
//     if (data.containsKey('surveyEntries')) {
//       final savedEntries = data['surveyEntries'] as List<dynamic>? ?? [];
//       clearAllEntries();
//
//       for (var savedEntry in savedEntries) {
//         if (savedEntry is Map<String, dynamic>) {
//           addSurveyEntry();
//           final index = surveyEntries.length - 1;
//
//           // Load saved values
//           final surveyNo = savedEntry['surveyNo'] ?? '';
//           final share = savedEntry['share'] ?? '';
//           final area = savedEntry['area'] ?? '';
//           final landAcqArea = savedEntry['landAcquisitionArea'] ?? '';
//           final abdominalSection = savedEntry['abdominalSection'] ?? '';
//
//           // Update controllers and values
//           surveyEntries[index]['surveyNoController'].text = surveyNo;
//           surveyEntries[index]['shareController'].text = share;
//           surveyEntries[index]['areaController'].text = area;
//           surveyEntries[index]['landAcquisitionAreaController'].text =
//               landAcqArea;
//           surveyEntries[index]['abdominalSectionController'].text =
//               abdominalSection;
//
//           updateSurveyEntry(index, 'surveyNo', surveyNo);
//           updateSurveyEntry(index, 'share', share);
//           updateSurveyEntry(index, 'area', area);
//           updateSurveyEntry(index, 'landAcquisitionArea', landAcqArea);
//           updateSurveyEntry(index, 'abdominalSection', abdominalSection);
//         }
//       }
//     }
//   }
// }

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../LandAcquisitionView/Controller/main_controller.dart';

class CalculationController extends GetxController
    with StepValidationMixin, StepDataMixin {
  // Village Selection
  final selectedVillage = ''.obs;

  // Survey Entries List
  final surveyEntries = <Map<String, dynamic>>[].obs;

  // Validation errors
  final validationErrors = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    addSurveyEntry(); // Add initial entry
  }

  // Village Methods
  void updateSelectedVillage(String village) {
    selectedVillage.value = village;
    // Clear village validation error when updated
    validationErrors.remove('selectedVillage');
  }

  // Survey Entry Methods
  void addSurveyEntry() {
    surveyEntries.add({
      'villageController': TextEditingController(),
      'surveyNoController': TextEditingController(),
      'shareController': TextEditingController(),
      'areaController': TextEditingController(),
      'landAcquisitionAreaController': TextEditingController(),
      'abdominalSectionController': TextEditingController(),
      'village': '',
      'surveyNo': '',
      'share': '',
      'area': '',
      'landAcquisitionArea': '',
      'abdominalSection': '',
    });
  }

  void removeSurveyEntry(int index) {
    if (surveyEntries.length > 1 && index < surveyEntries.length) {
      // Dispose controllers to prevent memory leaks
      final entry = surveyEntries[index];
      entry['villageController']?.dispose();
      entry['surveyNoController']?.dispose();
      entry['shareController']?.dispose();
      entry['areaController']?.dispose();
      entry['landAcquisitionAreaController']?.dispose();
      entry['abdominalSectionController']?.dispose();

      surveyEntries.removeAt(index);

      // Clear validation errors for this entry
      _clearEntryValidationErrors(index);
    }
  }

  void updateSurveyEntry(int index, String field, String value) {
    if (index < surveyEntries.length) {
      surveyEntries[index][field] = value;

      // Clear validation error for this specific field
      validationErrors.remove('${index}_$field');

      surveyEntries.refresh();
    }
  }

  // Clear validation errors for a specific entry
  void _clearEntryValidationErrors(int index) {
    final keysToRemove = validationErrors.keys.where((key) => key.startsWith('${index}_')).toList();
    for (String key in keysToRemove) {
      validationErrors.remove(key);
    }
  }

  // Clear all entries
  void clearAllEntries() {
    // Dispose all controllers
    for (var entry in surveyEntries) {
      entry['villageController']?.dispose();
      entry['surveyNoController']?.dispose();
      entry['shareController']?.dispose();
      entry['areaController']?.dispose();
      entry['landAcquisitionAreaController']?.dispose();
      entry['abdominalSectionController']?.dispose();
    }
    surveyEntries.clear();
    validationErrors.clear();
    addSurveyEntry(); // Add back initial entry
  }

  // Get entry summary
  String getEntrySummary(int index) {
    if (index < surveyEntries.length) {
      final entry = surveyEntries[index];
      final surveyNo = entry['surveyNo'] ?? '';
      final area = entry['area'] ?? '';
      final landAcqArea = entry['landAcquisitionArea'] ?? '';

      if (surveyNo.isNotEmpty && area.isNotEmpty && landAcqArea.isNotEmpty) {
        return 'Survey: $surveyNo, Area: $area, Land Acq: $landAcqArea';
      }
    }
    return 'Entry ${index + 1} - Incomplete';
  }

  // Calculate total area
  double get totalArea {
    double total = 0.0;
    for (var entry in surveyEntries) {
      final areaStr = entry['area'] ?? '';
      if (areaStr.isNotEmpty) {
        total += double.tryParse(areaStr) ?? 0.0;
      }
    }
    return total;
  }

  // Calculate total land acquisition area
  double get totalLandAcquisitionArea {
    double total = 0.0;
    for (var entry in surveyEntries) {
      final areaStr = entry['landAcquisitionArea'] ?? '';
      if (areaStr.isNotEmpty) {
        total += double.tryParse(areaStr) ?? 0.0;
      }
    }
    return total;
  }

  // Get completed entries count
  int get completedEntriesCount {
    int count = 0;
    for (var entry in surveyEntries) {
      if (isEntryComplete(entry)) {
        count++;
      }
    }
    return count;
  }

  // Check if entry is complete with isEmpty validation
  bool isEntryComplete(Map<String, dynamic> entry) {
    final requiredFields = [
      'village',
      'surveyNo',
      'share',
      'area',
      'landAcquisitionArea',
      'abdominalSection'
    ];
    for (String field in requiredFields) {
      final value = (entry[field] ?? '').toString().trim();
      if (value.isEmpty) {
        return false;
      }
    }
    return true;
  }

  @override
  void onClose() {
    // Dispose all controllers
    for (var entry in surveyEntries) {
      entry['villageController']?.dispose();
      entry['surveyNoController']?.dispose();
      entry['shareController']?.dispose();
      entry['areaController']?.dispose();
      entry['landAcquisitionAreaController']?.dispose();
      entry['abdominalSectionController']?.dispose();
    }
    super.onClose();
  }

  //------------------------Validation------------------------//
  @override
  bool validateCurrentSubStep(String field) {
    switch (field) {
      case 'calculation':
        return _validateCalculationStep();
      default:
        return true;
    }
  }



  // Enhanced validation with isEmpty checks
  bool _validateCalculationStep() {
    validationErrors.clear();
    bool isValid = true;

    // Village selection validation with isEmpty check
    // if (selectedVillage.value.trim().isEmpty) {
    //   validationErrors['selectedVillage'] = 'Please select a village';
    //   isValid = false;
    // }

    // Survey entries validation
    if (surveyEntries.isEmpty) {
      validationErrors['surveyEntries'] = 'Please add at least one survey entry';
      isValid = false;
    } else {
      // Validate each survey entry with isEmpty checks
      for (int i = 0; i < surveyEntries.length; i++) {
        final entry = surveyEntries[i];

        // Village field validation with isEmpty check
        final village = (entry['village'] ?? '').toString().trim();
        if (village.isEmpty) {
          validationErrors['${i}_village'] = 'Village is required for entry ${i + 1}';
          isValid = false;
        }

        // Survey Number validation with isEmpty check
        final surveyNo = (entry['surveyNo'] ?? '').toString().trim();
        if (surveyNo.isEmpty) {
          validationErrors['${i}_surveyNo'] = 'Survey number is required for entry ${i + 1}';
          isValid = false;
        }

        // Share validation with isEmpty check
        // final share = (entry['share'] ?? '').toString().trim();
        // if (share.isEmpty) {
        //   validationErrors['${i}_share'] = 'Share is required for entry ${i + 1}';
        //   isValid = false;
        // }

        // Area validation with isEmpty check
        final area = (entry['area'] ?? '').toString().trim();
        if (area.isEmpty) {
          validationErrors['${i}_area'] = '7/12 Area is required for entry ${i + 1}';
          isValid = false;
        } else {
          // Additional numeric validation for area
          final parsedArea = double.tryParse(area);
          if (parsedArea == null) {
            validationErrors['${i}_area'] = 'Please enter a valid number for area in entry ${i + 1}';
            isValid = false;
          }
        }

        // Land Acquisition Area validation with isEmpty check
        // final landAcqArea = (entry['landAcquisitionArea'] ?? '').toString().trim();
        // if (landAcqArea.isEmpty) {
        //   validationErrors['${i}_landAcquisitionArea'] = 'Land acquisition area is required for entry ${i + 1}';
        //   isValid = false;
        // } else {
        //   // Additional numeric validation for land acquisition area
        //   final parsedLandAcqArea = double.tryParse(landAcqArea);
        //   if (parsedLandAcqArea == null) {
        //     validationErrors['${i}_landAcquisitionArea'] = 'Please enter a valid number for land acquisition area in entry ${i + 1}';
        //     isValid = false;
        //   }
        // }
        //
        // // Abdominal Section validation with isEmpty check
        // final abdominalSection = (entry['abdominalSection'] ?? '').toString().trim();
        // if (abdominalSection.isEmpty) {
        //   validationErrors['${i}_abdominalSection'] = 'Abdominal section is required for entry ${i + 1}';
        //   isValid = false;
        // }
      }
    }

    return isValid;
  }

  @override
  bool isStepCompleted(List<String> fields) {
    for (String field in fields) {
      if (!validateCurrentSubStep(field)) {
        return false;
      }
    }
    return true;
  }

  @override
  String getFieldError(String field) {
    switch (field) {
      case 'calculation':
        return _getCalculationError();
      case 'government_survey':
        return _getGovernmentSurveyError();
      default:
        return validationErrors[field] ?? 'This field is required';
    }
  }

  // NEW: Government survey validation errors
  String _getGovernmentSurveyError() {
    if (selectedVillage.value.trim().isEmpty) {
      return 'Please select a village';
    }

    return 'Please complete government survey information';
  }

  // Enhanced error messages with isEmpty validation
  String _getCalculationError() {
    // Return first validation error found with specific message
    if (validationErrors.isNotEmpty) {
      return validationErrors.values.first;
    }

    // Fallback error messages with isEmpty checks
    if (selectedVillage.value.trim().isEmpty) {
      return 'Please select a village';
    }

    if (surveyEntries.isEmpty) {
      return 'Please add at least one survey entry';
    }

    // Check if any entry is incomplete
    for (int i = 0; i < surveyEntries.length; i++) {
      if (!isEntryComplete(surveyEntries[i])) {
        return 'Please complete all required fields for entry ${i + 1}';
      }
    }

    return 'Please complete all calculation fields';
  }

  // Legacy methods (kept for backward compatibility)
  bool validateCalculationStep() {
    return _validateCalculationStep();
  }

  String getCalculationError() {
    return _getCalculationError();
  }

  // NEW: Get specific field error for an entry
  String getEntryFieldError(int entryIndex, String fieldName) {
    final errorKey = '${entryIndex}_$fieldName';
    return validationErrors[errorKey] ?? '';
  }

  // NEW: Check if entry field has validation error
  bool hasEntryFieldError(int entryIndex, String fieldName) {
    final errorKey = '${entryIndex}_$fieldName';
    return validationErrors.containsKey(errorKey);
  }

  // NEW: Get village validation error
  String getVillageError() {
    return validationErrors['selectedVillage'] ?? '';
  }

  // NEW: Check if village has validation error
  bool hasVillageError() {
    return validationErrors.containsKey('selectedVillage');
  }

  // StepDataMixin Implementation
  @override
  Map<String, dynamic> getStepData() {
    List<Map<String, dynamic>> entriesData = [];

    for (int i = 0; i < surveyEntries.length; i++) {
      final entry = surveyEntries[i];
      entriesData.add({
        'index': i,
        'village': (entry['village'] ?? '').toString().trim(),
        'surveyNo': (entry['surveyNo'] ?? '').toString().trim(),
        'share': (entry['share'] ?? '').toString().trim(),
        'area': (entry['area'] ?? '').toString().trim(),
        'landAcquisitionArea': (entry['landAcquisitionArea'] ?? '').toString().trim(),
        'abdominalSection': (entry['abdominalSection'] ?? '').toString().trim(),
        'isComplete': isEntryComplete(entry),
      });
    }

    return {
      'step': 'calculation',
      'selectedVillage': selectedVillage.value.trim(),
      'surveyEntries': entriesData,
      'totalArea': totalArea,
      'totalLandAcquisitionArea': totalLandAcquisitionArea,
      'completedEntriesCount': completedEntriesCount,
      'totalEntriesCount': surveyEntries.length,
      'isStepCompleted': _validateCalculationStep(),
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  // Reset form
  void resetForm() {
    selectedVillage.value = '';
    validationErrors.clear();
    clearAllEntries();
  }

  // Load data from saved state
  void loadData(Map<String, dynamic> data) {
    if (data.containsKey('selectedVillage')) {
      selectedVillage.value = data['selectedVillage'] ?? '';
    }

    if (data.containsKey('surveyEntries')) {
      final savedEntries = data['surveyEntries'] as List<dynamic>? ?? [];
      clearAllEntries();

      for (var savedEntry in savedEntries) {
        if (savedEntry is Map<String, dynamic>) {
          addSurveyEntry();
          final index = surveyEntries.length - 1;

          // Load saved values with trim
          final village = (savedEntry['village'] ?? '').toString().trim();
          final surveyNo = (savedEntry['surveyNo'] ?? '').toString().trim();
          final share = (savedEntry['share'] ?? '').toString().trim();
          final area = (savedEntry['area'] ?? '').toString().trim();
          final landAcqArea = (savedEntry['landAcquisitionArea'] ?? '').toString().trim();
          final abdominalSection = (savedEntry['abdominalSection'] ?? '').toString().trim();

          // Update controllers and values
          surveyEntries[index]['villageController'].text = village;
          surveyEntries[index]['surveyNoController'].text = surveyNo;
          surveyEntries[index]['shareController'].text = share;
          surveyEntries[index]['areaController'].text = area;
          surveyEntries[index]['landAcquisitionAreaController'].text = landAcqArea;
          surveyEntries[index]['abdominalSectionController'].text = abdominalSection;

          updateSurveyEntry(index, 'village', village);
          updateSurveyEntry(index, 'surveyNo', surveyNo);
          updateSurveyEntry(index, 'share', share);
          updateSurveyEntry(index, 'area', area);
          updateSurveyEntry(index, 'landAcquisitionArea', landAcqArea);
          updateSurveyEntry(index, 'abdominalSection', abdominalSection);
        }
      }
    }
  }
}
