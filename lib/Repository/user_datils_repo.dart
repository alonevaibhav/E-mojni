import '../../API Service/api_service.dart';
import '../../Constants/api_constant.dart';
import '../../Models/user_profile_details.dart';

class UserProfileRepository {

  Future<UserProfileDetails> getUserProfile() async {
    try {
      // Get user ID
      String userId = (await ApiService.getUid()) ?? "0";
      print('🆔 User ID: $userId');

      // Make API call
      final response = await ApiService.get<UserProfileResponse>(
        endpoint: userProfileDetails(int.parse(userId)),
        fromJson: (json) => UserProfileResponse.fromJson(json),
        includeToken: true,
      );

      // Validate response
      if (response.success && response.data != null && response.data!.data != null) {
        return response.data!.data!;
      } else {
        throw Exception(response.errorMessage ?? 'Failed to load profile');
      }
    } catch (e) {
      throw Exception('Failed to fetch user profile: ${e.toString()}');
    }
  }

  Future<UserProfileDetails> refreshUserProfile() async {
    return await getUserProfile();
  }
}