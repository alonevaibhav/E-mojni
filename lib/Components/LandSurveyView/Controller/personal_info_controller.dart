import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'main_controller.dart';
import '../../Widget/address.dart';

class PersonalInfoController extends GetxController with StepValidationMixin, StepDataMixin {
  // Form Controllers
  final applicantNameController = TextEditingController();
  final applicantAddressController = TextEditingController();
  final applicantPhoneController = TextEditingController();
  final relationshipController = TextEditingController();
  final relationshipWithApplicantController = TextEditingController();
  final poaRegistrationNumberController = TextEditingController();
  final poaRegistrationDateController = TextEditingController();
  final poaIssuerNameController = TextEditingController();
  final poaHolderNameController = TextEditingController();
  final poaHolderAddressController = TextEditingController();
  final poaDocument = <String>[].obs;

  // Observable boolean values for questions
  final isHolderThemselves = Rxn<bool>();
  final hasAuthorityOnBehalf = Rxn<bool>();
  final hasBeenCountedBefore = Rxn<bool>();

  @override
  void onClose() {
    // Dispose all controllers
    applicantNameController.dispose();
    applicantAddressController.dispose();
    applicantPhoneController.dispose();
    relationshipController.dispose();
    relationshipWithApplicantController.dispose();
    poaRegistrationNumberController.dispose();
    poaRegistrationDateController.dispose();
    poaIssuerNameController.dispose();
    poaHolderNameController.dispose();
    poaHolderAddressController.dispose();
    // Dispose address controllers
    applicantAddressControllers.values.forEach((controller) => controller.dispose());
    super.onClose();
  }

  // Reset methods for dependent fields
  void resetAuthorityFields() {
    hasAuthorityOnBehalf.value = null;
    applicantPhoneController.clear();
    relationshipController.clear();
    relationshipWithApplicantController.clear();
    clearPOAFields();
  }

  void clearPOAFields() {
    poaRegistrationNumberController.clear();
    poaRegistrationDateController.clear();
    poaIssuerNameController.clear();
    poaHolderNameController.clear();
    poaHolderAddressController.clear();
    poaDocument.clear();
  }

  // Handle holder themselves selection
  void updateHolderThemselves(bool? value) {
    isHolderThemselves.value = value;
    if (value == true) {
      clearPOAFields(); // Clear POA fields when user is holder themselves
    }
  }

  // Handle authority on behalf selection (keeping for backward compatibility)
  void updateAuthorityOnBehalf(bool? value) {
    hasAuthorityOnBehalf.value = value;
    if (value != true) {
      clearPOAFields();
    }
  }

  // Handle enumeration check
  void updateEnumerationCheck(bool? value) {
    hasBeenCountedBefore.value = value;
  }

  //------------------------Address------------------------//
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

  // Address validation errors
  final applicantAddressValidationErrors = <String, String>{}.obs;

  // Address controllers for the popup
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

  // Address popup functionality
  String getFormattedApplicantAddress() {
    final parts = <String> [];
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

  // Check if detailed address is available
  bool hasDetailedApplicantAddress() {
    return applicantAddressData.isNotEmpty &&
        (applicantAddressData['address']?.isNotEmpty == true ||
            applicantAddressData['village']?.isNotEmpty == true);
  }

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
    Get.back();
  }

  void updateApplicantAddress(Map<String, String> newAddressData) {
    applicantAddressData.assignAll(newAddressData);
    applicantAddressController.text = getFormattedApplicantAddress();
    applicantAddressValidationErrors.clear();
    _validateApplicantAddressFields(newAddressData);
    update();
  }

  void _validateApplicantAddressFields(Map<String, String> addressData) {
    applicantAddressValidationErrors.clear();

    // Check if address field is not empty
    if (addressData['address']?.trim().isEmpty ?? true) {
      applicantAddressValidationErrors['address'] = 'Address is required';
    }

    // Check if pincode field is not empty
    if (addressData['pincode']?.trim().isEmpty ?? true) {
      applicantAddressValidationErrors['pincode'] = 'Pincode is required';
    }

    // Check if village field is not empty
    if (addressData['village']?.trim().isEmpty ?? true) {
      applicantAddressValidationErrors['village'] = 'Village is required';
    }

    // Check if postOffice field is not empty
    if (addressData['postOffice']?.trim().isEmpty ?? true) {
      applicantAddressValidationErrors['postOffice'] = 'Post Office is required';
    }
  }

  //------------------------Validation------------------------//
  @override
  bool validateCurrentSubStep(String field) {
    switch (field) {
      case 'holder_verification':
      // Basic fields validation with isNotEmpty check
        if (applicantNameController.text.trim().isEmpty || applicantNameController.text.trim().length < 3) {
          return false;
        }

        // Address validation
        _validateApplicantAddressFields(applicantAddressData);
        if (applicantAddressValidationErrors.isNotEmpty) return false;

        // Holder verification question
        if (isHolderThemselves.value == null) return false;

        // If not holder themselves, validate POA fields directly (no authority question in view)
        if (isHolderThemselves.value == false) {
          return _validatePOAFields();
        }

        return true;

      case 'enumeration_check':
        return hasBeenCountedBefore.value != null;

      default:
        return true;
    }
  }

