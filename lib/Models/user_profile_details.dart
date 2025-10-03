class UserProfileDetails {
  final int id;
  final int? siteleadId;
  final String username;
  final String fullName;
  final String email;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final String role;
  final int roleId;
  final String status;
  final String phoneNumber;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfileDetails({
    required this.id,
    this.siteleadId,
    required this.username,
    required this.fullName,
    required this.email,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.role,
    required this.roleId,
    required this.status,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfileDetails.fromJson(Map<String, dynamic> json) {
    return UserProfileDetails(
      id: json['id'] ?? 0,
      siteleadId: json['sitelead_id'],
      username: json['username'] ?? '',
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      isEmailVerified: json['is_email_verified'] ?? false,
      isPhoneVerified: json['is_phone_verified'] ?? false,
      role: json['role'] ?? '',
      roleId: json['role_id'] ?? 0,
      status: json['status'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sitelead_id': siteleadId,
      'username': username,
      'full_name': fullName,
      'email': email,
      'is_email_verified': isEmailVerified,
      'is_phone_verified': isPhoneVerified,
      'role': role,
      'role_id': roleId,
      'status': status,
      'phone_number': phoneNumber,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Helper method to get initials
  String getInitials() {
    if (fullName.isNotEmpty) {
      final names = fullName.trim().split(' ');
      if (names.length >= 2) {
        return '${names[0][0]}${names[1][0]}'.toUpperCase();
      }
      return fullName[0].toUpperCase();
    }
    return username.isNotEmpty ? username[0].toUpperCase() : 'U';
  }

  // Helper method to get display name
  String getDisplayName() {
    return fullName.isNotEmpty ? fullName : username;
  }

  // Helper method to get role display text
  String getRoleDisplayText() {
    return role[0].toUpperCase() + role.substring(1);
  }

  // Helper method to get status color
  bool isActive() {
    return status.toLowerCase() == 'active';
  }
}

class UserProfileResponse {
  final String message;
  final bool success;
  final UserProfileDetails? data;
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
          ? UserProfileDetails.fromJson(json['data'])
          : null,
      errors: json['errors'] ?? [],
    );
  }
}