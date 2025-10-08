import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../Widget/address.dart';
import '../Controller/main_controller.dart';

class CensusFifthController extends GetxController with StepValidationMixin, StepDataMixin {
  // Observable list of applicant entries
  final applicantEntries = <Map<String, dynamic>>[].obs;

  // Loading states
  final isLoading = false.obs;

  // Validation errors
  final validationErrors = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with one entry
    addApplicantEntry();
  }

  // Add new applicant entry
  void addApplicantEntry() {
    final newEntry = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'agreementController': TextEditingController(),
      'accountHolderNameController': TextEditingController(),
      'accountNumberController': TextEditingController(),
      'mobileNumberController': TextEditingController(),
      'serverNumberController': TextEditingController(),
      'areaController': TextEditingController(),
      'potkaharabaAreaController': TextEditingController(),
      'totalAreaController': TextEditingController(),
      // Address fields
      'address': <String, dynamic>{
        'plotNo': '',
        'address': '',
        'mobileNumber': '',
        'email': '',
        'pincode': '',
        'district': '',
        'village': '',
        'postOffice': '',
      }.obs,
      // Controllers for address popup
      'addressControllers': <String, TextEditingController>{
        'plotNoController': TextEditingController(),
        'addressController': TextEditingController(),
        'mobileNumberController': TextEditingController(),
        'emailController': TextEditingController(),
        'pincodeController': TextEditingController(),
        'districtController': TextEditingController(),
        'villageController': TextEditingController(),
        'postOfficeController': TextEditingController(),
      },
      // Address validation errors per entry
      'addressValidationErrors': <String, String>{}.obs,
    };
    applicantEntries.add(newEntry);
  }

  // Remove applicant entry
  void removeApplicantEntry(int index) {
    if (applicantEntries.length > 1 && index < applicantEntries.length) {
      // Dispose controllers safely
      final entry = applicantEntries[index];

      // Dispose main controllers
      (entry['agreementController'] as TextEditingController?)?.dispose();
      (entry['accountHolderNameController'] as TextEditingController?)?.dispose();
      (entry['accountNumberController'] as TextEditingController?)?.dispose();
      (entry['mobileNumberController'] as TextEditingController?)?.dispose();
      (entry['serverNumberController'] as TextEditingController?)?.dispose();
      (entry['areaController'] as TextEditingController?)?.dispose();
      (entry['potkaharabaAreaController'] as TextEditingController?)?.dispose();
      (entry['totalAreaController'] as TextEditingController?)?.dispose();

      // Dispose address controllers safely
      final addressControllers = entry['addressControllers'] as Map<String, TextEditingController>?;
      addressControllers?.values.forEach((controller) => controller.dispose());

      applicantEntries.removeAt(index);

      // Clear validation errors for this entry
      _clearEntryValidationErrors(index);
    }
  }

  // Clear validation errors for a specific entry
  void _clearEntryValidationErrors(int index) {
    final keysToRemove = validationErrors.keys.where((key) => key.startsWith('${index}_')).toList();
    for (String key in keysToRemove) {
      validationErrors.remove(key);
    }
  }

  // Update applicant entry field
  void updateApplicantEntry(int index, String field, String value) {
    if (index < applicantEntries.length) {
      // Clear validation error for this field
      validationErrors.remove('${index}_$field');
    }
  }

  // Show address popup
  Future<void> showAddressPopup(BuildContext context, int entryIndex) async {
    if (entryIndex >= applicantEntries.length) return;

    final entry = applicantEntries[entryIndex];
    final addressControllers = entry['addressControllers'] as Map<String, TextEditingController>?;
    final addressData = entry['address'] as RxMap<String, dynamic>?;

    if (addressControllers == null || addressData == null) return;

    // Pre-fill controllers with existing data safely
    addressControllers['plotNoController']?.text = addressData['plotNo']?.toString() ?? '';
    addressControllers['addressController']?.text = addressData['address']?.toString() ?? '';
    addressControllers['mobileNumberController']?.text = addressData['mobileNumber']?.toString() ?? '';
    addressControllers['emailController']?.text = addressData['email']?.toString() ?? '';
    addressControllers['pincodeController']?.text = addressData['pincode']?.toString() ?? '';
    addressControllers['districtController']?.text = addressData['district']?.toString() ?? '';
    addressControllers['villageController']?.text = addressData['village']?.toString() ?? '';
    addressControllers['postOfficeController']?.text = addressData['postOffice']?.toString() ?? '';

    final result = await Get.dialog<bool>(
      AddressPopup(
        entryIndex: entryIndex,
        controllers: addressControllers,
        onSave: () {
          _saveAddressData(entryIndex, addressControllers);
          Get.back(result: true);
        },
      ),
      barrierDismissible: false,
    );
  }

  // Save address data with validation
  void _saveAddressData(int entryIndex, Map<String, TextEditingController> controllers) {
    if (entryIndex >= applicantEntries.length) return;

    final entry = applicantEntries[entryIndex];
    final addressData = entry['address'] as RxMap<String, dynamic>?;

    if (addressData == null) return;

    addressData.addAll({
      'plotNo': (controllers['plotNoController']?.text ?? '').trim(),
      'address': (controllers['addressController']?.text ?? '').trim(),
      'mobileNumber': (controllers['mobileNumberController']?.text ?? '').trim(),
      'email': (controllers['emailController']?.text ?? '').trim(),
      'pincode': (controllers['pincodeController']?.text ?? '').trim(),
      'district': (controllers['districtController']?.text ?? '').trim(),
      'village': (controllers['villageController']?.text ?? '').trim(),
      'postOffice': (controllers['postOfficeController']?.text ?? '').trim(),
    });

    // Validate address after saving
    _validateEntryAddress(entryIndex, addressData);
  }

  // Validate address for a specific entry
  void _validateEntryAddress(int entryIndex, RxMap<String, dynamic> addressData) {
    final entry = applicantEntries[entryIndex];
    final addressValidationErrors = entry['addressValidationErrors'] as RxMap<String, String>;
    addressValidationErrors.clear();

    if ((addressData['address']?.toString() ?? '').trim().isEmpty) {
      addressValidationErrors['address'] = 'Address is required';
    }
    if ((addressData['pincode']?.toString() ?? '').trim().isEmpty) {
      addressValidationErrors['pincode'] = 'Pincode is required';
    }
    if ((addressData['village']?.toString() ?? '').trim().isEmpty) {
      addressValidationErrors['village'] = 'Village is required';
    }
    if ((addressData['postOffice']?.toString() ?? '').trim().isEmpty) {
      addressValidationErrors['postOffice'] = 'Post Office is required';
    }
  }

  // Get formatted address string
  String getFormattedAddress(int entryIndex) {
    if (entryIndex >= applicantEntries.length) return 'Click to add address';

    final addressData = applicantEntries[entryIndex]['address'] as RxMap<String, dynamic>?;
    if (addressData == null) return 'Click to add address';

    final plotNo = (addressData['plotNo']?.toString() ?? '').trim();
    final address = (addressData['address']?.toString() ?? '').trim();
    final village = (addressData['village']?.toString() ?? '').trim();

    if (plotNo.isEmpty && address.isEmpty && village.isEmpty) {
      return 'Click to add address';
    }

    return [plotNo, address, village].where((s) => s.isNotEmpty).join(', ');
  }

  //------------------------Validation------------------------//
  @override
  bool validateCurrentSubStep(String field) {
    switch (field) {
      case 'applicant':
        return _validateAllApplicants();

      default:
        return true;
    }
  }

  // Enhanced validation with isEmpty checks
  bool _validateAllApplicants() {
    validationErrors.clear();
    bool isValid = true;

    if (applicantEntries.isEmpty) {
      validationErrors['entries'] = 'Please add at least one applicant entry';
      return false;
    }

    for (int i = 0; i < applicantEntries.length; i++) {
      final entry = applicantEntries[i];


      // Account holder name validation with isEmpty check
      final accountHolderNameText = ((entry['accountHolderNameController'] as TextEditingController?)?.text ?? '').trim();
      if (accountHolderNameText.isEmpty) {
        validationErrors['${i}_accountHolderName'] = 'Account holder name is required for applicant ${i + 1}';
        isValid = false;
      }


      // Mobile number validation with isEmpty check
      final mobileNumberText = ((entry['mobileNumberController'] as TextEditingController?)?.text ?? '').trim();
      if (mobileNumberText.isEmpty) {
        validationErrors['${i}_mobileNumber'] = 'Mobile number is required for applicant ${i + 1}';
        isValid = false;
      }

      // Validate address data with isEmpty checks
      final addressData = entry['address'] as RxMap<String, dynamic>?;
      if (addressData != null) {
        _validateEntryAddress(i, addressData);
        final addressValidationErrors = entry['addressValidationErrors'] as RxMap<String, String>;

        if (addressValidationErrors.isNotEmpty) {
          validationErrors['${i}_address_details'] = 'Please complete address details for applicant ${i + 1}';
          isValid = false;
        }
      } else {
        validationErrors['${i}_address'] = 'Address is required for applicant ${i + 1}';
        isValid = false;
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
      case 'applicant':
        return _getApplicantsError();
      case 'government_survey':
        return _getGovernmentSurveyError();
      default:
        return validationErrors[field] ?? 'This field is required';
    }
  }

  // Government survey validation errors
  String _getGovernmentSurveyError() {
    if (applicantEntries.isEmpty) {
      return 'Please add at least one applicant entry';
    }

    return 'Please complete government survey information';
  }

  // Enhanced error messages
  String _getApplicantsError() {
    // Return first validation error found with specific message
    if (validationErrors.isNotEmpty) {
      return validationErrors.values.first;
    }

    if (applicantEntries.isEmpty) {
      return 'Please add at least one applicant entry';
    }

    return 'Please complete all required fields';
  }

  // Get specific field error for an entry
  String getEntryFieldError(int entryIndex, String fieldName) {
    final errorKey = '${entryIndex}_$fieldName';
    return validationErrors[errorKey] ?? '';
  }

  // Check if entry field has validation error
  bool hasEntryFieldError(int entryIndex, String fieldName) {
    final errorKey = '${entryIndex}_$fieldName';
    return validationErrors.containsKey(errorKey);
  }

  @override
  Map<String, dynamic> getStepData() {
    final data = <String, dynamic>{};

    for (int i = 0; i < applicantEntries.length; i++) {
      final entry = applicantEntries[i];
      final addressData = entry['address'] as RxMap<String, dynamic>?;

      data['applicant_$i'] = {
        'agreement': ((entry['agreementController'] as TextEditingController?)?.text ?? '').trim(),
        'accountHolderName': ((entry['accountHolderNameController'] as TextEditingController?)?.text ?? '').trim(),
        'accountNumber': ((entry['accountNumberController'] as TextEditingController?)?.text ?? '').trim(),
        'mobileNumber': ((entry['mobileNumberController'] as TextEditingController?)?.text ?? '').trim(),
        'serverNumber': ((entry['serverNumberController'] as TextEditingController?)?.text ?? '').trim(),
        'area': ((entry['areaController'] as TextEditingController?)?.text ?? '').trim(),
        'potkaharabaArea': ((entry['potkaharabaAreaController'] as TextEditingController?)?.text ?? '').trim(),
        'totalArea': ((entry['totalAreaController'] as TextEditingController?)?.text ?? '').trim(),
        'address': addressData != null ? Map<String, dynamic>.from(addressData) : <String, dynamic>{},
      };
    }

    data['applicantCount'] = applicantEntries.length;
    data['isStepCompleted'] = _validateAllApplicants();
    data['timestamp'] = DateTime.now().toIso8601String();

    return data;
  }

  // Load step data
  void loadStepData(Map<String, dynamic> data) {
    final applicantCount = data['applicantCount'] as int? ?? 0;

    // Clear existing entries
    for (final entry in applicantEntries) {
      (entry['agreementController'] as TextEditingController?)?.dispose();
      (entry['accountHolderNameController'] as TextEditingController?)?.dispose();
      (entry['accountNumberController'] as TextEditingController?)?.dispose();
      (entry['mobileNumberController'] as TextEditingController?)?.dispose();
      (entry['serverNumberController'] as TextEditingController?)?.dispose();
      (entry['areaController'] as TextEditingController?)?.dispose();
      (entry['potkaharabaAreaController'] as TextEditingController?)?.dispose();
      (entry['totalAreaController'] as TextEditingController?)?.dispose();

      final addressControllers = entry['addressControllers'] as Map<String, TextEditingController>?;
      addressControllers?.values.forEach((controller) => controller.dispose());
    }
    applicantEntries.clear();

    // Load saved entries
    for (int i = 0; i < applicantCount; i++) {
      final applicantData = data['applicant_$i'] as Map<String, dynamic>?;
      if (applicantData != null) {
        addApplicantEntry();
        final index = applicantEntries.length - 1;
        final entry = applicantEntries[index];

        (entry['agreementController'] as TextEditingController).text = applicantData['agreement'] ?? '';
        (entry['accountHolderNameController'] as TextEditingController).text = applicantData['accountHolderName'] ?? '';
        (entry['accountNumberController'] as TextEditingController).text = applicantData['accountNumber'] ?? '';
        (entry['mobileNumberController'] as TextEditingController).text = applicantData['mobileNumber'] ?? '';
        (entry['serverNumberController'] as TextEditingController).text = applicantData['serverNumber'] ?? '';
        (entry['areaController'] as TextEditingController).text = applicantData['area'] ?? '';
        (entry['potkaharabaAreaController'] as TextEditingController).text = applicantData['potkaharabaArea'] ?? '';
        (entry['totalAreaController'] as TextEditingController).text = applicantData['totalArea'] ?? '';

        if (applicantData['address'] != null) {
          final addressData = entry['address'] as RxMap<String, dynamic>;
          addressData.assignAll(Map<String, dynamic>.from(applicantData['address']));
        }
      }
    }
  }

  @override
  void onClose() {
    // Dispose all controllers safely
    for (final entry in applicantEntries) {
      (entry['agreementController'] as TextEditingController?)?.dispose();
      (entry['accountHolderNameController'] as TextEditingController?)?.dispose();
      (entry['accountNumberController'] as TextEditingController?)?.dispose();
      (entry['mobileNumberController'] as TextEditingController?)?.dispose();
      (entry['serverNumberController'] as TextEditingController?)?.dispose();
      (entry['areaController'] as TextEditingController?)?.dispose();
      (entry['potkaharabaAreaController'] as TextEditingController?)?.dispose();
      (entry['totalAreaController'] as TextEditingController?)?.dispose();

      final addressControllers = entry['addressControllers'] as Map<String, TextEditingController>?;
      addressControllers?.values.forEach((controller) => controller.dispose());
    }
    super.onClose();
  }
}