  bool _validatePOAFields() {
    // Validate all POA fields with isNotEmpty checks
    // Registration Number validation
    if (poaRegistrationNumberController.text.trim().isEmpty ||
        poaRegistrationNumberController.text.trim().length < 3) {
      return false;
    }

    // Registration Date validation
    if (poaRegistrationDateController.text.trim().isEmpty) {
      return false;
    }

    // Issuer Name validation
    if (poaIssuerNameController.text.trim().isEmpty ||
        poaIssuerNameController.text.trim().length < 2) {
      return false;
    }

    // Holder Name validation
    if (poaHolderNameController.text.trim().isEmpty ||
        poaHolderNameController.text.trim().length < 2) {
      return false;
    }

    // Holder Address validation
    if (poaHolderAddressController.text.trim().isEmpty ||
        poaHolderAddressController.text.trim().length < 5) {
      return false;
    }

    // Document validation
    if (poaDocument.isEmpty) {
      return false;
    }

    return true;
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
      case 'holder_verification':
      // Applicant name validation with isNotEmpty
        if (applicantNameController.text.trim().isEmpty) {
          return 'Applicant name is required';
        }
        if (applicantNameController.text.trim().length < 3) {
          return 'Applicant name must be at least 3 characters';
        }

        // Address validation
        if (applicantAddressValidationErrors.isNotEmpty) {
          return 'Please complete the applicant address';
        }

        // Holder verification question
        if (isHolderThemselves.value == null) {
          return 'Please select if you are the holder';
        }

        // Direct POA validation when not holder themselves (no authority question)
        if (isHolderThemselves.value == false) {
          return _getPOAValidationError();
        }

        return 'Please complete holder verification';

      case 'enumeration_check':
        return 'Please select if this has been counted before';

      default:
        return 'This field is required';
    }
  }

  String _getPOAValidationError() {
    // Registration Number validation with isNotEmpty
    if (poaRegistrationNumberController.text.trim().isEmpty) {
      return 'Registration number is required';
    }
    if (poaRegistrationNumberController.text.trim().length < 3) {
      return 'Registration number must be at least 3 characters';
    }

    // Registration Date validation with isNotEmpty
    if (poaRegistrationDateController.text.trim().isEmpty) {
      return 'Registration date is required';
    }

    // Issuer Name validation with isNotEmpty
    if (poaIssuerNameController.text.trim().isEmpty) {
      return 'Issuer name is required';
    }
    if (poaIssuerNameController.text.trim().length < 2) {
      return 'Issuer name must be at least 2 characters';
    }

    // Holder Name validation with isNotEmpty
    if (poaHolderNameController.text.trim().isEmpty) {
      return 'Holder name is required';
    }
    if (poaHolderNameController.text.trim().length < 2) {
      return 'Holder name must be at least 2 characters';
    }

    // Holder Address validation with isNotEmpty
    if (poaHolderAddressController.text.trim().isEmpty) {
      return 'Holder address is required';
    }
    if (poaHolderAddressController.text.trim().length < 5) {
      return 'Holder address must be at least 5 characters';
    }

    // Document validation with isNotEmpty
    if (poaDocument.isEmpty) {
      return 'POA document is required';
    }

    return 'Please complete all Power of Attorney fields';
  }

  //------------------------Data------------------------//
  @override
  Map<String, dynamic> getStepData() {
    return {
      'personal_info': {
        'is_holder_themselves': isHolderThemselves.value,
        'has_authority_on_behalf': hasAuthorityOnBehalf.value,
        'has_been_counted_before': hasBeenCountedBefore.value,
        'applicant_name': applicantNameController.text.trim(),
        'applicant_address': getFormattedApplicantAddress(),
        'applicant_address_details': Map<String, String>.from(applicantAddressData),
        'applicant_phone': applicantPhoneController.text.trim(),
        'relationship': relationshipController.text.trim(),
        'relationship_with_applicant': relationshipWithApplicantController.text.trim(),
        'poa_registration_number': poaRegistrationNumberController.text.trim(),
        'poa_registration_date': poaRegistrationDateController.text.trim(),
        'poa_issuer_name': poaIssuerNameController.text.trim(),
        'poa_holder_name': poaHolderNameController.text.trim(),
        'poa_holder_address': poaHolderAddressController.text.trim(),
        'poa_document': poaDocument.toList(),
      }
    };
  }

  //------------------------Utilities------------------------//
  bool get shouldShowPOAFields {
    // Simplified - show POA fields directly when not holder themselves
    return isHolderThemselves.value == false;
  }

  bool get shouldShowAuthorityQuestion {
    return isHolderThemselves.value == false;
  }
}
