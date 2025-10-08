import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../Controller/main_controller.dart';

class CalculationController extends GetxController with StepValidationMixin, StepDataMixin {
  // Observable variables
  final surveyEntries = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;

  // Validation errors
  final validationErrors = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  void _initializeData() {
    // Initialize with one default survey entry
    addSurveyEntry();
  }

  @override
  void onClose() {
    // Dispose all text controllers
    for (var entry in surveyEntries) {
      entry['villageController']?.dispose();
      entry['surveyNoController']?.dispose();
      entry['areaController']?.dispose();
    }
    super.onClose();
  }

  // Add new survey entry
  void addSurveyEntry() {
    final newEntry = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'villageController': TextEditingController(),
      'surveyNoController': TextEditingController(),
      'areaController': TextEditingController(),
      'village': '',
      'surveyNo': '',
      'area': '',
    };
    surveyEntries.add(newEntry);
  }

  // Remove survey entry
  void removeSurveyEntry(int index) {
    if (surveyEntries.length > 1 && index >= 0 && index < surveyEntries.length) {
      // Dispose controllers before removing
      final entry = surveyEntries[index];
      entry['villageController']?.dispose();
      entry['surveyNoController']?.dispose();
      entry['areaController']?.dispose();

      surveyEntries.removeAt(index);

      // Clear validation errors for this entry
      _clearEntryValidationErrors(index);
    }
  }

  // Update survey entry data
  void updateSurveyEntry(int index, String field, String value) {
    if (index >= 0 && index < surveyEntries.length) {
      surveyEntries[index][field] = value;

      // Clear validation error for this specific field
      validationErrors.remove('${index}_$field');

      surveyEntries.refresh(); // Trigger UI update
    }
  }

  // Clear validation errors for a specific entry
  void _clearEntryValidationErrors(int index) {
    final keysToRemove = validationErrors.keys.where((key) => key.startsWith('${index}_')).toList();
    for (String key in keysToRemove) {
      validationErrors.remove(key);
    }
  }

  // Calculate total area from all entries
  double get totalArea {
    double total = 0.0;
    for (var entry in surveyEntries) {
      final areaStr = entry['area']?.toString() ?? '';
      final area = double.tryParse(areaStr) ?? 0.0;
      total += area;
    }
    return total;
  }

  // Get survey entry summary
  String getSurveyEntrySummary(int index) {
    if (index >= 0 && index < surveyEntries.length) {
      final entry = surveyEntries[index];
      final surveyNo = entry['surveyNo']?.toString() ?? 'Not entered';
      final area = entry['area']?.toString() ?? '0';
      final village = entry['village']?.toString() ?? 'Not entered';
      return 'Village: $village, Survey: $surveyNo, Area: $area';
    }
    return 'Invalid entry';
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

    // Check if at least one survey entry exists
    if (surveyEntries.isEmpty) {
      validationErrors['surveyEntries'] = 'Please add at least one survey entry';
      return false;
    }

    // Validate each survey entry with isEmpty checks
    for (int i = 0; i < surveyEntries.length; i++) {
      final entry = surveyEntries[i];

      // Village validation with isEmpty check
      final village = (entry['village']?.toString() ?? '').trim();
      if (village.isEmpty) {
        validationErrors['${i}_village'] = 'Village is required for entry ${i + 1}';
        isValid = false;
      }

      // Survey number validation with isEmpty check
      final surveyNo = (entry['surveyNo']?.toString() ?? '').trim();
      if (surveyNo.isEmpty) {
        validationErrors['${i}_surveyNo'] = 'Survey number is required for entry ${i + 1}';
        isValid = false;
      }

      // Area validation with isEmpty check
      final areaStr = (entry['area']?.toString() ?? '').trim();
      if (areaStr.isEmpty) {
        validationErrors['${i}_area'] = 'Area is required for entry ${i + 1}';
        isValid = false;
      } else {
        // Additional numeric validation for area
        final area = double.tryParse(areaStr);
        if (area == null) {
          validationErrors['${i}_area'] = 'Please enter a valid number for area in entry ${i + 1}';
          isValid = false;
        } else if (area <= 0) {
          validationErrors['${i}_area'] = 'Area must be greater than 0 for entry ${i + 1}';
          isValid = false;
        }
      }
    }

    return isValid;
  }

  // Enhanced validation for single entry
  bool _validateSurveyEntry(Map<String, dynamic> entry) {
    // Check village with isEmpty
    final village = (entry['village']?.toString() ?? '').trim();
    if (village.isEmpty) {
      return false;
    }

    // Check survey number with isEmpty
    final surveyNo = (entry['surveyNo']?.toString() ?? '').trim();
    if (surveyNo.isEmpty) {
      return false;
    }

    // Check area with isEmpty
    final areaStr = (entry['area']?.toString() ?? '').trim();
    if (areaStr.isEmpty) {
      return false;
    }

    final area = double.tryParse(areaStr);
    if (area == null || area <= 0) {
      return false;
    }

    return true;
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
    if (surveyEntries.isEmpty) {
      return 'Please add at least one survey entry';
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
    if (surveyEntries.isEmpty) {
      return 'Please add at least one survey entry';
    }

    // Check individual entries
    for (int i = 0; i < surveyEntries.length; i++) {
      final entry = surveyEntries[i];
      final entryError = _getSurveyEntryError(entry, i);
      if (entryError.isNotEmpty) {
        return entryError;
      }
    }

    return 'Please fill all required fields';
  }

  String _getSurveyEntryError(Map<String, dynamic> entry, int index) {
    final entryNumber = index + 1;

    // Check village with isEmpty
    final village = (entry['village']?.toString() ?? '').trim();
    if (village.isEmpty) {
      return 'Village is required for entry $entryNumber';
    }

    // Check survey number with isEmpty
    final surveyNo = (entry['surveyNo']?.toString() ?? '').trim();
    if (surveyNo.isEmpty) {
      return 'Survey number is required for entry $entryNumber';
    }

    // Check area with isEmpty
    final areaStr = (entry['area']?.toString() ?? '').trim();
    if (areaStr.isEmpty) {
      return 'Area is required for entry $entryNumber';
    }

    final area = double.tryParse(areaStr);
    if (area == null) {
      return 'Please enter a valid number for area in entry $entryNumber';
    } else if (area <= 0) {
      return 'Area must be greater than 0 for entry $entryNumber';
    }

    return '';
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

  // Data Methods (StepDataMixin)
  @override
  Map<String, dynamic> getStepData() {
    return {
      'calculation': {
        'surveyEntries': surveyEntries.map((entry) => {
          'id': entry['id'],
          'village': (entry['village']?.toString() ?? '').trim(),
          'surveyNo': (entry['surveyNo']?.toString() ?? '').trim(),
          'area': (entry['area']?.toString() ?? '').trim(),
        }).toList(),
        'totalArea': totalArea,
        'isStepCompleted': _validateCalculationStep(),
        'timestamp': DateTime.now().toIso8601String(),
      }
    };
  }

  // Load data from saved state (if needed)
  void loadStepData(Map<String, dynamic> data) {
    final calculationData = data['calculation'] as Map<String, dynamic>?;
    if (calculationData != null) {
      // Load survey entries
      final entriesData = calculationData['surveyEntries'] as List<dynamic>?;
      if (entriesData != null && entriesData.isNotEmpty) {
        // Clear existing entries
        for (var entry in surveyEntries) {
          entry['villageController']?.dispose();
          entry['surveyNoController']?.dispose();
          entry['areaController']?.dispose();
        }
        surveyEntries.clear();

        // Load saved entries with trim
        for (var entryData in entriesData) {
          final village = (entryData['village'] ?? '').toString().trim();
          final surveyNo = (entryData['surveyNo'] ?? '').toString().trim();
          final area = (entryData['area'] ?? '').toString().trim();

          final entry = {
            'id': entryData['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
            'villageController': TextEditingController(text: village),
            'surveyNoController': TextEditingController(text: surveyNo),
            'areaController': TextEditingController(text: area),
            'village': village,
            'surveyNo': surveyNo,
            'area': area,
          };
          surveyEntries.add(entry);
        }
      }
    }
  }

  // Clear all data
  void clearAllData() {
    for (var entry in surveyEntries) {
      entry['villageController']?.dispose();
      entry['surveyNoController']?.dispose();
      entry['areaController']?.dispose();
    }
    surveyEntries.clear();
    validationErrors.clear();
    addSurveyEntry(); // Add one default entry
  }

  // Get calculation summary for display
  Map<String, dynamic> getCalculationSummary() {
    return {
      'totalEntries': surveyEntries.length,
      'totalArea': totalArea,
      'entries': surveyEntries.map((entry) => {
        'village': (entry['village']?.toString() ?? '').trim(),
        'surveyNo': (entry['surveyNo']?.toString() ?? '').trim(),
        'area': (entry['area']?.toString() ?? '').trim(),
      }).toList(),
    };
  }

  // Additional helper methods

  // Check if any entry has the specified village
  bool hasVillageInEntries(String village) {
    return surveyEntries.any((entry) =>
    (entry['village']?.toString() ?? '').trim() == village.trim()
    );
  }

  // Get all unique villages selected across entries
  List<String> getSelectedVillages() {
    final villages = <String>[];
    for (var entry in surveyEntries) {
      final village = (entry['village']?.toString() ?? '').trim();
      if (village.isNotEmpty && !villages.contains(village)) {
        villages.add(village);
      }
    }
    return villages;
  }

  // Get entries count for a specific village
  int getEntriesCountForVillage(String village) {
    return surveyEntries
        .where((entry) => (entry['village']?.toString() ?? '').trim() == village.trim())
        .length;
  }

  // Get total area for a specific village
  double getTotalAreaForVillage(String village) {
    double total = 0.0;
    for (var entry in surveyEntries) {
      if ((entry['village']?.toString() ?? '').trim() == village.trim()) {
        final areaStr = (entry['area']?.toString() ?? '').trim();
        final area = double.tryParse(areaStr) ?? 0.0;
        total += area;
      }
    }
    return total;
  }

  // Validate if all entries are complete
  bool areAllEntriesComplete() {
    if (surveyEntries.isEmpty) return false;

    for (var entry in surveyEntries) {
      if (!_validateSurveyEntry(entry)) {
        return false;
      }
    }
    return true;
  }

  // Get completion percentage
  double getCompletionPercentage() {
    if (surveyEntries.isEmpty) return 0.0;

    int completeEntries = 0;
    for (var entry in surveyEntries) {
      if (_validateSurveyEntry(entry)) {
        completeEntries++;
      }
    }

    return (completeEntries / surveyEntries.length) * 100;
  }
}
