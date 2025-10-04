import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../Constants/color_constant.dart';
import '../../../Controller/Profile/ProfileController/user_details_controller.dart';
import '../../../Controller/get_translation_controller/get_text_form.dart';
import '../../../Models/user_profile_details.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<UserDetailsController>();

    final sizeFactor = 0.85;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: GetTranslatableText('Profile Details'),
        backgroundColor: SetuColors.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(PhosphorIcons.arrowClockwise(PhosphorIconsStyle.regular)),
            onPressed: () => controller.refreshProfile(),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: controller.obx(
            (userProfile) => _buildProfileContent(userProfile!, sizeFactor),
        onLoading: _buildLoadingState(sizeFactor),
        onError: (error) => _buildErrorState(error ?? 'Unknown error', controller, sizeFactor),
        onEmpty: _buildEmptyState(sizeFactor),
      ),
    );
  }

  Widget _buildProfileContent(UserProfileDetails profile, double sizeFactor) {
    return RefreshIndicator(
      onRefresh: () => Get.find<UserDetailsController>().refreshProfile(),
      color: SetuColors.primaryGreen,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            _buildProfileHeader(profile, sizeFactor),
            Gap(16.h * sizeFactor),
            _buildProfileSections(profile, sizeFactor),
            Gap(24.h * sizeFactor),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(UserProfileDetails profile, double sizeFactor) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            SetuColors.primaryGreen,
            SetuColors.primaryGreen.withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        children: [
          Gap(24.h * sizeFactor),

          // Profile Avatar
          Container(
            width: 100.w * sizeFactor,
            height: 100.w * sizeFactor,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Text(
                profile.getInitials(),
                style: TextStyle(
                  fontSize: 36.sp * sizeFactor,
                  fontWeight: FontWeight.bold,
                  color: SetuColors.primaryGreen,
                ),
              ),
            ),
          ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),

          Gap(16.h * sizeFactor),

          // Name
          GetTranslatableText(
            profile.getDisplayName(),
            style: TextStyle(
              fontSize: 24.sp * sizeFactor,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),

          Gap(4.h * sizeFactor),

          // Username
          Text(
            '@${profile.username}',
            style: TextStyle(
              fontSize: 14.sp * sizeFactor,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ).animate().fadeIn(delay: 100.ms, duration: 400.ms),

          Gap(16.h * sizeFactor),

          // Status Badge
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w * sizeFactor,
              vertical: 6.h * sizeFactor,
            ),
            decoration: BoxDecoration(
              color: profile.isActive() ? Colors.green : Colors.orange,
              borderRadius: BorderRadius.circular(20.r * sizeFactor),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  profile.isActive()
                      ? PhosphorIcons.checkCircle(PhosphorIconsStyle.fill)
                      : PhosphorIcons.warningCircle(PhosphorIconsStyle.fill),
                  size: 16.sp * sizeFactor,
                  color: Colors.white,
                ),
                Gap(6.w * sizeFactor),
                Text(
                  profile.status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12.sp * sizeFactor,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

          Gap(24.h * sizeFactor),
        ],
      ),
    );
  }

  Widget _buildProfileSections(UserProfileDetails profile, double sizeFactor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w * sizeFactor),
      child: Column(
        children: [
          _buildSection(
            'Contact Information',
            [
              _buildInfoTile(
                PhosphorIcons.envelope(PhosphorIconsStyle.regular),
                'Email',
                profile.email,
                profile.isEmailVerified,
                sizeFactor,
              ),
              _buildInfoTile(
                PhosphorIcons.phone(PhosphorIconsStyle.regular),
                'Phone Number',
                profile.phoneNumber,
                profile.isPhoneVerified,
                sizeFactor,
              ),
            ],
            sizeFactor,
          ),

          Gap(16.h * sizeFactor),

          _buildSection(
            'Timeline',
            [
              _buildInfoTile(
                PhosphorIcons.calendarPlus(PhosphorIconsStyle.regular),
                'Account Created',
                _formatDate(profile.createdAt),
                null,
                sizeFactor,
              ),
              _buildInfoTile(
                PhosphorIcons.clockCounterClockwise(PhosphorIconsStyle.regular),
                'Last Updated',
                _formatDate(profile.updatedAt),
                null,
                sizeFactor,
              ),
            ],
            sizeFactor,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children, double sizeFactor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r * sizeFactor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w * sizeFactor),
            child: GetTranslatableText(
              title,
              style: TextStyle(
                fontSize: 16.sp * sizeFactor,
                fontWeight: FontWeight.bold,
                color: SetuColors.primaryGreen,
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey[200]),
          ...children,
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0);
  }

  Widget _buildInfoTile(
      PhosphorIconData icon,
      String label,
      String value,
      bool? isVerified,
      double sizeFactor,
      ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w * sizeFactor,
        vertical: 14.h * sizeFactor,
      ),
      child: Row(
        children: [
          Container(
            width: 40.w * sizeFactor,
            height: 40.w * sizeFactor,
            decoration: BoxDecoration(
              color: SetuColors.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r * sizeFactor),
            ),
            child: Icon(
              icon,
              color: SetuColors.primaryGreen,
              size: 20.sp * sizeFactor,
            ),
          ),
          Gap(12.w * sizeFactor),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetTranslatableText(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp * sizeFactor,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(2.h * sizeFactor),
                GetTranslatableText(
                  value,
                  style: TextStyle(
                    fontSize: 14.sp * sizeFactor,
                    color: Colors.grey[900],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (isVerified != null)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w * sizeFactor,
                vertical: 4.h * sizeFactor,
              ),
              decoration: BoxDecoration(
                color: isVerified
                    ? Colors.green.withOpacity(0.1)
                    : Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r * sizeFactor),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isVerified
                        ? PhosphorIcons.checkCircle(PhosphorIconsStyle.fill)
                        : PhosphorIcons.clock(PhosphorIconsStyle.fill),
                    size: 12.sp * sizeFactor,
                    color: isVerified ? Colors.green : Colors.orange,
                  ),
                  Gap(4.w * sizeFactor),
                  GetTranslatableText(
                    isVerified ? 'Verified' : 'Pending',
                    style: TextStyle(
                      fontSize: 10.sp * sizeFactor,
                      fontWeight: FontWeight.bold,
                      color: isVerified ? Colors.green : Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(double sizeFactor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(SetuColors.primaryGreen),
          ),
          Gap(16.h * sizeFactor),
          GetTranslatableText(
            'Loading profile...',
            style: TextStyle(
              fontSize: 14.sp * sizeFactor,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error, UserDetailsController controller, double sizeFactor) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w * sizeFactor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              PhosphorIcons.warningCircle(PhosphorIconsStyle.regular),
              size: 64.sp * sizeFactor,
              color: Colors.red,
            ),
            Gap(16.h * sizeFactor),
            GetTranslatableText(
              'Error Loading Profile',
              style: TextStyle(
                fontSize: 18.sp * sizeFactor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(8.h * sizeFactor),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp * sizeFactor,
                color: Colors.grey[600],
              ),
            ),
            Gap(24.h * sizeFactor),
            ElevatedButton.icon(
              onPressed: () => controller.refreshProfile(),
              icon: Icon(PhosphorIcons.arrowClockwise(PhosphorIconsStyle.regular)),
              label: const GetTranslatableText('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: SetuColors.primaryGreen,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w * sizeFactor,
                  vertical: 12.h * sizeFactor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(double sizeFactor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            PhosphorIcons.userCircle(PhosphorIconsStyle.regular),
            size: 64.sp * sizeFactor,
            color: Colors.grey,
          ),
          Gap(16.h * sizeFactor),
          GetTranslatableText(
            'No Profile Data',
            style: TextStyle(
              fontSize: 18.sp * sizeFactor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}