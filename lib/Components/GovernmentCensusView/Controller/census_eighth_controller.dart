import 'package:get/get.dart';
import 'dart:io';
import '../Controller/main_controller.dart';

class CensusEighthController extends GetxController with StepValidationMixin, StepDataMixin {
  // Identity Card
  final selectedIdentityType = ''.obs;
  final identityCardFiles = <String>[].obs;

  // Document Files
  final sevenTwelveFiles = <String>[].obs;
  final noteFiles = <String>[].obs;
  final partitionFiles = <String>[].obs;
  final schemeSheetFiles = <String>[].obs;
  final oldCensusMapFiles = <String>[].obs;
  final demarcationCertificateFiles = <String>[].obs;
  final adhikarPatra = <String>[].obs;
  final utaraAkharband = <String>[].obs;
  final otherDocument = <String>[].obs;

  // Loading states
  final isUploading = false.obs;
  final uploadProgress = 0.0.obs;

  // Validation states
  final validationErrors = <String, String>{}.obs;

  // Identity card options
  final List<String> identityCardOptions = [
    'Aadhar Card',
    'Voter Card',
    'PAN Card',
  ];

  @override
  void onInit() {
    super.onInit();
    initializeValidation();
  }

  void initializeValidation() {
    validationErrors.clear();
  }

  // Identity Type Selection
  void updateSelectedIdentityType(String? value) {
    if (value != null) {
      selectedIdentityType.value = value;
      validationErrors.remove('identityType');

      // Clear previous identity card files if changing type
      if (identityCardFiles.isNotEmpty) {
        identityCardFiles.clear();
      }
    }
  }

  //------------------------Validation------------------------//
  @override
  bool validateCurrentSubStep(String field) {
    switch (field) {
      case 'documents':
        return _validateDocuments();
      case 'government_survey':
        return _validateGovernmentSurveyFields();
      default:
        return true;
    }
  }

  // NEW: Validate government survey fields
  bool _validateGovernmentSurveyFields() {
    validationErrors.clear();

    // Basic validation for government survey
    if (selectedIdentityType.value.trim().isEmpty) {
      validationErrors['identityType'] = 'Please select identity card type';
      return false;
    }

    return true;
  }

