import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../Widget/address.dart';
import '../Controller/main_controller.dart';

class AllocationFifthController extends GetxController with StepValidationMixin, StepDataMixin {
  // Plaintiff and Defendant entries
  final plaintiffDefendantEntries = <Map<String, dynamic>>[].obs;

  // Validation errors
  final validationErrors = <String, String>{}.obs;

  // Dropdown options
  final typeOptions = <String>['Plaintiff', 'Defendant'].obs;

  @override
  void onInit() {
    super.onInit();
    // Add initial entry
    addPlaintiffDefendantEntry();
  }

  @override
  void onClose() {
    // Dispose all controllers
    for (var entry in plaintiffDefendantEntries) {
      entry['nameController']?.dispose();
      entry['addressController']?.dispose();
      entry['mobileController']?.dispose();
      entry['surveyNumberController']?.dispose();
      // Dispose address popup controllers
      entry['addressPopupControllers']?.forEach((key, controller) {
        controller?.dispose();
      });
    }
    super.onClose();
  }

  void addPlaintiffDefendantEntry() {
    final newEntry = {
      'nameController': TextEditingController(),
      'addressController': TextEditingController(),
      'mobileController': TextEditingController(),
      'surveyNumberController': TextEditingController(),
      'selectedType': RxString('Plaintiff'),
      'name': '',
      'address': '',
      'mobile': '',
      'surveyNumber': '',
      'type': 'Plaintiff',
      // Address popup controllers
      'addressPopupControllers': {
        'plotNoController': TextEditingController(),
        'addressController': TextEditingController(),
        'mobileNumberController': TextEditingController(),
        'emailController': TextEditingController(),
        'pincodeController': TextEditingController(),
        'districtController': TextEditingController(),
        'villageController': TextEditingController(),
        'postOfficeController': TextEditingController(),
      },
      'detailedAddress': <String, String>{}.obs, // Store detailed address data
      'addressValidationErrors': <String, String>{}.obs, // Detailed address validation
    };

    plaintiffDefendantEntries.add(newEntry);
  }

  void removePlaintiffDefendantEntry(int index) {
    if (plaintiffDefendantEntries.length > 1 && index < plaintiffDefendantEntries.length) {
      final entry = plaintiffDefendantEntries[index];
      // Dispose controllers
      entry['nameController']?.dispose();
      entry['addressController']?.dispose();
      entry['mobileController']?.dispose();
      entry['surveyNumberController']?.dispose();

      // Dispose address popup controllers
      entry['addressPopupControllers']?.forEach((key, controller) {
        controller?.dispose();
      });

      plaintiffDefendantEntries.removeAt(index);

      // Clear validation errors for this entry
      _clearEntryValidationErrors(index);
    }
  }

  void updatePlaintiffDefendantEntry(int index, String field, String value) {
    if (index < plaintiffDefendantEntries.length) {
      plaintiffDefendantEntries[index][field] = value;

      // Clear validation error for this specific field
      validationErrors.remove('${index}_$field');

      plaintiffDefendantEntries.refresh();
    }
  }

  void updateSelectedType(int index, String value) {
    if (index < plaintiffDefendantEntries.length) {
      final selectedType = plaintiffDefendantEntries[index]['selectedType'] as RxString;
      selectedType.value = value;
      plaintiffDefendantEntries[index]['type'] = value;

      // Clear validation error for type field
      validationErrors.remove('${index}_type');
    }
  }

  // Clear validation errors for a specific entry
  void _clearEntryValidationErrors(int index) {
    final keysToRemove = validationErrors.keys.where((key) => key.startsWith('${index}_')).toList();
    for (String key in keysToRemove) {
      validationErrors.remove(key);
    }
  }

