import 'dart:ui';

class ShaskiyaMojniFormResponse {
  final String message;
  final bool success;
  final ShaskiyaMojniFormData data;

  ShaskiyaMojniFormResponse({
    required this.message,
    required this.success,
    required this.data,
  });

  factory ShaskiyaMojniFormResponse.fromJson(Map<String, dynamic> json) {
    return ShaskiyaMojniFormResponse(
      message: json['message'] ?? '',
      success: json['success'] ?? false,
      data: ShaskiyaMojniFormData.fromJson(json['data'] ?? {}),
    );
  }
}

class ShaskiyaMojniFormData {
  final int userId;
  final String formType;
  final int count;
  final List<ShaskiyaMojniForm> forms;

  ShaskiyaMojniFormData({
    required this.userId,
    required this.formType,
    required this.count,
    required this.forms,
  });

  factory ShaskiyaMojniFormData.fromJson(Map<String, dynamic> json) {
    return ShaskiyaMojniFormData(
      userId: json['user_id'] ?? 0,
      formType: json['form_type'] ?? '',
      count: json['count'] ?? 0,
      forms: (json['forms'] as List<dynamic>?)
          ?.map((form) => ShaskiyaMojniForm.fromJson(form))
          .toList() ??
          [],
    );
  }
}

class ShaskiyaMojniForm {
  final int id;
  final String formId;
  final int userId;
  final String? applicantFullname;
  final String? applicantFulladdress;
  final String? officerName;
  final String? officerAddress;
  final String? surveyOrderNumber;
  final String? surveyOrderDate;
  final String? applicantName;
  final String? applicantAddress;
  final String? surveyDetails;
  final String? surveyOrderFilePath;
  final int? division;
  final int? district;
  final int? taluka;
  final int? village;
  final String? surveyNumber;
  final String? duration;
  final String? landholderType;
  final String? sevenTwelveExtractPath;
  final String? identityProofPath;
  final String? oldMeasurementPath;
  final String? yojanaPatrakPath;
  final String? tipanPath;
  final String? fadaniPath;
  final String createdAt;
  final String updatedAt;
  final String status;
  final String? nextOfKin;
  final String? coOwners;
  final String? applicantEntries;
  final String? surveyEntries;
  final String? demarcationCertificatePath;
  final String? adhikarPatraPath;
  final String? utaraAkharbandPath;
  final String? otherDocumentPath;

  ShaskiyaMojniForm({
    required this.id,
    required this.formId,
    required this.userId,
    this.applicantFullname,
    this.applicantFulladdress,
    this.officerName,
    this.officerAddress,
    this.surveyOrderNumber,
    this.surveyOrderDate,
    this.applicantName,
    this.applicantAddress,
    this.surveyDetails,
    this.surveyOrderFilePath,
    this.division,
    this.district,
    this.taluka,
    this.village,
    this.surveyNumber,
    this.duration,
    this.landholderType,
    this.sevenTwelveExtractPath,
    this.identityProofPath,
    this.oldMeasurementPath,
    this.yojanaPatrakPath,
    this.tipanPath,
    this.fadaniPath,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    this.nextOfKin,
    this.coOwners,
    this.applicantEntries,
    this.surveyEntries,
    this.demarcationCertificatePath,
    this.adhikarPatraPath,
    this.utaraAkharbandPath,
    this.otherDocumentPath,
  });

  factory ShaskiyaMojniForm.fromJson(Map<String, dynamic> json) {
    // Helper function to safely convert values to String
    String? toStringOrNull(dynamic value) {
      if (value == null) return null;
      return value.toString();
    }

    // Helper function to safely convert values to int
    int? toIntOrNull(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is String) return int.tryParse(value);
      return null;
    }

    return ShaskiyaMojniForm(
      id: json['id'] ?? 0,
      formId: toStringOrNull(json['form_id']) ?? '',
      userId: json['user_id'] ?? 0,
      applicantFullname: toStringOrNull(json['applicant_fullname']),
      applicantFulladdress: toStringOrNull(json['applicant_fulladdress']),
      officerName: toStringOrNull(json['officer_name']),
      officerAddress: toStringOrNull(json['officer_address']),
      surveyOrderNumber: toStringOrNull(json['survey_order_number']),
      surveyOrderDate: toStringOrNull(json['survey_order_date']),
      applicantName: toStringOrNull(json['applicant_name']),
      applicantAddress: toStringOrNull(json['applicant_address']),
      surveyDetails: toStringOrNull(json['survey_details']),
      surveyOrderFilePath: toStringOrNull(json['survey_order_file_path']),
      division: toIntOrNull(json['division']),
      district: toIntOrNull(json['district']),
      taluka: toIntOrNull(json['taluka']),
      village: toIntOrNull(json['village']),
      surveyNumber: toStringOrNull(json['survey_number']),
      duration: toStringOrNull(json['duration']),
      landholderType: toStringOrNull(json['landholder_type']),
      sevenTwelveExtractPath: toStringOrNull(json['seven_twelve_extract_path']),
      identityProofPath: toStringOrNull(json['identity_proof_path']),
      oldMeasurementPath: toStringOrNull(json['old_measurement_path']),
      yojanaPatrakPath: toStringOrNull(json['yojana_patrak_path']),
      tipanPath: toStringOrNull(json['tipan_path']),
      fadaniPath: toStringOrNull(json['fadani_path']),
      createdAt: toStringOrNull(json['created_at']) ?? '',
      updatedAt: toStringOrNull(json['updated_at']) ?? '',
      status: toStringOrNull(json['status']) ?? 'pending',
      nextOfKin: toStringOrNull(json['next_of_kin']),
      coOwners: toStringOrNull(json['co_owners']),
      applicantEntries: toStringOrNull(json['applicant_entries']),
      surveyEntries: toStringOrNull(json['survey_entries']),
      demarcationCertificatePath: toStringOrNull(json['demarcation_certificate_path']),
      adhikarPatraPath: toStringOrNull(json['adhikar_patra_path']),
      utaraAkharbandPath: toStringOrNull(json['utara_akharband_path']),
      otherDocumentPath: toStringOrNull(json['other_document_path']),
    );
  }

  // Helper methods
  bool get isVerifiedBool => status.toLowerCase() == 'verified';
  bool get isPending => status.toLowerCase() == 'pending';
  bool get hasCoOwners => coOwners != null && coOwners!.isNotEmpty && coOwners != '[]';
  bool get hasSurveyDetails => surveyDetails != null && surveyDetails!.isNotEmpty;

  String get formattedCreatedDate {
    try {
      final date = DateTime.parse(createdAt);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return createdAt;
    }
  }

  String get formattedSurveyOrderDate {
    if (surveyOrderDate == null) return 'N/A';
    try {
      final date = DateTime.parse(surveyOrderDate!);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return surveyOrderDate ?? 'N/A';
    }
  }

  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'verified':
        return const Color(0xFF4CAF50);
      case 'pending':
        return const Color(0xFFFF9800);
      case 'rejected':
        return const Color(0xFFF44336);
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  String get statusDisplayText {
    return status.charAt(0).toUpperCase() + status.substring(1);
  }
}

// Extension for String - same as previous forms
extension StringExtension on String {
  String charAt(int index) {
    return this[index];
  }
}
