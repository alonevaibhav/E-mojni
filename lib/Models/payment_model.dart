class PaymentResponse {
  final String message;
  final bool success;
  final PaymentData? data;
  final List<dynamic> errors;

  PaymentResponse({
    required this.message,
    required this.success,
    this.data,
    required this.errors,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      message: json['message'] ?? '',
      success: json['success'] ?? false,
      data: json['data'] != null ? PaymentData.fromJson(json['data']) : null,
      errors: json['errors'] ?? [],
    );
  }
}

class PaymentData {
  final int id;
  final int formId;
  final String formType;
  final int userId;
  final String upiId;
  final String transactionNote;
  final String measurementQrCode;
  final String convenienceQrCode;
  final String measurementPaymentStatus;
  final String conveniencePaymentStatus;
  final String? measurementTransactionId;
  final String? convenienceTransactionId;
  final String? measurementChalanPath;
  final String? convenienceChalanPath;
  final String createdAt;
  final String updatedAt;
  final String measurementFee;
  final String convenienceFee;

  PaymentData({
    required this.id,
    required this.formId,
    required this.formType,
    required this.userId,
    required this.upiId,
    required this.transactionNote,
    required this.measurementQrCode,
    required this.convenienceQrCode,
    required this.measurementPaymentStatus,
    required this.conveniencePaymentStatus,
    this.measurementTransactionId,
    this.convenienceTransactionId,
    this.measurementChalanPath,
    this.convenienceChalanPath,
    required this.createdAt,
    required this.updatedAt,
    required this.measurementFee,
    required this.convenienceFee,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      id: json['id'] ?? 0,
      formId: json['form_id'] ?? 0,
      formType: json['form_type'] ?? '',
      userId: json['user_id'] ?? 0,
      upiId: json['upi_id'] ?? '',
      transactionNote: json['transaction_note'] ?? '',
      measurementQrCode: json['measurement_qr_code'] ?? '',
      convenienceQrCode: json['convenience_qr_code'] ?? '',
      measurementPaymentStatus: json['measurement_payment_status'] ?? 'pending',
      conveniencePaymentStatus: json['convenience_payment_status'] ?? 'pending',
      measurementTransactionId: json['measurement_transaction_id'],
      convenienceTransactionId: json['convenience_transaction_id'],
      measurementChalanPath: json['measurement_chalan_path'],
      convenienceChalanPath: json['convenience_chalan_path'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      measurementFee: json['measurement_fee'] ?? '0.00',
      convenienceFee: json['convenience_fee'] ?? '0.00',
    );
  }

  double get totalAmount {
    final measurement = double.tryParse(measurementFee) ?? 0.0;
    final convenience = double.tryParse(convenienceFee) ?? 0.0;
    return measurement + convenience;
  }

  bool get isMeasurementPaid => measurementPaymentStatus.toLowerCase() == 'paid';
  bool get isConveniencePaid => conveniencePaymentStatus.toLowerCase() == 'paid';
  bool get isFullyPaid => isMeasurementPaid && isConveniencePaid;
}