  // Method to open address popup
  void openAddressPopup(int entryIndex) {
    if (entryIndex < plaintiffDefendantEntries.length) {
      final entry = plaintiffDefendantEntries[entryIndex];
      final controllers = entry['addressPopupControllers'] as Map<String, TextEditingController>;

      // Pre-populate with existing data if available
      final detailedAddress = entry['detailedAddress'] as RxMap<String, String>;
      controllers['plotNoController']!.text = detailedAddress['plotNo'] ?? '';
      controllers['addressController']!.text = detailedAddress['address'] ?? '';
      controllers['mobileNumberController']!.text = detailedAddress['mobileNumber'] ?? '';
      controllers['emailController']!.text = detailedAddress['email'] ?? '';
      controllers['pincodeController']!.text = detailedAddress['pincode'] ?? '';
      controllers['districtController']!.text = detailedAddress['district'] ?? '';
      controllers['villageController']!.text = detailedAddress['village'] ?? '';
      controllers['postOfficeController']!.text = detailedAddress['postOffice'] ?? '';

      Get.dialog(
        AddressPopup(
          entryIndex: entryIndex,
          controllers: controllers,
          onSave: () => saveDetailedAddress(entryIndex),
        ),
      );
    }
  }

  // Method to save detailed address
  void saveDetailedAddress(int entryIndex) {
    if (entryIndex < plaintiffDefendantEntries.length) {
      final entry = plaintiffDefendantEntries[entryIndex];
      final controllers = entry['addressPopupControllers'] as Map<String, TextEditingController>;
      final detailedAddress = entry['detailedAddress'] as RxMap<String, String>;

      // Save all address fields with trim
      detailedAddress['plotNo'] = controllers['plotNoController']!.text.trim();
      detailedAddress['address'] = controllers['addressController']!.text.trim();
      detailedAddress['mobileNumber'] = controllers['mobileNumberController']!.text.trim();
      detailedAddress['email'] = controllers['emailController']!.text.trim();
      detailedAddress['pincode'] = controllers['pincodeController']!.text.trim();
      detailedAddress['district'] = controllers['districtController']!.text.trim();
      detailedAddress['village'] = controllers['villageController']!.text.trim();
      detailedAddress['postOffice'] = controllers['postOfficeController']!.text.trim();

      // Validate detailed address
      _validateDetailedAddress(entryIndex, detailedAddress);

      // Update the main address field with a formatted summary
      String formattedAddress = _formatAddressSummary(detailedAddress);
      entry['addressController'].text = formattedAddress;

      // Also update the mobile number in main form if provided
      if (detailedAddress['mobileNumber']?.isNotEmpty == true) {
        entry['mobileController'].text = detailedAddress['mobileNumber']!;
      }

      plaintiffDefendantEntries.refresh();
      Get.back(); // Close the popup
    }
  }

  // Validate detailed address fields
  void _validateDetailedAddress(int entryIndex, RxMap<String, String> addressData) {
    final entry = plaintiffDefendantEntries[entryIndex];
    final addressValidationErrors = entry['addressValidationErrors'] as RxMap<String, String>;
    addressValidationErrors.clear();

    if (addressData['address']?.trim().isEmpty ?? true) {
      addressValidationErrors['address'] = 'Address is required';
    }
    if (addressData['pincode']?.trim().isEmpty ?? true) {
      addressValidationErrors['pincode'] = 'Pincode is required';
    }
    if (addressData['village']?.trim().isEmpty ?? true) {
      addressValidationErrors['village'] = 'Village is required';
    }
    if (addressData['postOffice']?.trim().isEmpty ?? true) {
      addressValidationErrors['postOffice'] = 'Post Office is required';
    }
  }

  // Helper method to format address summary
  String _formatAddressSummary(RxMap<String, String> detailedAddress) {
    List<String> addressParts = [];

    if (detailedAddress['plotNo']?.isNotEmpty == true) {
      addressParts.add(detailedAddress['plotNo']!);
    }
    if (detailedAddress['address']?.isNotEmpty == true) {
      addressParts.add(detailedAddress['address']!);
    }
    if (detailedAddress['village']?.isNotEmpty == true) {
      addressParts.add(detailedAddress['village']!);
    }
    if (detailedAddress['district']?.isNotEmpty == true) {
      addressParts.add(detailedAddress['district']!);
    }
    if (detailedAddress['pincode']?.isNotEmpty == true) {
      addressParts.add(detailedAddress['pincode']!);
    }

    return addressParts.isEmpty ? 'Click to add address' : addressParts.join(', ');
  }