  // Enhanced validation with isEmpty checks
  bool _validateDocuments() {
    validationErrors.clear();
    bool isValid = true;

    // Identity card validation with isEmpty check
    if (selectedIdentityType.value.trim().isEmpty) {
      validationErrors['identityType'] = 'Please select identity card type';
      isValid = false;
    }

    if (identityCardFiles.isEmpty) {
      validationErrors['identityCard'] = 'Please upload identity card document';
      isValid = false;
    }

    // Required documents validation with isEmpty checks
    // if (sevenTwelveFiles.isEmpty) {
    //   validationErrors['sevenTwelve'] = 'Please upload Latest 7/12 Of The 3 Month document';
    //   isValid = false;
    // }

    // if (noteFiles.isEmpty) {
    //   validationErrors['note'] = 'Please upload Note document';
    //   isValid = false;
    // }
    //
    // if (partitionFiles.isEmpty) {
    //   validationErrors['partition'] = 'Please upload Partition document';
    //   isValid = false;
    // }

    // if (schemeSheetFiles.isEmpty) {
    //   validationErrors['schemeSheet'] = 'Please upload Scheme Sheet document';
    //   isValid = false;
    // }
    //
    // if (oldCensusMapFiles.isEmpty) {
    //   validationErrors['oldCensusMap'] = 'Please upload Old census map';
    //   isValid = false;
    // }
    //
    // if (demarcationCertificateFiles.isEmpty) {
    //   validationErrors['demarcationCertificate'] = 'Please upload Demarcation certificate';
    //   isValid = false;
    // }
    //
    // if (adhikarPatra.isEmpty) {
    //   validationErrors['adhikarPatra'] = 'Please upload Adhikar Patra document';
    //   isValid = false;
    // }
    //
    // if (utaraAkharband.isEmpty) {
    //   validationErrors['utaraAkharband'] = 'Please upload Utara Akharband document';
    //   isValid = false;
    // }

    // Note: otherDocument is optional, so no validation required

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
      case 'documents':
      // Return first validation error found with specific message
        if (validationErrors.isNotEmpty) {
          return validationErrors.values.first;
        }
        return 'Please upload all required documents';

      case 'government_survey':
        return _getGovernmentSurveyError();

    // Return specific field errors
      case 'identityType':
        return validationErrors['identityType'] ?? 'Please select identity card type';
      case 'identityCard':
        return validationErrors['identityCard'] ?? 'Please upload identity card document';
      case 'sevenTwelve':
        return validationErrors['sevenTwelve'] ?? 'Please upload Latest 7/12 document';
      case 'note':
        return validationErrors['note'] ?? 'Please upload Note document';
      case 'partition':
        return validationErrors['partition'] ?? 'Please upload Partition document';
      case 'schemeSheet':
        return validationErrors['schemeSheet'] ?? 'Please upload Scheme Sheet document';
      case 'oldCensusMap':
        return validationErrors['oldCensusMap'] ?? 'Please upload Old census map';
      case 'demarcationCertificate':
        return validationErrors['demarcationCertificate'] ?? 'Please upload Demarcation certificate';
      case 'adhikarPatra':
        return validationErrors['adhikarPatra'] ?? 'Please upload Adhikar Patra document';
      case 'utaraAkharband':
        return validationErrors['utaraAkharband'] ?? 'Please upload Utara Akharband document';

      default:
        return validationErrors[field] ?? 'This field is required';
    }
  }

  // NEW: Government survey validation errors
  String _getGovernmentSurveyError() {
    if (selectedIdentityType.value.trim().isEmpty) {
      return 'Please select identity card type';
    }

    return 'Please complete government survey information';
  }

  // NEW: Get specific validation error for a document type
  String getDocumentError(String documentType) {
    return validationErrors[documentType] ?? '';
  }

  // NEW: Check if a specific document has validation error
  bool hasDocumentError(String documentType) {
    return validationErrors.containsKey(documentType);
  }

  @override
  Map<String, dynamic> getStepData() {
    return {
      'identityCardType': selectedIdentityType.value.trim(),
      'identityCardFiles': identityCardFiles.toList(),
      'sevenTwelveFiles': sevenTwelveFiles.toList(),
      'noteFiles': noteFiles.toList(),
      'partitionFiles': partitionFiles.toList(),
      'schemeSheetFiles': schemeSheetFiles.toList(),
      'oldCensusMapFiles': oldCensusMapFiles.toList(),
      'demarcationCertificateFiles': demarcationCertificateFiles.toList(),
      'adhikarPatraFiles': adhikarPatra.toList(),
      'utaraAkharbandFiles': utaraAkharband.toList(),
      'otherDocumentFiles': otherDocument.toList(),
      'isStepCompleted': _validateDocuments(),
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  // Check if all required documents are uploaded
  bool get areAllDocumentsUploaded {
    return selectedIdentityType.value.trim().isNotEmpty &&
        identityCardFiles.isNotEmpty &&
        sevenTwelveFiles.isNotEmpty &&
        noteFiles.isNotEmpty &&
        partitionFiles.isNotEmpty &&
        schemeSheetFiles.isNotEmpty &&
        oldCensusMapFiles.isNotEmpty &&
        demarcationCertificateFiles.isNotEmpty &&
        adhikarPatra.isNotEmpty &&
        utaraAkharband.isNotEmpty;
  }

  // Get upload progress for UI
  String get uploadProgressText {
    int uploadedCount = 0;
    int totalRequired = 9; // Updated total including new documents

    if (selectedIdentityType.value.trim().isNotEmpty && identityCardFiles.isNotEmpty) uploadedCount++;
    if (sevenTwelveFiles.isNotEmpty) uploadedCount++;
    if (noteFiles.isNotEmpty) uploadedCount++;
    if (partitionFiles.isNotEmpty) uploadedCount++;
    if (schemeSheetFiles.isNotEmpty) uploadedCount++;
    if (oldCensusMapFiles.isNotEmpty) uploadedCount++;
    if (demarcationCertificateFiles.isNotEmpty) uploadedCount++;
    if (adhikarPatra.isNotEmpty) uploadedCount++;
    if (utaraAkharband.isNotEmpty) uploadedCount++;

    return '$uploadedCount / $totalRequired documents uploaded';
  }

  // Helper methods to get file names for display
  List<String> get identityCardFileNames => identityCardFiles.map((filePath) => filePath.split('/').last).toList();
  List<String> get sevenTwelveFileNames => sevenTwelveFiles.map((filePath) => filePath.split('/').last).toList();
  List<String> get noteFileNames => noteFiles.map((filePath) => filePath.split('/').last).toList();
  List<String> get partitionFileNames => partitionFiles.map((filePath) => filePath.split('/').last).toList();
  List<String> get schemeSheetFileNames => schemeSheetFiles.map((filePath) => filePath.split('/').last).toList();
  List<String> get oldCensusMapFileNames => oldCensusMapFiles.map((filePath) => filePath.split('/').last).toList();
  List<String> get demarcationCertificateFileNames => demarcationCertificateFiles.map((filePath) => filePath.split('/').last).toList();
  List<String> get adhikarPatraFileNames => adhikarPatra.map((filePath) => filePath.split('/').last).toList();
  List<String> get utaraAkharbandFileNames => utaraAkharband.map((filePath) => filePath.split('/').last).toList();
  List<String> get otherDocumentFileNames => otherDocument.map((filePath) => filePath.split('/').last).toList();

  // Helper methods to convert between File and String if needed elsewhere
  List<File> getFilesFromPaths(List<String> paths) {
    return paths.map((path) => File(path)).toList();
  }

  List<String> getPathsFromFiles(List<File> files) {
    return files.map((file) => file.path).toList();
  }

  // NEW: Load step data
  void loadStepData(Map<String, dynamic> data) {
    selectedIdentityType.value = data['identityCardType'] ?? '';
    identityCardFiles.assignAll(List<String>.from(data['identityCardFiles'] ?? []));
    sevenTwelveFiles.assignAll(List<String>.from(data['sevenTwelveFiles'] ?? []));
    noteFiles.assignAll(List<String>.from(data['noteFiles'] ?? []));
    partitionFiles.assignAll(List<String>.from(data['partitionFiles'] ?? []));
    schemeSheetFiles.assignAll(List<String>.from(data['schemeSheetFiles'] ?? []));
    oldCensusMapFiles.assignAll(List<String>.from(data['oldCensusMapFiles'] ?? []));
    demarcationCertificateFiles.assignAll(List<String>.from(data['demarcationCertificateFiles'] ?? []));
    adhikarPatra.assignAll(List<String>.from(data['adhikarPatraFiles'] ?? []));
    utaraAkharband.assignAll(List<String>.from(data['utaraAkharbandFiles'] ?? []));
    otherDocument.assignAll(List<String>.from(data['otherDocumentFiles'] ?? []));
  }

  // NEW: Clear all validation errors
  void clearValidationErrors() {
    validationErrors.clear();
  }
}
