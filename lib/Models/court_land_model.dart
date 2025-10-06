import 'dart:ui';

import 'package:emojni/Models/bhusampadan_model.dart';

class CourtLandDetailsFormResponse {
  final String message;
  final bool success;
  final CourtLandDetailsFormData data;

  CourtLandDetailsFormResponse({
    required this.message,
    required this.success,
    required this.data,
  });

  factory CourtLandDetailsFormResponse.fromJson(Map<String, dynamic> json) {
    return CourtLandDetailsFormResponse(
      message: json['message'] ?? '',
      success: json['success'] ?? false,
      data: CourtLandDetailsFormData.fromJson(json['data'] ?? {}),
    );
  }
}

class CourtLandDetailsFormData {
  final int userId;
  final String formType;
  final int count;
  final List<CourtLandDetailsForm> forms;

  CourtLandDetailsFormData({
    required this.userId,
    required this.formType,
    required this.count,
    required this.forms,
  });

  factory CourtLandDetailsFormData.fromJson(Map<String, dynamic> json) {
    return CourtLandDetailsFormData(
      userId: json['user_id'] ?? 0,
      formType: json['form_type'] ?? '',
      count: json['count'] ?? 0,
      forms: (json['forms'] as List<dynamic>?)
          ?.map((form) => CourtLandDetailsForm.fromJson(form))
          .toList() ??
          [],
    );
  }
}

class CourtLandDetailsForm {
  final int id;
  final String formId;
  final int userId;
  final String? courtName;
  final String? courtAddress;
  final String? orderNumber;
  final String? orderDate;
  final String? civilCaseRefNumber;
  final String? courtOfficeName;
  final String? orderDocumentPath;
  final String? surveyNumber;
  final int? division;
  final int? district;
  final int? taluka;
  final int? village;
  final String? surveyVillage;
  final String? surveyGroupNumber;
  final String? subSurveyGroupNumber;
  final String? area;
  final String? typeOfMeasurement;
  final String? duration;
  final String? holderType;
  final String? withinMunicipal;
  final String? typeOfLand;
  final String? measurementFee;
  final String? feeConfirmation;
  final String? proposedSchedule;
  final String? opponentName;
  final String? opponentAddress;
  final String? opponentMobileNumber;
  final String? opponentSurveyGroupNumber;
  final String? identityProofPath;
  final String? yojanaPatrak;
  final String? sevenTwelveExtractPath;
  final String? writtenApplicationPath;
  final String? tipanPath;
  final String? fadniPath;
  final String? oldMeasurementPath;
  final String? declarantName;
  final int declarantAge;
  final String? declarantAddress;
  final String? selfDeclaration;
  final String createdAt;
  final String updatedAt;
  final String status;
  final String? surveyEntries;
  final String? nextOfKin;
  final String? plaintiffDefendantEntries;
  final String? sarvaSahaDharakacheSamattiPatraPath;
  final String? simankanPramanpatraPath;
  final String? otherDocumentPath;
  final String? adhikarPatraPath;

  CourtLandDetailsForm({
    required this.id,
    required this.formId,
    required this.userId,
    this.courtName,
    this.courtAddress,
    this.orderNumber,
    this.orderDate,
    this.civilCaseRefNumber,
    this.courtOfficeName,
    this.orderDocumentPath,
    this.surveyNumber,
    this.division,
    this.district,
    this.taluka,
    this.village,
    this.surveyVillage,
    this.surveyGroupNumber,
    this.subSurveyGroupNumber,
    this.area,
    this.typeOfMeasurement,
    this.duration,
    this.holderType,
    this.withinMunicipal,
    this.typeOfLand,
    this.measurementFee,
    this.feeConfirmation,
    this.proposedSchedule,
    this.opponentName,
    this.opponentAddress,
    this.opponentMobileNumber,
    this.opponentSurveyGroupNumber,
    this.identityProofPath,
    this.yojanaPatrak,
    this.sevenTwelveExtractPath,
    this.writtenApplicationPath,
    this.tipanPath,
    this.fadniPath,
    this.oldMeasurementPath,
    this.declarantName,
    required this.declarantAge,
    this.declarantAddress,
    this.selfDeclaration,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    this.surveyEntries,
    this.nextOfKin,
    this.plaintiffDefendantEntries,
    this.sarvaSahaDharakacheSamattiPatraPath,
    this.simankanPramanpatraPath,
    this.otherDocumentPath,
    this.adhikarPatraPath,
  });

