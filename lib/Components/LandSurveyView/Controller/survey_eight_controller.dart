import 'dart:developer' as Developer;
import 'package:get/get.dart';
import 'dart:io';
import '../../LandSurveyView/Controller/step_three_controller.dart';
import '../Controller/main_controller.dart';

class SurveyEightController extends GetxController with StepValidationMixin, StepDataMixin {
  // Identity Card
  final selectedIdentityType = ''.obs;
  final identityCardFiles = <String>[].obs;

  // Document Files - Changed from List<File> to List<String>
  final sevenTwelveFiles = <String>[].obs;
  final noteFiles = <String>[].obs;
  final partitionFiles = <String>[].obs;
  final schemeSheetFiles = <String>[].obs;
  final oldCensusMapFiles = <String>[].obs;
  final demarcationCertificateFiles = <String>[].obs;
  final adhikarPatra = <String>[].obs;
  final otherDocument = <String>[].obs;

  // Non-agricultural specific documents
  final sakshamPradikaranAdeshFiles = <String>[].obs;
  final nakashaFiles = <String>[].obs;
  final bhandhakamParvanaFiles = <String>[].obs;
  final nonAgriculturalZoneCertificateFiles = <String>[].obs;

  // Stomach specific documents
  final pratisaKarayaycheNakshaFiles = <String>[].obs;
  final bandPhotoFiles = <String>[].obs;
  final sammatiPatraFiles = <String>[].obs;
  final stomachZoneCertificateFiles = <String>[].obs;

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

  // Check if calculation type is Non-agricultural
  bool get isNonAgricultural  {
    try {
      final calculationController = Get.find<CalculationController>(tag: 'calculation');
      bool result = calculationController.selectedCalculationType.value == 'Non-agricultural';

      Developer.log('isNonAgricultural check: ${calculationController.selectedCalculationType.value} -> $result', name: 'SurveyEightController');

      return result;
    } catch (e) {
      print('Error in isNonAgricultural: $e');
      return false;
    }
  }

  // Check if calculation type is Stomach
  bool get isStomach {
    try {
      final calculationController = Get.find<CalculationController>(tag: 'calculation');
      bool result = calculationController.selectedCalculationType.value == 'Stomach';

      Developer.log('isStomach check: ${calculationController.selectedCalculationType.value} -> $result', name: 'SurveyEightController');

      return result;
    } catch (e) {
      print('Error in isStomach: $e');
      return false;
    }
  }

  bool get isIntegrationCalculation {
    try {
      final calculationController = Get.find<CalculationController>(tag: 'calculation');
      bool result = calculationController.selectedCalculationType.value == 'Integration calculation';

      Developer.log('isIntegrationCalculation check: ${calculationController.selectedCalculationType.value} -> $result', name: 'SurveyEightController');

      return result;
    } catch (e) {
      print('Error in isIntegrationCalculation: $e');
      return false;
    }
  }

  //------------------------Validation------------------------//
  @override
  bool validateCurrentSubStep(String field) {
    switch (field) {
      case 'documents':
        return _validateDocuments();
      default:
        return true;
    }
  }

