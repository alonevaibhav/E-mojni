import 'dart:ui';

class CourtVatapFormResponse {
  final String message;
  final bool success;
  final CourtVatapFormData data;

  CourtVatapFormResponse({
    required this.message,
    required this.success,
    required this.data,
  });

  factory CourtVatapFormResponse.fromJson(Map<String, dynamic> json) {
    return CourtVatapFormResponse(
      message: json['message'] ?? '',
      success: json['success'] ?? false,
      data: CourtVatapFormData.fromJson(json['data'] ?? {}),
    );
  }
}

class CourtVatapFormData {
  final int userId;
  final String formType;
  final int count;
  final List<CourtVatapForm> forms;

  CourtVatapFormData({
    required this.userId,
    required this.formType,
    required this.count,
    required this.forms,
  });

  factory CourtVatapFormData.fromJson(Map<String, dynamic> json) {
    return CourtVatapFormData(
      userId: json['user_id'] ?? 0,
      formType: json['form_type'] ?? '',
      count: json['count'] ?? 0,
      forms: (json['forms'] as List<dynamic>?)
          ?.map((form) => CourtVatapForm.fromJson(form))
          .toList() ??
          [],
    );
  }
}

class CourtVatapForm {
  final int id;
  final String formId;
  final int userId;
  final String? courtName;
  final String? courtAddress;
  final String? courtAllocationOrderNumber;
  final String? courtAllocationOrderDate;
  final String? caseNumberYear;
  final String? courtAllocationOrderPath;
  final String? specialCourtInstructions;
  final int? division;
  final int? district;
  final int? taluka;
  final int? village;
  final String? surveyGroupNumber;
  final String? area;
  final String? areaAkrabandh;
  final String? areaSevenTwelve;
  final String? departmentNumber;
  final String? typeOfMeasurement;
  final String? duration;
  final String? holderType;
  final String? withinMunicipal;
  final String? measurementFee;
  final String? proposedSchedule;
  final String? petitionerName;
  final String? petitionerAddress;
  final String? petitionerMobileNumber;
  final String? petitionerSurveyNumber;
  final String? respondentName;
  final String? respondentAddress;
  final String? respondentMobileNumber;
  final String? respondentSurveyNumber;
  final String? adjoiningDirection;
  final String? adjoiningNaturalFeature;
  final String? adjoiningSurveyNumber;
  final String? adjoiningSubSurveyNumber;
  final String? adjoiningAddress;
  final String? adjoiningMobileNumber;
  final String? identityProofPath;
  final String? sevenTwelveExtractPath;
  final String? utaraAkharbandPath;
  final String? yojanaPatrak;
  final String? oldMeasurementPath;
  final String? tipanPath;
  final String? fadaniPath;
  final String? declarantName;
  final int declarantAge;
  final String? declarantAddress;
  final String? sammatiPatraPath;
  final String? schemeSheetPath;
  final String? demarcationCertificatePath;
  final String? adhikarPatraPath;
  final String? otherDocumentPath;
  final String createdAt;
  final String updatedAt;
  final String status;
  final String? plotDirection;
  final String? surveyEntries;
  final String? plaintiffDefendantEntries;
  final String? nextOfKinEntries;

  CourtVatapForm({
    required this.id,
    required this.formId,
    required this.userId,
    this.courtName,
    this.courtAddress,
    this.courtAllocationOrderNumber,
    this.courtAllocationOrderDate,
    this.caseNumberYear,
    this.courtAllocationOrderPath,
    this.specialCourtInstructions,
    this.division,
    this.district,
    this.taluka,
    this.village,
    this.surveyGroupNumber,
    this.area,
    this.areaAkrabandh,
    this.areaSevenTwelve,
    this.departmentNumber,
    this.typeOfMeasurement,
    this.duration,
    this.holderType,
    this.withinMunicipal,
    this.measurementFee,
    this.proposedSchedule,
    this.petitionerName,
    this.petitionerAddress,
    this.petitionerMobileNumber,
    this.petitionerSurveyNumber,
    this.respondentName,
    this.respondentAddress,
    this.respondentMobileNumber,
    this.respondentSurveyNumber,
    this.adjoiningDirection,
    this.adjoiningNaturalFeature,
    this.adjoiningSurveyNumber,
    this.adjoiningSubSurveyNumber,
    this.adjoiningAddress,
    this.adjoiningMobileNumber,
    this.identityProofPath,
    this.sevenTwelveExtractPath,
    this.utaraAkharbandPath,
    this.yojanaPatrak,
    this.oldMeasurementPath,
    this.tipanPath,
    this.fadaniPath,
    this.declarantName,
    required this.declarantAge,
    this.declarantAddress,
    this.sammatiPatraPath,
    this.schemeSheetPath,
    this.demarcationCertificatePath,
    this.adhikarPatraPath,
    this.otherDocumentPath,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    this.plotDirection,
    this.surveyEntries,
    this.plaintiffDefendantEntries,
    this.nextOfKinEntries,
  });

