import 'dart:ui';

class CountingLandFormResponse {
  final String message;
  final bool success;
  final CountingLandData data;

  CountingLandFormResponse({
    required this.message,
    required this.success,
    required this.data,
  });

  factory CountingLandFormResponse.fromJson(Map<String, dynamic> json) {
    return CountingLandFormResponse(
      message: json['message'] ?? '',
      success: json['success'] ?? false,
      data: CountingLandData.fromJson(json['data'] ?? {}),
    );
  }
}

class CountingLandData {
  final int userId;
  final String formType;
  final int count;
  final List<CountingLandForm> forms;

  CountingLandData({
    required this.userId,
    required this.formType,
    required this.count,
    required this.forms,
  });

  factory CountingLandData.fromJson(Map<String, dynamic> json) {
    return CountingLandData(
      userId: json['user_id'] ?? 0,
      formType: json['form_type'] ?? '',
      count: json['count'] ?? 0,
      forms: (json['forms'] as List<dynamic>?)
          ?.map((form) => CountingLandForm.fromJson(form))
          .toList() ??
          [],
    );
  }
}

class CountingLandForm {
  final int id;
  final int isLandholder;
  final int isPowerOfAttorney;
  final String? poaRegistrationNumber;
  final String? poaRegistrationDate;
  final String? poaGiverName;
  final String? poaHolderName;
  final String? poaHolderAddress;
  final String? poaDocumentPath;
  final int divisionId;
  final int districtId;
  final int talukaId;
  final int villageId;
  final String? surveyAreas;
  final String? surveyDetailType;
  final String? operationType;
  final String? consolidationOrderNumber;
  final String? oldConsolidationMrn;
  final String? consolidationOrderMap;
  final String? orderApprovalNumber;
  final String? orderApprovalDate;
  final String? layoutApprovalNumber;
  final String? layoutApprovalDate;
  final String applicantName;
  final String applicantAddress;
  final String applicantSubPartArea;
  final String? coOwnerName;
  final String? coOwnerAddress;
  final String? coOwnerMobileNumber;
  final String? adjacentOwnerName;
  final String? adjacentOwnerAddress;
  final String adjacentOwnerTotalArea;
  final String? adjacentOwnerMobileNumber;
  final String? identityProofPath;
  final String? otherDocumentsPath;
  final String? tipanPath;
  final String? fadniPath;
  final String? yojanPatrakPath;
  final String? oldMeasurementPath;
  final String? simankanPramanpatraPath;
  final String? sevenElevenPath;
  final String? adhikarPatrasPath;
  final String? sakshamPradikaranAdeshPath;
  final String? nakashaPath;
  final String? bhandhakamParvanaPath;
  final String? nonAgriculturalZoneCertificatePath;
  final String status;
  final int userId;
  final String department;
  final int hasBeenCountedBefore;
  final String? nextOfKin;
  final String? coOwners;
  final String? adjacentOwners;
  final int paymentStatus;
  final String createdAt;
  final String updatedAt;