  bool _validateDocuments() {
    validationErrors.clear();
    bool isValid = true;

    // Identity card validation with isEmpty checks
    if (selectedIdentityType.value.trim().isEmpty) {
      validationErrors['identityType'] = 'Please select identity card type';
      isValid = false;
    }

    if (identityCardFiles.isEmpty) {
      validationErrors['identityCard'] = 'Please upload identity card document';
      isValid = false;
    }

    // Required documents validation with isEmpty checks
    if (sevenTwelveFiles.isEmpty) {
      validationErrors['sevenTwelve'] = 'Please upload Latest 7/12 Of The 3 Month document';
      isValid = false;
    }

    // if (noteFiles.isEmpty) {
    //   validationErrors['note'] = 'Please upload Note document';
    //   isValid = false;
    // }

    // if (partitionFiles.isEmpty) {
    //   validationErrors['partition'] = 'Please upload Partition document';
    //   isValid = false;
    // }

    if (schemeSheetFiles.isEmpty) {
      validationErrors['schemeSheet'] = 'Please upload Scheme Sheet Utara/Utara Akharband document';
      isValid = false;
    }

    if (oldCensusMapFiles.isEmpty) {
      validationErrors['oldCensusMap'] = 'Please upload Old census map';
      isValid = false;
    }

    if (demarcationCertificateFiles.isEmpty) {
      validationErrors['demarcationCertificate'] = 'Please upload Demarcation certificate';
      isValid = false;
    }

    // if (adhikarPatra.isEmpty) {
    //   validationErrors['adhikarPatra'] = 'Please upload Adhikar Patra document';
    //   isValid = false;
    // }

    // Note: otherDocument is optional, so no validation required

    // Non-agricultural specific validation with isEmpty checks
    if (isNonAgricultural) {
      if (sakshamPradikaranAdeshFiles.isEmpty) {
        validationErrors['sakshamPradikaranAdesh'] = 'Please upload Saksham Pradikaran Adesh/N/A Order document';
        isValid = false;
      }

      if (nakashaFiles.isEmpty) {
        validationErrors['nakasha'] = 'Please upload Nakasha/Layout Blueprint document';
        isValid = false;
      }

      if (nonAgriculturalZoneCertificateFiles.isEmpty) {
        validationErrors['nonAgriculturalZoneCertificate'] = 'Please upload Zone Certificate for Non-Agricultural';
        isValid = false;
      }

      if (bhandhakamParvanaFiles.isEmpty) {
        validationErrors['bhandhakamParvana'] = 'Please upload Bhandhakam Parvangi document';
        isValid = false;
      }
    }

    // Stomach specific validation with isEmpty checks
    if (isStomach) {
      if (pratisaKarayaycheNakshaFiles.isEmpty) {
        validationErrors['pratisaKarayaycheNaksha'] = 'Please upload Pratisa Karayayche Naksha document';
        isValid = false;
      }

      if (bandPhotoFiles.isEmpty) {
        validationErrors['bandPhoto'] = 'Please upload Mojni karawayacha Jagecha Photo';
        isValid = false;
      }

      if (stomachZoneCertificateFiles.isEmpty) {
        validationErrors['stomachZoneCertificate'] = 'Please upload Zone Certificate for Stomach';
        isValid = false;
      }

      if (sammatiPatraFiles.isEmpty) {
        validationErrors['sammatiPatra'] = 'Please upload Sammati Patra/Pratidnya Patra document';
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
      case 'documents':
      // Return first validation error found with specific message
        if (validationErrors.isNotEmpty) {
          return validationErrors.values.first;
        }
        return 'Please upload all required documents';

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

    // Non-agricultural specific errors
      case 'sakshamPradikaranAdesh':
        return validationErrors['sakshamPradikaranAdesh'] ?? 'Please upload Saksham Pradikaran Adesh document';
      case 'nakasha':
        return validationErrors['nakasha'] ?? 'Please upload Nakasha document';
      case 'nonAgriculturalZoneCertificate':
        return validationErrors['nonAgriculturalZoneCertificate'] ?? 'Please upload Zone Certificate';
      case 'bhandhakamParvana':
        return validationErrors['bhandhakamParvana'] ?? 'Please upload Bhandhakam Parvangi document';

    // Stomach specific errors
      case 'pratisaKarayaycheNaksha':
        return validationErrors['pratisaKarayaycheNaksha'] ?? 'Please upload Pratisa Karayayche Naksha document';
      case 'bandPhoto':
        return validationErrors['bandPhoto'] ?? 'Please upload Mojni karawayacha Jagecha Photo';
      case 'stomachZoneCertificate':
        return validationErrors['stomachZoneCertificate'] ?? 'Please upload Zone Certificate for Stomach';
      case 'sammatiPatra':
        return validationErrors['sammatiPatra'] ?? 'Please upload Sammati Patra document';

      default:
        return validationErrors[field] ?? 'This field is required';
    }
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
    Map<String, dynamic> data = {
      'identityCardType': selectedIdentityType.value.trim(),
      'identityCardFiles': identityCardFiles.toList(),
      'sevenTwelveFiles': sevenTwelveFiles.toList(),
      'noteFiles': noteFiles.toList(),
      'partitionFiles': partitionFiles.toList(),
      'schemeSheetFiles': schemeSheetFiles.toList(),
      'oldCensusMapFiles': oldCensusMapFiles.toList(),
      'demarcationCertificateFiles': demarcationCertificateFiles.toList(),
      'adhikarPatraFiles': adhikarPatra.toList(),
      'otherDocumentFiles': otherDocument.toList(),
    };

    // Add non-agricultural specific data
    if (isNonAgricultural) {
      data.addAll({
        'sakshamPradikaranAdeshFiles': sakshamPradikaranAdeshFiles.toList(),
        'nakashaFiles': nakashaFiles.toList(),
        'nonAgriculturalZoneCertificateFiles': nonAgriculturalZoneCertificateFiles.toList(),
        'bhandhakamParvanaFiles': bhandhakamParvanaFiles.toList(),
      });
    }

    // Add stomach specific data
    if (isStomach) {
      data.addAll({
        'pratisaKarayaycheNakshaFiles': pratisaKarayaycheNakshaFiles.toList(),
        'bandPhotoFiles': bandPhotoFiles.toList(),
        'stomachZoneCertificateFiles': stomachZoneCertificateFiles.toList(),
        'sammatiPatraFiles': sammatiPatraFiles.toList(),
      });
    }

    return data;
  }

  @override
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
    otherDocument.assignAll(List<String>.from(data['otherDocumentFiles'] ?? []));

    // Load non-agricultural specific data
    if (data.containsKey('sakshamPradikaranAdeshFiles')) {
      sakshamPradikaranAdeshFiles.assignAll(List<String>.from(data['sakshamPradikaranAdeshFiles'] ?? []));
    }
    if (data.containsKey('nakashaFiles')) {
      nakashaFiles.assignAll(List<String>.from(data['nakashaFiles'] ?? []));
    }
    if (data.containsKey('nonAgriculturalZoneCertificateFiles')) {
      nonAgriculturalZoneCertificateFiles.assignAll(List<String>.from(data['nonAgriculturalZoneCertificateFiles'] ?? []));
    }
    if (data.containsKey('bhandhakamParvanaFiles')) {
      bhandhakamParvanaFiles.assignAll(List<String>.from(data['bhandhakamParvanaFiles'] ?? []));
    }

    // Load stomach specific data
    if (data.containsKey('pratisaKarayaycheNakshaFiles')) {
      pratisaKarayaycheNakshaFiles.assignAll(List<String>.from(data['pratisaKarayaycheNakshaFiles'] ?? []));
    }
    if (data.containsKey('bandPhotoFiles')) {
      bandPhotoFiles.assignAll(List<String>.from(data['bandPhotoFiles'] ?? []));
    }
    if (data.containsKey('stomachZoneCertificateFiles')) {
      stomachZoneCertificateFiles.assignAll(List<String>.from(data['stomachZoneCertificateFiles'] ?? []));
    }
    if (data.containsKey('sammatiPatraFiles')) {
      sammatiPatraFiles.assignAll(List<String>.from(data['sammatiPatraFiles'] ?? []));
    }
  }

