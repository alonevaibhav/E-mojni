import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../Controller/main_controller.dart';

class LandFouthController extends GetxController with StepValidationMixin, StepDataMixin {
  // Form controllers
  final countingFeeController = TextEditingController();

  // Observable variables
  final selectedCalculationType = 'Land acquisition case'.obs;
  final selectedDuration = ''.obs;
  final selectedHolderType = ''.obs;
  final countingFee = 0.obs;

  // Validation errors
  final validationErrors = <String, String>{}.obs;

  // Options for dropdowns
  final calculationTypeOptions = [
    'Land acquisition case',
  ];

  final durationOptions = [
    'niyamit',
    'drutgati',
  ];

  final holderTypeOptions = [
    'Companies/Other Institutions/Various Authorities/Corporations and Land Acquisition Joint Enumeration Holders (Other than Farmers)',
  ];

  // Legacy observable errors (kept for backward compatibility)
  final durationError = ''.obs;
  final holderTypeError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Listen to changes and calculate fee automatically
    ever(selectedDuration, (_) => calculateCountingFee());
    ever(selectedHolderType, (_) => calculateCountingFee());
  }

  @override
  void onClose() {
    countingFeeController.dispose();
    super.onClose();
  }

  // Update methods
  void updateCalculationType(String? value) {
    if (value != null) {
      selectedCalculationType.value = value;
      // Clear validation error
      validationErrors.remove('calculationType');
    }
  }

  void updateDuration(String? value) {
    if (value != null) {
      selectedDuration.value = value;
      // Clear validation errors
      validationErrors.remove('duration');
      durationError.value = '';
    }
  }

  void updateHolderType(String? value) {
    if (value != null) {
      selectedHolderType.value = value;
      // Clear validation errors
      validationErrors.remove('holderType');
      holderTypeError.value = '';
    }
  }

  // Calculate counting fee based on duration and holder type
  void calculateCountingFee() {
    if (selectedDuration.value.trim().isEmpty || selectedHolderType.value.trim().isEmpty) {
      countingFee.value = 0;
      countingFeeController.text = '0';
      return;
    }

    int fee = 0;

    // Check if holder type contains "Companies/Other Institutions/Various Authorities/Corporations"
    bool isCompanyOrInstitution = selectedHolderType.value.contains('Companies/Other Institutions/Various Authorities/Corporations');

    if (isCompanyOrInstitution) {
      if (selectedDuration.value == 'niyamit') {
        fee = 7500;
      } else if (selectedDuration.value == 'drutgati') {
        fee = 30000;
      }
    } else {
      // Different fee structures for other holder types
      if (selectedDuration.value == 'niyamit') {
        fee = 5000; // Example fee for other types
      } else if (selectedDuration.value == 'drutgati') {
        fee = 15000; // Example fee for other types
      }
    }

    countingFee.value = fee;
    countingFeeController.text = fee.toString();
  }

  //------------------------Validation------------------------//
  @override
  bool validateCurrentSubStep(String field) {
    switch (field) {
      case 'land_fouth_step':
        return _validateAllFields();
      default:
        return true;
    }
  }

  // Enhanced validation with isEmpty checks
  bool _validateAllFields() {
    validationErrors.clear();
    bool isValid = true;

    // Calculation Type validation with isEmpty check
    if (selectedCalculationType.value.trim().isEmpty) {
      validationErrors['calculationType'] = 'Calculation type is required';
      isValid = false;
    }

    // Duration validation with isEmpty check
    if (selectedDuration.value.trim().isEmpty) {
      validationErrors['duration'] = 'Duration is required';
      durationError.value = 'Duration is required'; // For backward compatibility
      isValid = false;
    }

    // Holder Type validation with isEmpty check
    if (selectedHolderType.value.trim().isEmpty) {
      validationErrors['holderType'] = 'Holder type is required';
      holderTypeError.value = 'Holder type is required'; // For backward compatibility
      isValid = false;
    }

    // Counting Fee validation (should be calculated automatically)
    if (countingFee.value <= 0 && selectedDuration.value.trim().isNotEmpty && selectedHolderType.value.trim().isNotEmpty) {
      validationErrors['countingFee'] = 'Counting fee calculation error';
      isValid = false;
    }

    return isValid;
  }

  // Legacy validation methods (kept for backward compatibility)
  bool _validateDuration() {
    if (selectedDuration.value.trim().isEmpty) {
      durationError.value = 'Duration is required';
      validationErrors['duration'] = 'Duration is required';
      return false;
    }
    durationError.value = '';
    validationErrors.remove('duration');
    return true;
  }

  bool _validateHolderType() {
    if (selectedHolderType.value.trim().isEmpty) {
      holderTypeError.value = 'Holder type is required';
      validationErrors['holderType'] = 'Holder type is required';
      return false;
    }
    holderTypeError.value = '';
    validationErrors.remove('holderType');
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
      case 'land_fouth_step':
        return _getCalculationError();
      default:
        return validationErrors[field] ?? 'This field is required';
    }
  }
  // Enhanced error messages with isEmpty validation
  String _getCalculationError() {
    // Return first validation error found with specific message
    if (validationErrors.isNotEmpty) {
      return validationErrors.values.first;
    }

    // Fallback error messages with isEmpty checks
    if (selectedCalculationType.value.trim().isEmpty) {
      return 'Calculation type is required';
    }

    if (selectedDuration.value.trim().isEmpty) {
      return 'Duration is required';
    }

    if (selectedHolderType.value.trim().isEmpty) {
      return 'Holder type is required';
    }



    return 'Please complete all calculation fields';
  }



  // StepDataMixin implementation
  @override
  Map<String, dynamic> getStepData() {
    return {
      'calculation_type': selectedCalculationType.value.trim(),
      'duration': selectedDuration.value.trim(),
      'holder_type': selectedHolderType.value.trim(),
      'counting_fee': countingFee.value,
      'counting_fee_text': countingFeeController.text.trim(),
      'is_step_completed': _validateAllFields(),
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  // Reset form
  void resetForm() {
    selectedCalculationType.value = 'Land acquisition case';
    selectedDuration.value = '';
    selectedHolderType.value = '';
    countingFee.value = 0;
    countingFeeController.clear();

    // Clear validation errors
    validationErrors.clear();
    durationError.value = '';
    holderTypeError.value = '';
  }

  // Load saved data (if needed)
  void loadSavedData(Map<String, dynamic> data) {
    if (data.containsKey('calculation_type')) {
      selectedCalculationType.value = (data['calculation_type'] ?? 'Land acquisition case').toString().trim();
    }
    if (data.containsKey('duration')) {
      selectedDuration.value = (data['duration'] ?? '').toString().trim();
    }
    if (data.containsKey('holder_type')) {
      selectedHolderType.value = (data['holder_type'] ?? '').toString().trim();
    }
    if (data.containsKey('counting_fee')) {
      countingFee.value = data['counting_fee'] ?? 0;
      countingFeeController.text = countingFee.value.toString();
    }

    // Clear validation errors after loading
    validationErrors.clear();
    durationError.value = '';
    holderTypeError.value = '';
  }

  // NEW: Validate specific field
  bool validateSpecificField(String fieldType) {
    switch (fieldType) {
      case 'calculationType':
        if (selectedCalculationType.value.trim().isEmpty) {
          validationErrors['calculationType'] = 'Calculation type is required';
          return false;
        }
        validationErrors.remove('calculationType');
        return true;

      case 'duration':
        return _validateDuration();

      case 'holderType':
        return _validateHolderType();

      case 'countingFee':
        if (countingFee.value <= 0 && selectedDuration.value.trim().isNotEmpty && selectedHolderType.value.trim().isNotEmpty) {
          validationErrors['countingFee'] = 'Counting fee calculation error';
          return false;
        }
        validationErrors.remove('countingFee');
        return true;

      default:
        return true;
    }
  }
}
