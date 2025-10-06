import 'dart:ui';

class BhusampadanFormResponse {
  final String message;
  final bool success;
  final BhusampadanFormData data;

  BhusampadanFormResponse({
    required this.message,
    required this.success,
    required this.data,
  });

  factory BhusampadanFormResponse.fromJson(Map<String, dynamic> json) {
    return BhusampadanFormResponse(
      message: json['message'] ?? '',
      success: json['success'] ?? false,
      data: BhusampadanFormData.fromJson(json['data'] ?? {}),
    );
  }
}

class BhusampadanFormData {
  final int userId;
  final String formType;
  final int count;
  final List<BhusampadanForm> forms;

  BhusampadanFormData({
    required this.userId,
    required this.formType,
    required this.count,
    required this.forms,
  });

  factory BhusampadanFormData.fromJson(Map<String, dynamic> json) {
    return BhusampadanFormData(
      userId: json['user_id'] ?? 0,
      formType: json['form_type'] ?? '',
      count: json['count'] ?? 0,
      forms: (json['forms'] as List<dynamic>?)
          ?.map((form) => BhusampadanForm.fromJson(form))
          .toList() ??
          [],
    );
  }
}

class BhusampadanForm {
  final int id;
  final String formId;
  final String? landAcquisitionOfficer;
  final String? landAcquisitionBoardNameAddress;
  final String? landAcquisitionDescription;
  final String? orderProposalNumber;
  final String? orderProposalDate;
  final String? issuingOfficeAddress;
  final String? orderProposalDocumentPath;
  final String? demarcationMapPath;
  final String? kmlFilePath;
  final String? plotDirection;
  final int? division;
  final int? district;
  final int? taluka;
  final int? village;
  final String? office;
  final String? measurementType;
  final String? surveyEntries;
  final String? surveyGatCtsNumber;
  final String? landEntryVillage;
  final String? landNumber;
  final String? subSurveyNumber;
  final String? assessmentArea;
  final String? convertedArea;
  final String? landAcquisitionArea;
  final String? duration;
  final String? unitOfMeasurement;
  final String? holderName;
  final String? holderLastName;
  final String? holderInformation;
  final String? nextOfKin;
  final String? holderAddress;
  final String? accountNumber;
  final String? mobileNumber;
  final String? surveyNumber;
  final String? area;
  final String? subPartArea;
  final String? measurementFee;
  final String? totalLandArea;
  final String? totalAssessedArea;
  final int importViaExcel;
  final int excelImportCompletionFlag;
  final String? paymentMode;
  final String createdAt;
  final String updatedAt;
  final int userId;
  final int isVerified;
  final String? sevenElevenPath;
  final String? identificationPath;
  final String? tipanPath;
  final String? fadniPath;
  final String? yojanaPatrakPath;
  final String? oldMeasurementPath;
  final String? allDeclarationPath;
  final String? permissionLetterPath;
  final String? simankanPramanpatraPath;
  final String? dharaniNiyamRemarks;
  final int bhusampadanApprovalFlag;
  final String? bhusampadanApprovalDate;
  final String? bhusampadanApprovalOfficer;
  final String? bhusampadanRemarks;
  final String status;
  final String? holderType;
  final String? pincode;

  BhusampadanForm({
    required this.id,
    required this.formId,
    this.landAcquisitionOfficer,
    this.landAcquisitionBoardNameAddress,
    this.landAcquisitionDescription,
    this.orderProposalNumber,
    this.orderProposalDate,
    this.issuingOfficeAddress,
    this.orderProposalDocumentPath,
    this.demarcationMapPath,
    this.kmlFilePath,
    this.plotDirection,
    this.division,
    this.district,
    this.taluka,
    this.village,
    this.office,
    this.measurementType,
    this.surveyEntries,
    this.surveyGatCtsNumber,
    this.landEntryVillage,
    this.landNumber,
    this.subSurveyNumber,
    this.assessmentArea,
    this.convertedArea,
    this.landAcquisitionArea,
    this.duration,
    this.unitOfMeasurement,
    this.holderName,
    this.holderLastName,
    this.holderInformation,
    this.nextOfKin,
    this.holderAddress,
    this.accountNumber,
    this.mobileNumber,
    this.surveyNumber,
    this.area,
    this.subPartArea,
    this.measurementFee,
    this.totalLandArea,
    this.totalAssessedArea,
    required this.importViaExcel,
    required this.excelImportCompletionFlag,
    this.paymentMode,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.isVerified,
    this.sevenElevenPath,
    this.identificationPath,
    this.tipanPath,
    this.fadniPath,
    this.yojanaPatrakPath,
    this.oldMeasurementPath,
    this.allDeclarationPath,
    this.permissionLetterPath,
    this.simankanPramanpatraPath,
    this.dharaniNiyamRemarks,
    required this.bhusampadanApprovalFlag,
    this.bhusampadanApprovalDate,
    this.bhusampadanApprovalOfficer,
    this.bhusampadanRemarks,
    required this.status,
    this.holderType,
    this.pincode,
  });