  // Check if detailed address is available
  bool hasDetailedAddress(int index) {
    if (index < plaintiffDefendantEntries.length) {
      final detailedAddress = plaintiffDefendantEntries[index]['detailedAddress'] as RxMap<String, String>;
      return detailedAddress.isNotEmpty &&
          (detailedAddress['address']?.isNotEmpty == true ||
              detailedAddress['village']?.isNotEmpty == true);
    }
    return false;
  }

  //------------------------Validation------------------------//
  @override
  bool validateCurrentSubStep(String field) {
    switch (field) {
      case 'plaintiff_defendant':
        return _validateAllEntries();
      case 'government_survey':
        return _validateGovernmentSurveyFields();
      default:
        return true;
    }
  }

  // NEW: Validate government survey fields
  bool _validateGovernmentSurveyFields() {
    validationErrors.clear();

    if (plaintiffDefendantEntries.isEmpty) {
      validationErrors['entries'] = 'Please add at least one plaintiff/defendant entry';
      return false;
    }

    return true;
  }

  // Enhanced validation with isEmpty checks
  bool _validateAllEntries() {
    validationErrors.clear();
    bool isValid = true;

    if (plaintiffDefendantEntries.isEmpty) {
      validationErrors['entries'] = 'Please add at least one plaintiff/defendant entry';
      return false;
    }

    for (int i = 0; i < plaintiffDefendantEntries.length; i++) {
      final entry = plaintiffDefendantEntries[i];

      // Name validation with isEmpty check
      final name = (entry['nameController']?.text ?? '').trim();
      if (name.isEmpty) {
        validationErrors['${i}_name'] = 'Name is required for entry ${i + 1}';
        isValid = false;
      }

      // Type validation with isEmpty check
      final selectedType = entry['selectedType'] as RxString?;
      final type = (selectedType?.value ?? '').trim();
      if (type.isEmpty) {
        validationErrors['${i}_type'] = 'Type (Plaintiff/Defendant) is required for entry ${i + 1}';
        isValid = false;
      }

      // Address validation with isEmpty check
      final address = (entry['addressController']?.text ?? '').trim();
      if (address.isEmpty || address == 'Click to add address') {
        validationErrors['${i}_address'] = 'Address is required for entry ${i + 1}';
        isValid = false;
      }

      // Validate detailed address if available
      final detailedAddress = entry['detailedAddress'] as RxMap<String, String>;
      if (detailedAddress.isNotEmpty) {
        _validateDetailedAddress(i, detailedAddress);
        final addressValidationErrors = entry['addressValidationErrors'] as RxMap<String, String>;
        if (addressValidationErrors.isNotEmpty) {
          validationErrors['${i}_detailed_address'] = 'Please complete address details for entry ${i + 1}';
          isValid = false;
        }
      }

      // Mobile number validation with isEmpty check
      final mobile = (entry['mobileController']?.text ?? '').trim();
      if (mobile.isEmpty) {
        validationErrors['${i}_mobile'] = 'Mobile number is required for entry ${i + 1}';
        isValid = false;
      }

      // Survey number validation with isEmpty check
      final surveyNumber = (entry['surveyNumberController']?.text ?? '').trim();
      if (surveyNumber.isEmpty) {
        validationErrors['${i}_surveyNumber'] = 'Survey number is required for entry ${i + 1}';
        isValid = false;
      }
    }

    return isValid;
  }