  // Check if all required documents are uploaded
  bool get areAllDocumentsUploaded {
    bool basicDocsUploaded = selectedIdentityType.value.isNotEmpty &&
        identityCardFiles.isNotEmpty &&
        sevenTwelveFiles.isNotEmpty &&
        noteFiles.isNotEmpty &&
        partitionFiles.isNotEmpty &&
        schemeSheetFiles.isNotEmpty &&
        oldCensusMapFiles.isNotEmpty &&
        demarcationCertificateFiles.isNotEmpty &&
        adhikarPatra.isNotEmpty;

    if (isNonAgricultural) {
      return basicDocsUploaded &&
          sakshamPradikaranAdeshFiles.isNotEmpty &&
          nakashaFiles.isNotEmpty &&
          nonAgriculturalZoneCertificateFiles.isNotEmpty &&
          bhandhakamParvanaFiles.isNotEmpty;
    }

    if (isStomach) {
      return basicDocsUploaded &&
          pratisaKarayaycheNakshaFiles.isNotEmpty &&
          bandPhotoFiles.isNotEmpty &&
          stomachZoneCertificateFiles.isNotEmpty &&
          sammatiPatraFiles.isNotEmpty;
    }

    return basicDocsUploaded;
  }

  // Get upload progress for UI
  String get uploadProgressText {
    int uploadedCount = 0;
    int totalRequired = 8; // Basic documents (including adhikarPatra)

    if (isNonAgricultural) {
      totalRequired += 4; // Add non-agricultural documents
    }

    if (isStomach) {
      totalRequired += 4; // Add stomach documents
    }

    if (selectedIdentityType.value.isNotEmpty && identityCardFiles.isNotEmpty) uploadedCount++;
    if (sevenTwelveFiles.isNotEmpty) uploadedCount++;
    if (noteFiles.isNotEmpty) uploadedCount++;
    if (partitionFiles.isNotEmpty) uploadedCount++;
    if (schemeSheetFiles.isNotEmpty) uploadedCount++;
    if (oldCensusMapFiles.isNotEmpty) uploadedCount++;
    if (demarcationCertificateFiles.isNotEmpty) uploadedCount++;
    if (adhikarPatra.isNotEmpty) uploadedCount++;

    if (isNonAgricultural) {
      if (sakshamPradikaranAdeshFiles.isNotEmpty) uploadedCount++;
      if (nakashaFiles.isNotEmpty) uploadedCount++;
      if (nonAgriculturalZoneCertificateFiles.isNotEmpty) uploadedCount++;
      if (bhandhakamParvanaFiles.isNotEmpty) uploadedCount++;
    }

    if (isStomach) {
      if (pratisaKarayaycheNakshaFiles.isNotEmpty) uploadedCount++;
      if (bandPhotoFiles.isNotEmpty) uploadedCount++;
      if (stomachZoneCertificateFiles.isNotEmpty) uploadedCount++;
      if (sammatiPatraFiles.isNotEmpty) uploadedCount++;
    }

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
  List<String> get otherDocumentFileNames => otherDocument.map((filePath) => filePath.split('/').last).toList();

  // Non-agricultural specific file names
  List<String> get sakshamPradikaranAdeshFileNames => sakshamPradikaranAdeshFiles.map((filePath) => filePath.split('/').last).toList();
  List<String> get nakashaFileNames => nakashaFiles.map((filePath) => filePath.split('/').last).toList();
  List<String> get nonAgriculturalZoneCertificateFileNames => nonAgriculturalZoneCertificateFiles.map((filePath) => filePath.split('/').last).toList();
  List<String> get bhandhakamParvanaFileNames => bhandhakamParvanaFiles.map((filePath) => filePath.split('/').last).toList();

  // Stomach specific file names
  List<String> get pratisaKarayaycheNakshaFileNames => pratisaKarayaycheNakshaFiles.map((filePath) => filePath.split('/').last).toList();
  List<String> get bandPhotoFileNames => bandPhotoFiles.map((filePath) => filePath.split('/').last).toList();
  List<String> get stomachZoneCertificateFileNames => stomachZoneCertificateFiles.map((filePath) => filePath.split('/').last).toList();
  List<String> get sammatiPatraFileNames => sammatiPatraFiles.map((filePath) => filePath.split('/').last).toList();

  // Helper methods to convert between File and String if needed elsewhere
  List<File> getFilesFromPaths(List<String> paths) {
    return paths.map((path) => File(path)).toList();
  }

  List<String> getPathsFromFiles(List<File> files) {
    return files.map((file) => file.path).toList();
  }
}