  factory BhusampadanForm.fromJson(Map<String, dynamic> json) {
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

    return BhusampadanForm(
      id: json['id'] ?? 0,
      formId: toStringOrNull(json['form_id']) ?? '',
      landAcquisitionOfficer: toStringOrNull(json['land_acquisition_officer']),
      landAcquisitionBoardNameAddress: toStringOrNull(json['land_acquisition_board_name_address']),
      landAcquisitionDescription: toStringOrNull(json['land_acquisition_description']),
      orderProposalNumber: toStringOrNull(json['order_proposal_number']),
      orderProposalDate: toStringOrNull(json['order_proposal_date']),
      issuingOfficeAddress: toStringOrNull(json['issuing_office_address']),
      orderProposalDocumentPath: toStringOrNull(json['order_proposal_document_path']),
      demarcationMapPath: toStringOrNull(json['demarcation_map_path']),
      kmlFilePath: toStringOrNull(json['kml_file_path']),
      plotDirection: toStringOrNull(json['plot_direction']),
      division: toIntOrNull(json['division']),
      district: toIntOrNull(json['district']),
      taluka: toIntOrNull(json['taluka']),
      village: toIntOrNull(json['village']),
      office: toStringOrNull(json['office']),
      measurementType: toStringOrNull(json['measurement_type']),
      surveyEntries: toStringOrNull(json['survey_entries']),
      surveyGatCtsNumber: toStringOrNull(json['survey_gat_cts_number']),
      landEntryVillage: toStringOrNull(json['land_entry_village']),
      landNumber: toStringOrNull(json['land_number']),
      subSurveyNumber: toStringOrNull(json['sub_survey_number']),
      assessmentArea: toStringOrNull(json['assessment_area']),
      convertedArea: toStringOrNull(json['converted_area']),
      landAcquisitionArea: toStringOrNull(json['land_acquisition_area']),
      duration: toStringOrNull(json['duration']),
      unitOfMeasurement: toStringOrNull(json['unit_of_measurement']),
      holderName: toStringOrNull(json['holder_name']),
      holderLastName: toStringOrNull(json['holder_last_name']),
      holderInformation: toStringOrNull(json['holder_information']),
      nextOfKin: toStringOrNull(json['next_of_kin']),
      holderAddress: toStringOrNull(json['holder_address']),
      accountNumber: toStringOrNull(json['account_number']),
      mobileNumber: toStringOrNull(json['mobile_number']),
      surveyNumber: toStringOrNull(json['survey_number']),
      area: toStringOrNull(json['area']),
      subPartArea: toStringOrNull(json['sub_part_area']),
      measurementFee: toStringOrNull(json['measurement_fee']),
      totalLandArea: toStringOrNull(json['total_land_area']),
      totalAssessedArea: toStringOrNull(json['total_assessed_area']),
      importViaExcel: json['import_via_excel'] ?? 0,
      excelImportCompletionFlag: json['excel_import_completion_flag'] ?? 0,
      paymentMode: toStringOrNull(json['payment_mode']),
      createdAt: toStringOrNull(json['created_at']) ?? '',
      updatedAt: toStringOrNull(json['updated_at']) ?? '',
      userId: json['user_id'] ?? 0,
      isVerified: json['isVerified'] ?? 0,
      sevenElevenPath: toStringOrNull(json['seven_eleven_path']),
      identificationPath: toStringOrNull(json['identification_path']),
      tipanPath: toStringOrNull(json['tipan_path']),
      fadniPath: toStringOrNull(json['fadni_path']),
      yojanaPatrakPath: toStringOrNull(json['yojana_patrak_path']),
      oldMeasurementPath: toStringOrNull(json['old_measurement_path']),
      allDeclarationPath: toStringOrNull(json['all_declaration_path']),
      permissionLetterPath: toStringOrNull(json['permission_letter_path']),
      simankanPramanpatraPath: toStringOrNull(json['simankan_pramanpatra_path']),
      dharaniNiyamRemarks: toStringOrNull(json['dharani_niyam_remarks']),
      bhusampadanApprovalFlag: json['bhusampadan_approval_flag'] ?? 0,
      bhusampadanApprovalDate: toStringOrNull(json['bhusampadan_approval_date']),
      bhusampadanApprovalOfficer: toStringOrNull(json['bhusampadan_approval_officer']),
      bhusampadanRemarks: toStringOrNull(json['bhusampadan_remarks']),
      status: toStringOrNull(json['status']) ?? 'pending',
      holderType: toStringOrNull(json['holder_type']),
      pincode: toStringOrNull(json['pincode']),
    );
  }

  // Helper methods - same pattern as CountingLandForm
  bool get isVerifiedBool => status.toLowerCase() == 'verified';
  bool get isPending => status.toLowerCase() == 'pending';
  bool get isPaymentDone => paymentMode != null && paymentMode!.isNotEmpty;
  bool get isBhusampadanApproved => bhusampadanApprovalFlag == 1;

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

  String get formattedOrderProposalDate {
    if (orderProposalDate == null) return 'N/A';
    try {
      final date = DateTime.parse(orderProposalDate!);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return orderProposalDate ?? 'N/A';
    }
  }
}

// Extension for String - same as CountingLand
extension StringExtension on String {
  String charAt(int index) {
    return this[index];
  }
}