import 'package:get/get.dart';
import '../../../Models/user_profile_details.dart';
import '../../../Repository/user_datils_repo.dart';

class UserDetailsController extends GetxController with StateMixin<UserProfileDetails> {
  final UserProfileRepository _repository = UserProfileRepository();

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  /// Fetch user profile from repository
  Future<void> fetchUserProfile() async {
    try {
      change(null, status: RxStatus.loading());

      final userProfile = await _repository.getUserProfile();

      change(userProfile, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error('An error occurred: ${e.toString()}'));
    }
  }

  /// Refresh user profile
  Future<void> refreshProfile() async {
    await fetchUserProfile();
  }
}