  factory CourtVatapForm.fromJson(Map<String, dynamic> json) {
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

    return CourtVatapForm(
      id: json['id'] ?? 0,
      formId: toStringOrNull(json['form_id']) ?? '',
      userId: json['user_id'] ?? 0,
      courtName: toStringOrNull(json['court_name']),
      courtAddress: toStringOrNull(json['court_address']),
      courtAllocationOrderNumber: toStringOrNull(json['court_allocation_order_number']),
      courtAllocationOrderDate: toStringOrNull(json['court_allocation_order_date']),
      caseNumberYear: toStringOrNull(json['case_number_year']),
      courtAllocationOrderPath: toStringOrNull(json['court_allocation_order_path']),
      specialCourtInstructions: toStringOrNull(json['special_court_instructions']),
      division: toIntOrNull(json['division']),
      district: toIntOrNull(json['district']),
      taluka: toIntOrNull(json['taluka']),
      village: toIntOrNull(json['village']),
      surveyGroupNumber: toStringOrNull(json['survey_group_number']),
      area: toStringOrNull(json['area']),
      areaAkrabandh: toStringOrNull(json['area_akrabandh']),
      areaSevenTwelve: toStringOrNull(json['area_seven_twelve']),
      departmentNumber: toStringOrNull(json['department_number']),
      typeOfMeasurement: toStringOrNull(json['type_of_measurement']),
      duration: toStringOrNull(json['duration']),
      holderType: toStringOrNull(json['holder_type']),
      withinMunicipal: toStringOrNull(json['within_municipal']),
      measurementFee: toStringOrNull(json['measurement_fee']),
      proposedSchedule: toStringOrNull(json['proposed_schedule']),
      petitionerName: toStringOrNull(json['petitioner_name']),
      petitionerAddress: toStringOrNull(json['petitioner_address']),
      petitionerMobileNumber: toStringOrNull(json['petitioner_mobile_number']),
      petitionerSurveyNumber: toStringOrNull(json['petitioner_survey_number']),
      respondentName: toStringOrNull(json['respondent_name']),
      respondentAddress: toStringOrNull(json['respondent_address']),
      respondentMobileNumber: toStringOrNull(json['respondent_mobile_number']),
      respondentSurveyNumber: toStringOrNull(json['respondent_survey_number']),
      adjoiningDirection: toStringOrNull(json['adjoining_direction']),
      adjoiningNaturalFeature: toStringOrNull(json['adjoining_natural_feature']),
      adjoiningSurveyNumber: toStringOrNull(json['adjoining_survey_number']),
      adjoiningSubSurveyNumber: toStringOrNull(json['adjoining_sub_survey_number']),
      adjoiningAddress: toStringOrNull(json['adjoining_address']),
      adjoiningMobileNumber: toStringOrNull(json['adjoining_mobile_number']),
      identityProofPath: toStringOrNull(json['identity_proof_path']),
      sevenTwelveExtractPath: toStringOrNull(json['seven_twelve_extract_path']),
      utaraAkharbandPath: toStringOrNull(json['utara_akharband_path']),
      yojanaPatrak: toStringOrNull(json['yojana_patrak']),
      oldMeasurementPath: toStringOrNull(json['old_measurement_path']),
      tipanPath: toStringOrNull(json['tipan_path']),
      fadaniPath: toStringOrNull(json['fadani_path']),
      declarantName: toStringOrNull(json['declarant_name']),
      declarantAge: json['declarant_age'] ?? 0,
      declarantAddress: toStringOrNull(json['declarant_address']),
      sammatiPatraPath: toStringOrNull(json['sammati_patra_path']),
      schemeSheetPath: toStringOrNull(json['scheme_sheet_path']),
      demarcationCertificatePath: toStringOrNull(json['demarcation_certificate_path']),
      adhikarPatraPath: toStringOrNull(json['adhikar_patra_path']),
      otherDocumentPath: toStringOrNull(json['other_document_path']),
      createdAt: toStringOrNull(json['created_at']) ?? '',
      updatedAt: toStringOrNull(json['updated_at']) ?? '',
      status: toStringOrNull(json['status']) ?? 'pending',
      plotDirection: toStringOrNull(json['plot_direction']),
      surveyEntries: toStringOrNull(json['survey_entries']),
      plaintiffDefendantEntries: toStringOrNull(json['plaintiff_defendant_entries']),
      nextOfKinEntries: toStringOrNull(json['next_of_kin_entries']),
    );
  }

  // Helper methods
  bool get isVerifiedBool => status.toLowerCase() == 'verified';
  bool get isPending => status.toLowerCase() == 'pending';
  bool get isPaymentDone => measurementFee != null && measurementFee!.isNotEmpty;
  bool get isScheduleProposed => proposedSchedule != null && proposedSchedule!.isNotEmpty;

  String get formattedCreatedDate {
    try {
      final date = DateTime.parse(createdAt);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return createdAt;
    }
  }

  String get formattedCourtAllocationDate {
    if (courtAllocationOrderDate == null) return 'N/A';
    try {
      final date = DateTime.parse(courtAllocationOrderDate!);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return courtAllocationOrderDate ?? 'N/A';
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