  CountingLandForm({
    required this.id,
    required this.isLandholder,
    required this.isPowerOfAttorney,
    this.poaRegistrationNumber,
    this.poaRegistrationDate,
    this.poaGiverName,
    this.poaHolderName,
    this.poaHolderAddress,
    this.poaDocumentPath,
    required this.divisionId,
    required this.districtId,
    required this.talukaId,
    required this.villageId,
    this.surveyAreas,
    this.surveyDetailType,
    this.operationType,
    this.consolidationOrderNumber,
    this.oldConsolidationMrn,
    this.consolidationOrderMap,
    this.orderApprovalNumber,
    this.orderApprovalDate,
    this.layoutApprovalNumber,
    this.layoutApprovalDate,
    required this.applicantName,
    required this.applicantAddress,
    required this.applicantSubPartArea,
    this.coOwnerName,
    this.coOwnerAddress,
    this.coOwnerMobileNumber,
    this.adjacentOwnerName,
    this.adjacentOwnerAddress,
    required this.adjacentOwnerTotalArea,
    this.adjacentOwnerMobileNumber,
    this.identityProofPath,
    this.otherDocumentsPath,
    this.tipanPath,
    this.fadniPath,
    this.yojanPatrakPath,
    this.oldMeasurementPath,
    this.simankanPramanpatraPath,
    this.sevenElevenPath,
    this.adhikarPatrasPath,
    this.sakshamPradikaranAdeshPath,
    this.nakashaPath,
    this.bhandhakamParvanaPath,
    this.nonAgriculturalZoneCertificatePath,
    required this.status,
    required this.userId,
    required this.department,
    required this.hasBeenCountedBefore,
    this.nextOfKin,
    this.coOwners,
    this.adjacentOwners,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CountingLandForm.fromJson(Map<String, dynamic> json) {
    return CountingLandForm(
      id: json['id'] ?? 0,
      isLandholder: json['is_landholder'] ?? 0,
      isPowerOfAttorney: json['is_power_of_attorney'] ?? 0,
      poaRegistrationNumber: json['poa_registration_number'],
      poaRegistrationDate: json['poa_registration_date'],
      poaGiverName: json['poa_giver_name'],
      poaHolderName: json['poa_holder_name'],
      poaHolderAddress: json['poa_holder_address'],
      poaDocumentPath: json['poa_document_path'],
      divisionId: json['division_id'] ?? 0,
      districtId: json['district_id'] ?? 0,
      talukaId: json['taluka_id'] ?? 0,
      villageId: json['village_id'] ?? 0,
      surveyAreas: json['survey_areas'],
      surveyDetailType: json['survey_detail_type'],
      operationType: json['operation_type'],
      consolidationOrderNumber: json['consolidation_order_number'],
      oldConsolidationMrn: json['old_consolidation_mrn'],
      consolidationOrderMap: json['consolidation_order_map'],
      orderApprovalNumber: json['order_approval_number'],
      orderApprovalDate: json['order_approval_date'],
      layoutApprovalNumber: json['layout_approval_number'],
      layoutApprovalDate: json['layout_approval_date'],
      applicantName: json['applicant_name'] ?? '',
      applicantAddress: json['applicant_address'] ?? '',
      applicantSubPartArea: json['applicant_sub_part_area'] ?? '0.00',
      coOwnerName: json['co_owner_name'],
      coOwnerAddress: json['co_owner_address'],
      coOwnerMobileNumber: json['co_owner_mobile_number'],
      adjacentOwnerName: json['adjacent_owner_name'],
      adjacentOwnerAddress: json['adjacent_owner_address'],
      adjacentOwnerTotalArea: json['adjacent_owner_total_area'] ?? '0.00',
      adjacentOwnerMobileNumber: json['adjacent_owner_mobile_number'],
      identityProofPath: json['identity_proof_path'],
      otherDocumentsPath: json['other_documents_path'],
      tipanPath: json['tipan_path'],
      fadniPath: json['fadni_path'],
      yojanPatrakPath: json['yojana_patrak_path'],
      oldMeasurementPath: json['old_measurement_path'],
      simankanPramanpatraPath: json['simankan_pramanpatra_path'],
      sevenElevenPath: json['seven_eleven_path'],
      adhikarPatrasPath: json['adhikar_patras_path'],
      sakshamPradikaranAdeshPath: json['saksham_pradikaran_adesh_path'],
      nakashaPath: json['nakasha_path'],
      bhandhakamParvanaPath: json['bhandhakam_parvana_path'],
      nonAgriculturalZoneCertificatePath:
      json['non_agricultural_zone_certificate_path'],
      status: json['status'] ?? 'pending',
      userId: json['user_id'] ?? 0,
      department: json['department'] ?? '',
      hasBeenCountedBefore: json['has_been_counted_before'] ?? 0,
      nextOfKin: json['next_of_kin'],
      coOwners: json['co_owners'],
      adjacentOwners: json['adjacent_owners'],
      paymentStatus: json['payment_status'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  // Helper methods
  bool get isVerified => status.toLowerCase() == 'verified';
  bool get isPending => status.toLowerCase() == 'pending';
  bool get isPaymentDone => paymentStatus == 1;

  String get formattedCreatedDate {
    try {
      final date = DateTime.parse(createdAt);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return createdAt;
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

// Extension for String
extension StringExtension on String {
  String charAt(int index) {
    return this[index];
  }
}