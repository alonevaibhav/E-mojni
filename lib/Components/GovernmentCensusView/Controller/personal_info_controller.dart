import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../GovernmentCensusView/Controller/main_controller.dart';
import '../../Widget/address.dart';

class PersonalInfoController extends GetxController with StepValidationMixin, StepDataMixin {
  // Text Controllers for Government Counting
  final applicantNameController = TextEditingController();
  final applicantAddressController = TextEditingController();

  final governmentCountingOfficerController = TextEditingController();
  final governmentCountingOfficerAddressController = TextEditingController();
  final governmentCountingOrderNumberController = TextEditingController();
  final governmentCountingOrderDateController = TextEditingController();
  final countingApplicantNameController = TextEditingController();
  final countingApplicantAddressController = TextEditingController(); // Keep for backward compatibility
  final governmentCountingDetailsController = TextEditingController();

  // Date storage
  final governmentCountingOrderDate = Rxn<DateTime>();

  // File storage
  final governmentCountingOrderFiles = <String>[].obs;

  // Validation states
  final formKey = GlobalKey<FormState>();
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
    _initializeListeners();
  }

  @override
  void onClose() {
    // Dispose controllers
    governmentCountingOfficerController.dispose();
    governmentCountingOfficerAddressController.dispose();
    governmentCountingOrderNumberController.dispose();
    governmentCountingOrderDateController.dispose();
    countingApplicantNameController.dispose();
    countingApplicantAddressController.dispose();
    governmentCountingDetailsController.dispose();

    // Dispose address controllers
    applicantAddressControllers.values
        .forEach((controller) => controller.dispose());

    super.onClose();
  }

  void _initializeListeners() {
    // Add listeners if needed for real-time validation
    validationErrors.clear();
  }

  // Date update methods
  void updateGovernmentCountingOrderDate(DateTime date) {
    governmentCountingOrderDate.value = date;
    governmentCountingOrderDateController.text =
    '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';

    // Clear validation error
    validationErrors.remove('orderDate');
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
    countingApplicantAddressController.clear();
  }

  //------------------------Validation------------------------//
  @override
  bool validateCurrentSubStep(String field) {
    switch (field) {
      case 'government_counting_details':
        return _validateGovernmentCountingDetails();
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

    if (governmentCountingOfficerController.text.trim().isEmpty) {
      validationErrors['officer'] = 'Officer name is required';
      isValid = false;
    }

    return isValid;
  }

  // Enhanced validation with isEmpty checks only
  bool _validateGovernmentCountingDetails() {
    validationErrors.clear();
    bool isValid = true;

    // Officer name validation with isEmpty check only
    if (governmentCountingOfficerController.text.trim().isEmpty) {
      validationErrors['officer'] = 'Government counting officer name is required';
      isValid = false;
    }

    // Officer address validation with isEmpty check only
    if (governmentCountingOfficerAddressController.text.trim().isEmpty) {
      validationErrors['officerAddress'] = 'Officer address is required';
      isValid = false;
    }

    // Order number validation with isEmpty check only
    if (governmentCountingOrderNumberController.text.trim().isEmpty) {
      validationErrors['orderNumber'] = 'Order number is required';
      isValid = false;
    }

    // Order date validation with isEmpty check
    if (governmentCountingOrderDateController.text.trim().isEmpty) {
      validationErrors['orderDate'] = 'Order date is required';
      isValid = false;
    }

    // Government counting details validation with isEmpty check only
    if (governmentCountingDetailsController.text.trim().isEmpty) {
      validationErrors['details'] = 'Government counting details are required';
      isValid = false;
    }

    // Applicant address validation
    _validateApplicantAddressFields(applicantAddressData);
    if (applicantAddressValidationErrors.isNotEmpty) {
      validationErrors['applicantAddress'] = 'Please complete the applicant address details';
      isValid = false;
    }

    // File upload validation with isEmpty check
    if (governmentCountingOrderFiles.isEmpty) {
      validationErrors['orderFiles'] = 'Government counting order document is required';
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
      case 'government_counting_details':
        return _getGovernmentCountingDetailsError();
      case 'government_survey':
        return _getGovernmentSurveyError();

    // Specific field errors
      case 'officer':
        return validationErrors['officer'] ?? 'Officer name is required';
      case 'officerAddress':
        return validationErrors['officerAddress'] ?? 'Officer address is required';
      case 'orderNumber':
        return validationErrors['orderNumber'] ?? 'Order number is required';
      case 'orderDate':
        return validationErrors['orderDate'] ?? 'Order date is required';
      case 'details':
        return validationErrors['details'] ?? 'Government counting details are required';
      case 'applicantAddress':
        return validationErrors['applicantAddress'] ?? 'Applicant address is required';
      case 'orderFiles':
        return validationErrors['orderFiles'] ?? 'Order document is required';

      default:
        return validationErrors[field] ?? 'This field is required';
    }
  }

  // NEW: Government survey validation errors
  String _getGovernmentSurveyError() {
    if (governmentCountingOfficerController.text.trim().isEmpty) {
      return 'Government counting officer name is required';
    }

    return 'Please complete government survey information';
  }

  // Enhanced error messages with isEmpty validation
  String _getGovernmentCountingDetailsError() {
    // Return first validation error found with specific message
    if (validationErrors.isNotEmpty) {
      return validationErrors.values.first;
    }

    return 'Please complete all required fields';
  }

  // NEW: Get specific field error
  String getSpecificFieldError(String fieldType) {
    switch (fieldType) {
      case 'officer':
        if (governmentCountingOfficerController.text.trim().isEmpty) {
          return 'Government counting officer name is required';
        }
        break;
      case 'officerAddress':
        if (governmentCountingOfficerAddressController.text.trim().isEmpty) {
          return 'Officer address is required';
        }
        break;
      case 'orderNumber':
        if (governmentCountingOrderNumberController.text.trim().isEmpty) {
          return 'Order number is required';
        }
        break;
      case 'orderDate':
        if (governmentCountingOrderDateController.text.trim().isEmpty) {
          return 'Order date is required';
        }
        break;
      case 'details':
        if (governmentCountingDetailsController.text.trim().isEmpty) {
          return 'Government counting details are required';
        }
        break;
      case 'applicantAddress':
        if (applicantAddressValidationErrors.isNotEmpty) {
          return 'Please complete the applicant address details';
        }
        break;
      case 'orderFiles':
        if (governmentCountingOrderFiles.isEmpty) {
          return 'Government counting order document is required';
        }
        break;
    }
    return '';
  }

  // NEW: Check if specific field has validation error
  bool hasSpecificFieldError(String fieldType) {
    return getSpecificFieldError(fieldType).isNotEmpty;
  }

  // Data Methods (StepDataMixin implementation)
  @override
  Map<String, dynamic> getStepData() {
    return {
      'government_counting_officer':
      governmentCountingOfficerController.text.trim(),
      'government_counting_officer_address':
      governmentCountingOfficerAddressController.text.trim(),
      'government_counting_order_number':
      governmentCountingOrderNumberController.text.trim(),
      'government_counting_order_date':
      governmentCountingOrderDateController.text.trim(),
      'government_counting_order_date_object':
      governmentCountingOrderDate.value?.toIso8601String(),
      'counting_applicant_name': countingApplicantNameController.text.trim(),
      'counting_applicant_address': getFormattedApplicantAddress(),
      'counting_applicant_address_details':
      Map<String, String>.from(applicantAddressData),
      'government_counting_details':
      governmentCountingDetailsController.text.trim(),
      'government_counting_order_files': governmentCountingOrderFiles.toList(),
      'isStepCompleted': _validateGovernmentCountingDetails(),
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  // Utility Methods
  void clearForm() {
    governmentCountingOfficerController.clear();
    governmentCountingOfficerAddressController.clear();
    governmentCountingOrderNumberController.clear();
    governmentCountingOrderDateController.clear();
    countingApplicantNameController.clear();
    clearApplicantAddressFields();
    governmentCountingDetailsController.clear();
    governmentCountingOrderDate.value = null;
    governmentCountingOrderFiles.clear();
    validationErrors.clear();
  }

  void loadData(Map<String, dynamic> data) {
    governmentCountingOfficerController.text =
        (data['government_counting_officer'] ?? '').toString().trim();
    governmentCountingOfficerAddressController.text =
        (data['government_counting_officer_address'] ?? '').toString().trim();
    governmentCountingOrderNumberController.text =
        (data['government_counting_order_number'] ?? '').toString().trim();
    governmentCountingOrderDateController.text =
        (data['government_counting_order_date'] ?? '').toString().trim();
    countingApplicantNameController.text =
        (data['counting_applicant_name'] ?? '').toString().trim();
    governmentCountingDetailsController.text =
        (data['government_counting_details'] ?? '').toString().trim();

    // Load applicant address data
    if (data['counting_applicant_address_details'] != null) {
      final addressDetails =
      Map<String, String>.from(data['counting_applicant_address_details']);
      updateApplicantAddress(addressDetails);
    } else if (data['counting_applicant_address'] != null) {
      countingApplicantAddressController.text =
      data['counting_applicant_address'];
    }

    // Load date object if exists
    if (data['government_counting_order_date_object'] != null) {
      try {
        governmentCountingOrderDate.value =
            DateTime.parse(data['government_counting_order_date_object']);
      } catch (e) {
        print('Error parsing date: $e');
      }
    }

    // Load files if exists
    if (data['government_counting_order_files'] != null) {
      governmentCountingOrderFiles.assignAll(
          List<String>.from(data['government_counting_order_files']));
    }
  }
}
