import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../Controller/main_controller.dart';
import '../../Widget/address.dart';

class PersonalInfoController extends GetxController
    with StepValidationMixin, StepDataMixin {
  // Text Controllers
  final applicantNameController = TextEditingController();
  final applicantAddressController = TextEditingController(); // Keep for backward compatibility

  final courtNameController = TextEditingController();
  final courtAddressController = TextEditingController();
  final courtOrderNumberController = TextEditingController();
  final courtAllotmentDateController = TextEditingController();
  final claimNumberYearController = TextEditingController();
  final specialOrderCommentsController = TextEditingController();

  // File Upload Lists
  final courtOrderFiles = <String>[].obs;

  // Date Selection
  final courtAllotmentDate = Rxn<DateTime>();

  // Validation errors
  final validationErrors = <String, String>{}.obs;

  //------------------------Applicant Address Validation Implementation ------------------------//

  // Applicant address data storage
  final applicantAddressData = <String, String>{
    'plotNo': '',
    'address': '',
    'mobileNumber': '',
    'email': '',
    'pincode': '',
    'district': '',
    'village': '',
    'postOffice': '',
  }.obs;

  // Applicant address validation errors
  final applicantAddressValidationErrors = <String, String>{}.obs;

  // Applicant address controllers for the popup
  final applicantAddressControllers = <String, TextEditingController>{
    'plotNoController': TextEditingController(),
    'addressController': TextEditingController(),
    'mobileNumberController': TextEditingController(),
    'emailController': TextEditingController(),
    'pincodeController': TextEditingController(),
    'districtController': TextEditingController(),
    'villageController': TextEditingController(),
    'postOfficeController': TextEditingController(),
  };

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
  }

  void _initializeControllers() {
    // Initialize any default values if needed
    validationErrors.clear();
  }

  @override
  void onClose() {
    // Dispose text controllers
    applicantNameController.dispose();
    applicantAddressController.dispose();
    courtNameController.dispose();
    courtAddressController.dispose();
    courtOrderNumberController.dispose();
    courtAllotmentDateController.dispose();
    claimNumberYearController.dispose();
    specialOrderCommentsController.dispose();

    // Dispose address controllers
    applicantAddressControllers.values
        .forEach((controller) => controller.dispose());

    super.onClose();
  }

  // Date Update Methods
  void updateCourtAllotmentDate(DateTime selectedDate) {
    courtAllotmentDate.value = selectedDate;
    courtAllotmentDateController.text =
    "${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.year}";

    // Clear validation error
    validationErrors.remove('courtAllotmentDate');
  }

  //------------------------Applicant Address Methods ------------------------//

  String getFormattedApplicantAddress() {
    final parts = <String>[];
    // Plot No
    if (applicantAddressData['plotNo']?.isNotEmpty == true) {
      parts.add('Plot No: ${applicantAddressData['plotNo']}');
    }
    // Address (house/building, street, locality)
    if (applicantAddressData['address']?.isNotEmpty == true) {
      parts.add(applicantAddressData['address']!);
    }
    // Village
    if (applicantAddressData['village']?.isNotEmpty == true) {
      parts.add(applicantAddressData['village']!);
    }
    // Post Office
    if (applicantAddressData['postOffice']?.isNotEmpty == true) {
      parts.add('Post: ${applicantAddressData['postOffice']}');
    }
    // District
    if (applicantAddressData['district']?.isNotEmpty == true) {
      parts.add('Dist: ${applicantAddressData['district']}');
    }
    // Pincode
    if (applicantAddressData['pincode']?.isNotEmpty == true) {
      parts.add('Pin: ${applicantAddressData['pincode']}');
    }
    // Mobile Number (optional)
    if (applicantAddressData['mobileNumber']?.isNotEmpty == true) {
      parts.add('Mobile: ${applicantAddressData['mobileNumber']}');
    }
    // Email (optional)
    if (applicantAddressData['email']?.isNotEmpty == true) {
      parts.add('Email: ${applicantAddressData['email']}');
    }

    return parts.isEmpty ? 'Click to add address' : parts.join(', ');
  }

  // Check if detailed applicant address is available
  bool hasDetailedApplicantAddress() {
    return applicantAddressData.isNotEmpty &&
        (applicantAddressData['address']?.isNotEmpty == true ||
            applicantAddressData['village']?.isNotEmpty == true);
  }

  // Show applicant address popup
  void showApplicantAddressPopup(BuildContext context) {
    // Populate controllers with current data
    applicantAddressControllers['plotNoController']!.text =
        applicantAddressData['plotNo'] ?? '';
    applicantAddressControllers['addressController']!.text =
        applicantAddressData['address'] ?? '';
    applicantAddressControllers['mobileNumberController']!.text =
        applicantAddressData['mobileNumber'] ?? '';
    applicantAddressControllers['emailController']!.text =
        applicantAddressData['email'] ?? '';
    applicantAddressControllers['pincodeController']!.text =
        applicantAddressData['pincode'] ?? '';
    applicantAddressControllers['districtController']!.text =
        applicantAddressData['district'] ?? '';
    applicantAddressControllers['villageController']!.text =
        applicantAddressData['village'] ?? '';
    applicantAddressControllers['postOfficeController']!.text =
        applicantAddressData['postOffice'] ?? '';

    showDialog(
      context: context,
      builder: (context) => AddressPopup(
        entryIndex: 0,
        controllers: applicantAddressControllers,
        onSave: () => _saveApplicantAddressFromPopup(),
      ),
    );
  }

  // Save applicant address from popup
  void _saveApplicantAddressFromPopup() {
    final newAddressData = {
      'plotNo': applicantAddressControllers['plotNoController']!.text,
      'address': applicantAddressControllers['addressController']!.text,
      'mobileNumber':
      applicantAddressControllers['mobileNumberController']!.text,
      'email': applicantAddressControllers['emailController']!.text,
      'pincode': applicantAddressControllers['pincodeController']!.text,
      'district': applicantAddressControllers['districtController']!.text,
      'village': applicantAddressControllers['villageController']!.text,
      'postOffice': applicantAddressControllers['postOfficeController']!.text,
    };

    updateApplicantAddress(newAddressData);
    Get.back(); // Close the popup
  }

  // Update applicant address with validation
  void updateApplicantAddress(Map<String, String> newAddressData) {
    applicantAddressData.assignAll(newAddressData);

    // Update the old controller for backward compatibility
    applicantAddressController.text = getFormattedApplicantAddress();

    // Clear validation errors
    applicantAddressValidationErrors.clear();
    validationErrors.remove('applicantAddress');

    // Validate address fields
    _validateApplicantAddressFields(newAddressData);

    update(); // Trigger UI update
  }

  // Validate applicant address fields with isEmpty checks
  void _validateApplicantAddressFields(Map<String, String> addressData) {
    if (addressData['address']?.trim().isEmpty ?? true) {
      applicantAddressValidationErrors['address'] =
      'Applicant address is required';
    }
    if (addressData['pincode']?.trim().isEmpty ?? true) {
      applicantAddressValidationErrors['pincode'] = 'Pincode is required';
    }
    if (addressData['village']?.trim().isEmpty ?? true) {
      applicantAddressValidationErrors['village'] = 'Village is required';
    }
    if (addressData['postOffice']?.trim().isEmpty ?? true) {
      applicantAddressValidationErrors['postOffice'] =
      'Post Office is required';
    }
  }

  // Clear applicant address fields
  void clearApplicantAddressFields() {
    applicantAddressData.clear();
    applicantAddressValidationErrors.clear();
    applicantAddressControllers.values
        .forEach((controller) => controller.clear());
    applicantAddressController.clear();
  }

  //------------------------Validation------------------------//
  @override
  bool validateCurrentSubStep(String field) {
    switch (field) {
      case 'calculation':
        return _validateAllFields();
      case 'government_survey':
        return _validateGovernmentSurveyFields();
      default:
        return true;
    }
  }

  // NEW: Validate government survey fields
  bool _validateGovernmentSurveyFields() {
    validationErrors.clear();
    bool isValid = true;

    if (applicantNameController.text.trim().isEmpty) {
      validationErrors['applicantName'] = 'Applicant name is required';
      isValid = false;
    }

    return isValid;
  }

  // Enhanced validation with isEmpty checks only
  bool _validateAllFields() {
    validationErrors.clear();
    bool isValid = true;

    // Applicant name validation with isEmpty check only
    if (applicantNameController.text.trim().isEmpty) {
      validationErrors['applicantName'] = 'Applicant name is required';
      isValid = false;
    }

    // Applicant address validation
    _validateApplicantAddressFields(applicantAddressData);
    if (applicantAddressValidationErrors.isNotEmpty) {
      validationErrors['applicantAddress'] = 'Please complete the applicant address details';
      isValid = false;
    }

    // Court name validation with isEmpty check only
    if (courtNameController.text.trim().isEmpty) {
      validationErrors['courtName'] = 'Court name is required';
      isValid = false;
    }

    // Court address validation with isEmpty check only
    if (courtAddressController.text.trim().isEmpty) {
      validationErrors['courtAddress'] = 'Court address is required';
      isValid = false;
    }

    // Court order number validation with isEmpty check only
    if (courtOrderNumberController.text.trim().isEmpty) {
      validationErrors['courtOrderNumber'] = 'Court order number is required';
      isValid = false;
    }

    // Court allotment date validation with isEmpty check
    if (courtAllotmentDateController.text.trim().isEmpty || courtAllotmentDate.value == null) {
      validationErrors['courtAllotmentDate'] = 'Court allotment date is required';
      isValid = false;
    }

    // Claim number and year validation with isEmpty check only
    if (claimNumberYearController.text.trim().isEmpty) {
      validationErrors['claimNumberYear'] = 'Claim number and year is required';
      isValid = false;
    }

    // Court order files validation with isEmpty check
    if (courtOrderFiles.isEmpty) {
      validationErrors['courtOrderFiles'] = 'Court allocation order document is required';
      isValid = false;
    }

    // Special order comments validation with isEmpty check only
    if (specialOrderCommentsController.text.trim().isEmpty) {
      validationErrors['specialOrderComments'] = 'Special order or comments are required';
      isValid = false;
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

    // Specific field errors
      case 'applicantName':
        return validationErrors['applicantName'] ?? 'Applicant name is required';
      case 'applicantAddress':
        return validationErrors['applicantAddress'] ?? 'Applicant address is required';
      case 'courtName':
        return validationErrors['courtName'] ?? 'Court name is required';
      case 'courtAddress':
        return validationErrors['courtAddress'] ?? 'Court address is required';
      case 'courtOrderNumber':
        return validationErrors['courtOrderNumber'] ?? 'Court order number is required';
      case 'courtAllotmentDate':
        return validationErrors['courtAllotmentDate'] ?? 'Court allotment date is required';
      case 'claimNumberYear':
        return validationErrors['claimNumberYear'] ?? 'Claim number and year is required';
      case 'courtOrderFiles':
        return validationErrors['courtOrderFiles'] ?? 'Court order document is required';
      case 'specialOrderComments':
        return validationErrors['specialOrderComments'] ?? 'Special order or comments are required';

      default:
        return validationErrors[field] ?? 'This field is required';
    }
  }

  // NEW: Government survey validation errors
  String _getGovernmentSurveyError() {
    if (applicantNameController.text.trim().isEmpty) {
      return 'Applicant name is required';
    }

    return 'Please complete government survey information';
  }

  // Enhanced error messages with isEmpty validation
  String _getCalculationError() {
    // Return first validation error found with specific message
    if (validationErrors.isNotEmpty) {
      return validationErrors.values.first;
    }

    return 'Please fill all required fields';
  }

  // NEW: Get specific field error
  String getSpecificFieldError(String fieldType) {
    switch (fieldType) {
      case 'applicantName':
        if (applicantNameController.text.trim().isEmpty) {
          return 'Applicant name is required';
        }
        break;
      case 'applicantAddress':
        if (applicantAddressValidationErrors.isNotEmpty) {
          return 'Please complete the applicant address details';
        }
        break;
      case 'courtName':
        if (courtNameController.text.trim().isEmpty) {
          return 'Court name is required';
        }
        break;
      case 'courtAddress':
        if (courtAddressController.text.trim().isEmpty) {
          return 'Court address is required';
        }
        break;
      case 'courtOrderNumber':
        if (courtOrderNumberController.text.trim().isEmpty) {
          return 'Court order number is required';
        }
        break;
      case 'courtAllotmentDate':
        if (courtAllotmentDateController.text.trim().isEmpty || courtAllotmentDate.value == null) {
          return 'Court allotment date is required';
        }
        break;
      case 'claimNumberYear':
        if (claimNumberYearController.text.trim().isEmpty) {
          return 'Claim number and year is required';
        }
        break;
      case 'courtOrderFiles':
        if (courtOrderFiles.isEmpty) {
          return 'Court allocation order document is required';
        }
        break;
      case 'specialOrderComments':
        if (specialOrderCommentsController.text.trim().isEmpty) {
          return 'Special order or comments are required';
        }
        break;
    }
    return '';
  }

  // NEW: Check if specific field has validation error
  bool hasSpecificFieldError(String fieldType) {
    return getSpecificFieldError(fieldType).isNotEmpty;
  }

  // Step Data Mixin Implementation
  @override
  Map<String, dynamic> getStepData() {
    return {
      'applicantName': applicantNameController.text.trim(),
      'applicantAddress': getFormattedApplicantAddress(),
      'applicantAddressDetails': Map<String, String>.from(applicantAddressData),
      'courtName': courtNameController.text.trim(),
      'courtAddress': courtAddressController.text.trim(),
      'courtOrderNumber': courtOrderNumberController.text.trim(),
      'courtAllotmentDate': courtAllotmentDateController.text.trim(),
      'courtAllotmentDateValue': courtAllotmentDate.value?.toIso8601String(),
      'claimNumberYear': claimNumberYearController.text.trim(),
      'courtOrderFiles': courtOrderFiles.toList(),
      'specialOrderComments': specialOrderCommentsController.text.trim(),
      'stepCompleted': isStepCompleted(['calculation']),
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  // Helper Methods
  void clearAllFields() {
    applicantNameController.clear();
    clearApplicantAddressFields();
    courtNameController.clear();
    courtAddressController.clear();
    courtOrderNumberController.clear();
    courtAllotmentDateController.clear();
    claimNumberYearController.clear();
    specialOrderCommentsController.clear();
    courtOrderFiles.clear();
    courtAllotmentDate.value = null;
    validationErrors.clear();
  }

  // Load data from saved state
  void loadStepData(Map<String, dynamic> data) {
    applicantNameController.text = (data['applicantName'] ?? '').toString().trim();
    courtNameController.text = (data['courtName'] ?? '').toString().trim();
    courtAddressController.text = (data['courtAddress'] ?? '').toString().trim();
    courtOrderNumberController.text = (data['courtOrderNumber'] ?? '').toString().trim();
    courtAllotmentDateController.text = (data['courtAllotmentDate'] ?? '').toString().trim();
    claimNumberYearController.text = (data['claimNumberYear'] ?? '').toString().trim();
    specialOrderCommentsController.text = (data['specialOrderComments'] ?? '').toString().trim();

    if (data['courtOrderFiles'] != null) {
      courtOrderFiles.assignAll(List<String>.from(data['courtOrderFiles']));
    }

    if (data['courtAllotmentDateValue'] != null) {
      try {
        courtAllotmentDate.value = DateTime.parse(data['courtAllotmentDateValue']);
      } catch (e) {
        print('Error parsing date: $e');
      }
    }

    // Load applicant address data
    if (data['applicantAddressDetails'] != null) {
      final addressDetails =
      Map<String, String>.from(data['applicantAddressDetails']);
      updateApplicantAddress(addressDetails);
    } else if (data['applicantAddress'] != null) {
      applicantAddressController.text = data['applicantAddress'];
    }
  }
}
