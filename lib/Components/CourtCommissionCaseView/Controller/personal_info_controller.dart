import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../CourtCommissionCaseView/Controller/main_controller.dart';
import '../../Widget/address.dart';

class PersonalInfoController extends GetxController with StepValidationMixin, StepDataMixin {
  // Text Controllers
  final courtNameController = TextEditingController();
  final courtAddressController = TextEditingController();
  final commissionOrderNoController = TextEditingController();
  final commissionDateController = TextEditingController();
  final civilClaimController = TextEditingController();
  final issuingOfficeController = TextEditingController();
  final applicantNameController = TextEditingController();
  final applicantAddressController = TextEditingController(); // Keep for backward compatibility

  // Date selection
  final selectedCommissionDate = Rxn<DateTime>();

  // File upload
  final commissionOrderFiles = <String>[].obs;

  // Validation states
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
    _initializeValidation();
  }

  @override
  void onClose() {
    courtNameController.dispose();
    courtAddressController.dispose();
    commissionOrderNoController.dispose();
    commissionDateController.dispose();
    civilClaimController.dispose();
    issuingOfficeController.dispose();
    applicantNameController.dispose();
    applicantAddressController.dispose();

    // Dispose address controllers
    applicantAddressControllers.values.forEach((controller) => controller.dispose());

    super.onClose();
  }

  void _initializeValidation() {
    // Initialize validation states
    validationErrors.clear();
  }

  // Update commission date
  void updateCommissionDate(DateTime date) {
    selectedCommissionDate.value = date;
    commissionDateController.text = _formatDate(date);
    _clearFieldError('commission_date');
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  }

  void _clearFieldError(String field) {
    validationErrors.remove(field);
  }

  //------------------------Applicant Address Methods ------------------------//

  // Applicant address formatting method
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
    applicantAddressControllers['plotNoController']!.text = applicantAddressData['plotNo'] ?? '';
    applicantAddressControllers['addressController']!.text = applicantAddressData['address'] ?? '';
    applicantAddressControllers['mobileNumberController']!.text = applicantAddressData['mobileNumber'] ?? '';
    applicantAddressControllers['emailController']!.text = applicantAddressData['email'] ?? '';
    applicantAddressControllers['pincodeController']!.text = applicantAddressData['pincode'] ?? '';
    applicantAddressControllers['districtController']!.text = applicantAddressData['district'] ?? '';
    applicantAddressControllers['villageController']!.text = applicantAddressData['village'] ?? '';
    applicantAddressControllers['postOfficeController']!.text = applicantAddressData['postOffice'] ?? '';

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
      'mobileNumber': applicantAddressControllers['mobileNumberController']!.text,
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

    // Validate address fields
    _validateApplicantAddressFields(newAddressData);

    update(); // Trigger UI update
  }

  // Validate applicant address fields with isEmpty checks
  void _validateApplicantAddressFields(Map<String, String> addressData) {
    if (addressData['address']?.trim().isEmpty ?? true) {
      applicantAddressValidationErrors['address'] = 'Applicant address is required';
    }
    if (addressData['pincode']?.trim().isEmpty ?? true) {
      applicantAddressValidationErrors['pincode'] = 'Pincode is required';
    }
    if (addressData['village']?.trim().isEmpty ?? true) {
      applicantAddressValidationErrors['village'] = 'Village is required';
    }
    if (addressData['postOffice']?.trim().isEmpty ?? true) {
      applicantAddressValidationErrors['postOffice'] = 'Post Office is required';
    }
  }

  // Clear applicant address fields
  void clearApplicantAddressFields() {
    applicantAddressData.clear();
    applicantAddressValidationErrors.clear();
    applicantAddressControllers.values.forEach((controller) => controller.clear());
    applicantAddressController.clear();
  }

  //------------------------Validation------------------------//
  @override
  bool validateCurrentSubStep(String field) {
    switch (field) {
      case 'court_commission_details':
        return _validateCourtCommissionDetails();
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

    // Basic validation for government survey
    if (courtNameController.text.trim().isEmpty) {
      validationErrors['court_name'] = 'Court name is required';
      isValid = false;
    }

    return isValid;
  }

  // Enhanced validation with isEmpty checks only
  bool _validateCourtCommissionDetails() {
    validationErrors.clear();
    bool isValid = true;

    // Court name validation with isEmpty check only
    if (courtNameController.text.trim().isEmpty) {
      validationErrors['court_name'] = 'Court name is required';
      isValid = false;
    }

    // Court address validation with isEmpty check only
    if (courtAddressController.text.trim().isEmpty) {
      validationErrors['court_address'] = 'Court address is required';
      isValid = false;
    }

    // Commission order number validation with isEmpty check only
    if (commissionOrderNoController.text.trim().isEmpty) {
      validationErrors['commission_order_no'] = 'Commission order number is required';
      isValid = false;
    }

    // Commission date validation with isEmpty check
    if (selectedCommissionDate.value == null) {
      validationErrors['commission_date'] = 'Commission date is required';
      isValid = false;
    }

    // Civil claim validation with isEmpty check only
    if (civilClaimController.text.trim().isEmpty) {
      validationErrors['civil_claim'] = 'Civil claim details are required';
      isValid = false;
    }

    // Issuing office validation with isEmpty check only
    if (issuingOfficeController.text.trim().isEmpty) {
      validationErrors['issuing_office'] = 'Issuing office details are required';
      isValid = false;
    }

    // Applicant name validation with isEmpty check only
    if (applicantNameController.text.trim().isEmpty) {
      validationErrors['applicant_name'] = 'Applicant name is required';
      isValid = false;
    }

    // Applicant address validation using new validation
    _validateApplicantAddressFields(applicantAddressData);
    if (applicantAddressValidationErrors.isNotEmpty) {
      validationErrors['applicant_address'] = 'Please complete the applicant address details';
      isValid = false;
    }

    // File upload validation with isEmpty check
    if (commissionOrderFiles.isEmpty) {
      validationErrors['commission_order_file'] = 'Commission order document is required';
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
      case 'court_commission_details':
        return _getCourtCommissionDetailsError();
      case 'government_survey':
        return _getGovernmentSurveyError();

    // Specific field errors
      case 'court_name':
        return validationErrors['court_name'] ?? 'Court name is required';
      case 'court_address':
        return validationErrors['court_address'] ?? 'Court address is required';
      case 'commission_order_no':
        return validationErrors['commission_order_no'] ?? 'Commission order number is required';
      case 'commission_date':
        return validationErrors['commission_date'] ?? 'Commission date is required';
      case 'civil_claim':
        return validationErrors['civil_claim'] ?? 'Civil claim details are required';
      case 'issuing_office':
        return validationErrors['issuing_office'] ?? 'Issuing office details are required';
      case 'applicant_name':
        return validationErrors['applicant_name'] ?? 'Applicant name is required';
      case 'applicant_address':
        return validationErrors['applicant_address'] ?? 'Applicant address is required';
      case 'commission_order_file':
        return validationErrors['commission_order_file'] ?? 'Commission order document is required';

      default:
        return validationErrors[field] ?? 'This field is required';
    }
  }

  // NEW: Government survey validation errors
  String _getGovernmentSurveyError() {
    if (courtNameController.text.trim().isEmpty) {
      return 'Court name is required';
    }

    return 'Please complete government survey information';
  }

  // Enhanced error messages with isEmpty validation
  String _getCourtCommissionDetailsError() {
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
      case 'commissionOrderNo':
        if (commissionOrderNoController.text.trim().isEmpty) {
          return 'Commission order number is required';
        }
        break;
      case 'commissionDate':
        if (selectedCommissionDate.value == null) {
          return 'Commission date is required';
        }
        break;
      case 'civilClaim':
        if (civilClaimController.text.trim().isEmpty) {
          return 'Civil claim details are required';
        }
        break;
      case 'issuingOffice':
        if (issuingOfficeController.text.trim().isEmpty) {
          return 'Issuing office details are required';
        }
        break;

      case 'commissionOrderFile':
        if (commissionOrderFiles.isEmpty) {
          return 'Commission order document is required';
        }
        break;
    }
    return '';
  }

  // NEW: Check if specific field has validation error
  bool hasSpecificFieldError(String fieldType) {
    return getSpecificFieldError(fieldType).isNotEmpty;
  }

  @override
  Map<String, dynamic> getStepData() {
    return {
      'court_name': courtNameController.text.trim(),
      'court_address': courtAddressController.text.trim(),
      'commission_order_no': commissionOrderNoController.text.trim(),
      'commission_date': selectedCommissionDate.value?.toIso8601String(),
      'civil_claim': civilClaimController.text.trim(),
      'issuing_office': issuingOfficeController.text.trim(),
      'applicant_name': applicantNameController.text.trim(),
      'applicant_address': getFormattedApplicantAddress(),
      'applicant_address_details': Map<String, String>.from(applicantAddressData),
      'commission_order_files': commissionOrderFiles.toList(),
      'is_step_completed': _validateCourtCommissionDetails(),
      'step_completed_at': DateTime.now().toIso8601String(),
    };
  }

  // Helper methods for UI (kept for backward compatibility)
  String? getFieldValidationError(String field) {
    return validationErrors[field];
  }

  bool hasFieldError(String field) {
    return validationErrors.containsKey(field);
  }

  // Utility methods
  void clearAllFields() {
    courtNameController.clear();
    courtAddressController.clear();
    commissionOrderNoController.clear();
    commissionDateController.clear();
    civilClaimController.clear();
    issuingOfficeController.clear();
    applicantNameController.clear();
    clearApplicantAddressFields();
    commissionOrderFiles.clear();
    selectedCommissionDate.value = null;
    validationErrors.clear();
  }

  void loadStepData(Map<String, dynamic> data) {
    courtNameController.text = (data['court_name'] ?? '').toString().trim();
    courtAddressController.text = (data['court_address'] ?? '').toString().trim();
    commissionOrderNoController.text = (data['commission_order_no'] ?? '').toString().trim();
    civilClaimController.text = (data['civil_claim'] ?? '').toString().trim();
    issuingOfficeController.text = (data['issuing_office'] ?? '').toString().trim();
    applicantNameController.text = (data['applicant_name'] ?? '').toString().trim();

    // Load applicant address data
    if (data['applicant_address_details'] != null) {
      final addressDetails = Map<String, String>.from(data['applicant_address_details']);
      updateApplicantAddress(addressDetails);
    } else if (data['applicant_address'] != null) {
      applicantAddressController.text = data['applicant_address'];
    }

    // Load commission date if exists
    if (data['commission_date'] != null) {
      try {
        selectedCommissionDate.value = DateTime.parse(data['commission_date']);
        commissionDateController.text = _formatDate(selectedCommissionDate.value!);
      } catch (e) {
        print('Error parsing date: $e');
      }
    }

    // Load files if exists
    if (data['commission_order_files'] != null) {
      commissionOrderFiles.assignAll(List<String>.from(data['commission_order_files']));
    }
  }
}
