class UserFormsSummary {
  final int userId;
  final int totalForms;
  final int totalVerified;
  final Map<String, FormBreakdown> formsBreakdown;

  UserFormsSummary({
    required this.userId,
    required this.totalForms,
    required this.totalVerified,
    required this.formsBreakdown,
  });

  factory UserFormsSummary.fromJson(Map<String, dynamic> json) {
    final breakdownData = json['forms_breakdown'] as Map<String, dynamic>;
    final Map<String, FormBreakdown> breakdown = {};

    breakdownData.forEach((key, value) {
      breakdown[key] = FormBreakdown.fromJson(value as Map<String, dynamic>);
    });

    return UserFormsSummary(
      userId: json['user_id'] as int,
      totalForms: json['total_forms'] as int,
      totalVerified: json['total_verified'] as int,
      formsBreakdown: breakdown,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'total_forms': totalForms,
      'total_verified': totalVerified,
      'forms_breakdown': formsBreakdown.map((key, value) => MapEntry(key, value.toJson())),
    };
  }

  double get verificationPercentage {
    if (totalForms == 0) return 0.0;
    return (totalVerified / totalForms) * 100;
  }

  int get pendingForms => totalForms - totalVerified;

  String getFormDisplayName(String key) {
    final Map<String, String> displayNames = {
      'counting_land': 'Counting Land',
      'bhusampadan_citizen': 'Bhusampadan Citizen',
      'court_land_details': 'Court Land Details',
      'court_vatap_citizen_application': 'Court Vatap Citizen',
      'shaskiya_mojni': 'Shaskiya Mojni',
    };
    return displayNames[key] ?? key.split('_').map((e) => e.capitalize()).join(' ');
  }
}

class FormBreakdown {
  final int total;
  final int verified;

  FormBreakdown({
    required this.total,
    required this.verified,
  });

  factory FormBreakdown.fromJson(Map<String, dynamic> json) {
    return FormBreakdown(
      total: json['total'] as int,
      verified: json['verified'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'verified': verified,
    };
  }

  int get pending => total - verified;

  double get verificationPercentage {
    if (total == 0) return 0.0;
    return (verified / total) * 100;
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}


class UserProfileResponse {
  final String message;
  final bool success;
  final UserFormsSummary? data;
  final List<dynamic> errors;

  UserProfileResponse({
    required this.message,
    required this.success,
    this.data,
    required this.errors,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      message: json['message'] ?? '',
      success: json['success'] ?? false,
      data: json['data'] != null
          ? UserFormsSummary.fromJson(json['data'])
          : null,
      errors: json['errors'] ?? [],
    );
  }
}