  // Enhanced single entry validation
  bool _validateSingleEntry(Map<String, dynamic> entry) {
    final name = (entry['nameController']?.text ?? '').trim();
    final address = (entry['addressController']?.text ?? '').trim();
    final mobile = (entry['mobileController']?.text ?? '').trim();
    final surveyNumber = (entry['surveyNumberController']?.text ?? '').trim();
    final selectedType = entry['selectedType'] as RxString?;
    final type = (selectedType?.value ?? '').trim();

    return name.isNotEmpty &&
        address.isNotEmpty &&
        address != 'Click to add address' &&
        mobile.isNotEmpty &&
        surveyNumber.isNotEmpty &&
        type.isNotEmpty;
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
      case 'plaintiff_defendant':
        return _getPlaintiffDefendantError();
      case 'government_survey':
        return _getGovernmentSurveyError();
      default:
        return validationErrors[field] ?? 'This field is required';
    }
  }

  // NEW: Government survey validation errors
  String _getGovernmentSurveyError() {
    if (plaintiffDefendantEntries.isEmpty) {
      return 'Please add at least one plaintiff/defendant entry';
    }

    return 'Please complete government survey information';
  }

  // Enhanced error messages
  String _getPlaintiffDefendantError() {
    // Return first validation error found with specific message
    if (validationErrors.isNotEmpty) {
      return validationErrors.values.first;
    }

    if (plaintiffDefendantEntries.isEmpty) {
      return 'Please add at least one plaintiff/defendant entry';
    }

    for (int i = 0; i < plaintiffDefendantEntries.length; i++) {
      final entry = plaintiffDefendantEntries[i];
      if (!_validateSingleEntry(entry)) {
        return 'Please complete all fields in Entry ${i + 1}';
      }
    }

    return 'Invalid plaintiff/defendant information';
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

  @override
  Map<String, dynamic> getStepData() {
    final List<Map<String, dynamic>> entriesData = [];

    for (var entry in plaintiffDefendantEntries) {
      final selectedType = entry['selectedType'] as RxString?;
      final detailedAddress = entry['detailedAddress'] as RxMap<String, String>;

      entriesData.add({
        'name': (entry['nameController']?.text ?? '').trim(),
        'address': (entry['addressController']?.text ?? '').trim(),
        'mobile': (entry['mobileController']?.text ?? '').trim(),
        'surveyNumber': (entry['surveyNumberController']?.text ?? '').trim(),
        'type': (selectedType?.value ?? '').trim(),
        'detailedAddress': Map<String, String>.from(detailedAddress),
      });
    }

    return {
      'plaintiffDefendantEntries': entriesData,
      'stepCompleted': isStepCompleted(['plaintiff_defendant']),
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  // Simplified validation helpers with isEmpty checks
  bool isValidMobileNumber(String mobile) {
    return mobile.trim().isNotEmpty;
  }

  bool isValidName(String name) {
    return name.trim().isNotEmpty;
  }

  bool isValidAddress(String address) {
    return address.trim().isNotEmpty && address != 'Click to add address';
  }

  bool isValidSurveyNumber(String surveyNumber) {
    return surveyNumber.trim().isNotEmpty;
  }

  // NEW: Load step data
  void loadStepData(Map<String, dynamic> data) {
    if (data['plaintiffDefendantEntries'] != null) {
      final entriesData = List<Map<String, dynamic>>.from(data['plaintiffDefendantEntries']);

      // Clear existing entries
      for (var entry in plaintiffDefendantEntries) {
        entry['nameController']?.dispose();
        entry['addressController']?.dispose();
        entry['mobileController']?.dispose();
        entry['surveyNumberController']?.dispose();
        entry['addressPopupControllers']?.forEach((key, controller) {
          controller?.dispose();
        });
      }
      plaintiffDefendantEntries.clear();

      // Load saved entries
      for (var entryData in entriesData) {
        addPlaintiffDefendantEntry();
        final index = plaintiffDefendantEntries.length - 1;
        final entry = plaintiffDefendantEntries[index];

        entry['nameController'].text = entryData['name'] ?? '';
        entry['addressController'].text = entryData['address'] ?? '';
        entry['mobileController'].text = entryData['mobile'] ?? '';
        entry['surveyNumberController'].text = entryData['surveyNumber'] ?? '';

        final selectedType = entry['selectedType'] as RxString;
        selectedType.value = entryData['type'] ?? 'Plaintiff';

        if (entryData['detailedAddress'] != null) {
          final detailedAddress = entry['detailedAddress'] as RxMap<String, String>;
          detailedAddress.assignAll(Map<String, String>.from(entryData['detailedAddress']));
        }
      }
    }
  }
}