  factory CourtLandDetailsForm.fromJson(Map<String, dynamic> json) {
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

    return CourtLandDetailsForm(
      id: json['id'] ?? 0,
      formId: toStringOrNull(json['form_id']) ?? '',
      userId: json['user_id'] ?? 0,
      courtName: toStringOrNull(json['court_name']),
      courtAddress: toStringOrNull(json['court_address']),
      orderNumber: toStringOrNull(json['order_number']),
      orderDate: toStringOrNull(json['order_date']),
      civilCaseRefNumber: toStringOrNull(json['civil_case_ref_number']),
      courtOfficeName: toStringOrNull(json['court_office_name']),
      orderDocumentPath: toStringOrNull(json['order_document_path']),
      surveyNumber: toStringOrNull(json['survey_number']),
      division: toIntOrNull(json['division']),
      district: toIntOrNull(json['district']),
      taluka: toIntOrNull(json['taluka']),
      village: toIntOrNull(json['village']),
      surveyVillage: toStringOrNull(json['survey_village']),
      surveyGroupNumber: toStringOrNull(json['survey_group_number']),
      subSurveyGroupNumber: toStringOrNull(json['sub_survey_group_number']),
      area: toStringOrNull(json['area']),
      typeOfMeasurement: toStringOrNull(json['type_of_measurement']),
      duration: toStringOrNull(json['duration']),
      holderType: toStringOrNull(json['holder_type']),
      withinMunicipal: toStringOrNull(json['within_municipal']),
      typeOfLand: toStringOrNull(json['type_of_land']),
      measurementFee: toStringOrNull(json['measurement_fee']),
      feeConfirmation: toStringOrNull(json['fee_confirmation']),
      proposedSchedule: toStringOrNull(json['proposed_schedule']),
      opponentName: toStringOrNull(json['opponent_name']),
      opponentAddress: toStringOrNull(json['opponent_address']),
      opponentMobileNumber: toStringOrNull(json['opponent_mobile_number']),
      opponentSurveyGroupNumber: toStringOrNull(json['opponent_survey_group_number']),
      identityProofPath: toStringOrNull(json['identity_proof_path']),
      yojanaPatrak: toStringOrNull(json['yojana_patrak']),
      sevenTwelveExtractPath: toStringOrNull(json['seven_twelve_extract_path']),
      writtenApplicationPath: toStringOrNull(json['written_application_path']),
      tipanPath: toStringOrNull(json['tipan_path']),
      fadniPath: toStringOrNull(json['fadni_path']),
      oldMeasurementPath: toStringOrNull(json['old_measurement_path']),
      declarantName: toStringOrNull(json['declarant_name']),
      declarantAge: json['declarant_age'] ?? 0,
      declarantAddress: toStringOrNull(json['declarant_address']),
      selfDeclaration: toStringOrNull(json['self_declaration']),
      createdAt: toStringOrNull(json['created_at']) ?? '',
      updatedAt: toStringOrNull(json['updated_at']) ?? '',
      status: toStringOrNull(json['status']) ?? 'pending',
      surveyEntries: toStringOrNull(json['survey_entries']),
      nextOfKin: toStringOrNull(json['next_of_kin']),
      plaintiffDefendantEntries: toStringOrNull(json['plaintiff_defendant_entries']),
      sarvaSahaDharakacheSamattiPatraPath: toStringOrNull(json['sarva_saha_dharakache_samatti_patra_path']),
      simankanPramanpatraPath: toStringOrNull(json['simankan_pramanpatra_path']),
      otherDocumentPath: toStringOrNull(json['other_document_path']),
      adhikarPatraPath: toStringOrNull(json['adhikar_patra_path']),
    );
  }

  // Helper methods
  bool get isVerifiedBool => status.toLowerCase() == 'verified';
  bool get isPending => status.toLowerCase() == 'pending';
  bool get isPaymentDone => measurementFee != null && measurementFee!.isNotEmpty;
  bool get isFeeConfirmed => feeConfirmation != null && feeConfirmation!.isNotEmpty;

  String get formattedCreatedDate {
    try {
      final date = DateTime.parse(createdAt);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return createdAt;
    }
  }

  String get formattedOrderDate {
    if (orderDate == null) return 'N/A';
    try {
      final date = DateTime.parse(orderDate!);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return orderDate ?? 'N/A';
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
