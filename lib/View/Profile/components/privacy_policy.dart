import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../Constants/color_constant.dart';
import '../../../Controller/get_translation_controller/get_text_form.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeFactor = 0.85;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const GetTranslatableText('Privacy & Security Policy'),
        backgroundColor: SetuColors.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            _buildHeader(sizeFactor),
            Gap(16.h * sizeFactor),
            _buildContent(sizeFactor),
            Gap(24.h * sizeFactor),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(double sizeFactor) {
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

          // Icon
          Container(
            width: 80.w * sizeFactor,
            height: 80.w * sizeFactor,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(
              PhosphorIcons.shieldCheck(PhosphorIconsStyle.fill),
              color: SetuColors.primaryGreen,
              size: 40.sp * sizeFactor,
            ),
          ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),

          Gap(16.h * sizeFactor),

          // Title
          GetTranslatableText(
            'Privacy & Security Policy',
            style: TextStyle(
              fontSize: 24.sp * sizeFactor,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),

          Gap(8.h * sizeFactor),

          // Last Updated Badge
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w * sizeFactor,
              vertical: 6.h * sizeFactor,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.r * sizeFactor),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  PhosphorIcons.calendarCheck(PhosphorIconsStyle.fill),
                  size: 14.sp * sizeFactor,
                  color: Colors.white,
                ),
                Gap(6.w * sizeFactor),
                Text(
                  'Last Updated: October 2025',
                  style: TextStyle(
                    fontSize: 12.sp * sizeFactor,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 100.ms, duration: 400.ms),

          Gap(24.h * sizeFactor),
        ],
      ),
    );
  }

  Widget _buildContent(double sizeFactor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w * sizeFactor),
      child: Column(
        children: [
          _buildWelcomeSection(sizeFactor),
          Gap(16.h * sizeFactor),
          _buildSection(
            'Privacy Policy for Uploaded Documents',
            null,
            PhosphorIcons.fileText(PhosphorIconsStyle.regular),
            sizeFactor,
            bulletPoints: [
              'Document Security: All attached documents and information will be secured through complex encryption technology, ensuring no unauthorized access, theft, or compromise.',
              'Purpose of Data Usage: Uploaded documents will be used only for processing applications and properly submitting them to relevant government websites. Information will not be shared with any third party or used for any other purpose.',
              'Access and Consent: No employee or third party will be given access to documents without the applicant\'s consent. Only authorized officers and processing staff will be given limited access rights.',
              'Data Retention Period: Attached documents will be retained until the required work is completed. After completion, provisions will be made for their secure destruction or data deletion upon customer request.',
              'Data Breach Response: In case of any information breach or security violation, applicants will be immediately notified and necessary technical, legal, and security measures will be taken.',
              'User Rights: Applicants will have the right to view, correct, and remove their uploaded documents as needed.',
              'Misuse Prevention: Attached documents will be used only for purposes specified in the agreement.',
            ],
            footerText: 'This privacy policy for uploaded documents will be clearly displayed to applicants in the app, and no process will be initiated without their consent.',
          ),
          Gap(16.h * sizeFactor),
          _buildContactSection(sizeFactor),
          Gap(16.h * sizeFactor),
          _buildConsentSection(sizeFactor),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection(double sizeFactor) {
    return Container(
      padding: EdgeInsets.all(16.w * sizeFactor),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            SetuColors.primaryGreen.withOpacity(0.1),
            SetuColors.primaryGreen.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r * sizeFactor),
        border: Border.all(
          color: SetuColors.primaryGreen.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            PhosphorIcons.shieldStar(PhosphorIconsStyle.fill),
            color: SetuColors.primaryGreen,
            size: 24.sp * sizeFactor,
          ),
          Gap(12.w * sizeFactor),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetTranslatableText(
                  'Welcome to Emojani',
                  style: TextStyle(
                    fontSize: 16.sp * sizeFactor,
                    fontWeight: FontWeight.bold,
                    color: SetuColors.primaryGreen,
                  ),
                ),
                Gap(8.h * sizeFactor),
                GetTranslatableText(
                  'Your privacy and data security are very important to us. This Privacy & Security Policy explains how we collect, use, protect, and handle your personal information when you use our app and services.',
                  style: TextStyle(
                    fontSize: 14.sp * sizeFactor,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildSection(
      String title,
      String? description,
      PhosphorIconData icon,
      double sizeFactor, {
        List<String>? bulletPoints,
        String? footerText,
      }) {
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
                  child: GetTranslatableText(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp * sizeFactor,
                      fontWeight: FontWeight.bold,
                      color: SetuColors.primaryGreen,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (description != null || bulletPoints != null || footerText != null)
            Divider(height: 1, color: Colors.grey[200]),
          if (description != null)
            Padding(
              padding: EdgeInsets.fromLTRB(
                16.w * sizeFactor,
                16.h * sizeFactor,
                16.w * sizeFactor,
                bulletPoints != null ? 8.h * sizeFactor : 16.h * sizeFactor,
              ),
              child: GetTranslatableText(
                description,
                style: TextStyle(
                  fontSize: 14.sp * sizeFactor,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
            ),
          if (bulletPoints != null)
            Padding(
              padding: EdgeInsets.fromLTRB(
                16.w * sizeFactor,
                description != null ? 0 : 16.h * sizeFactor,
                16.w * sizeFactor,
                footerText != null ? 8.h * sizeFactor : 16.h * sizeFactor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: bulletPoints.map((point) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h * sizeFactor),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 6.w * sizeFactor,
                          height: 6.w * sizeFactor,
                          margin: EdgeInsets.only(
                            top: 6.h * sizeFactor,
                            right: 12.w * sizeFactor,
                          ),
                          decoration: BoxDecoration(
                            color: SetuColors.primaryGreen,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: GetTranslatableText(
                            point,
                            style: TextStyle(
                              fontSize: 14.sp * sizeFactor,
                              color: Colors.grey[700],
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          if (footerText != null)
            Container(
              padding: EdgeInsets.all(16.w * sizeFactor),
              margin: EdgeInsets.fromLTRB(
                16.w * sizeFactor,
                0,
                16.w * sizeFactor,
                16.h * sizeFactor,
              ),
              decoration: BoxDecoration(
                color: SetuColors.primaryGreen.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12.r * sizeFactor),
                border: Border.all(
                  color: SetuColors.primaryGreen.withOpacity(0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    PhosphorIcons.info(PhosphorIconsStyle.fill),
                    color: SetuColors.primaryGreen,
                    size: 18.sp * sizeFactor,
                  ),
                  Gap(10.w * sizeFactor),
                  Expanded(
                    child: GetTranslatableText(
                      footerText,
                      style: TextStyle(
                        fontSize: 13.sp * sizeFactor,
                        color: SetuColors.primaryGreen,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0);
  }

  Widget _buildContactSection(double sizeFactor) {
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
                    PhosphorIcons.chatCircleDots(PhosphorIconsStyle.regular),
                    color: SetuColors.primaryGreen,
                    size: 20.sp * sizeFactor,
                  ),
                ),
                Gap(12.w * sizeFactor),
                Expanded(
                  child: GetTranslatableText(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 16.sp * sizeFactor,
                      fontWeight: FontWeight.bold,
                      color: SetuColors.primaryGreen,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey[200]),
          Padding(
            padding: EdgeInsets.all(16.w * sizeFactor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetTranslatableText(
                  'If you have any questions about this Privacy & Security Policy or our data protection practices, please contact us at:',
                  style: TextStyle(
                    fontSize: 14.sp * sizeFactor,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
                Gap(16.h * sizeFactor),
                _buildContactItem(
                  PhosphorIcons.envelope(PhosphorIconsStyle.regular),
                  'info@emojni.com',
                  sizeFactor,
                ),
                Gap(12.h * sizeFactor),
                _buildContactItem(
                  PhosphorIcons.phone(PhosphorIconsStyle.regular),
                  '7397-877740',
                  sizeFactor,
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0);
  }

  Widget _buildContactItem(PhosphorIconData icon, String text, double sizeFactor) {
    return Row(
      children: [
        Icon(
          icon,
          color: SetuColors.primaryGreen,
          size: 18.sp * sizeFactor,
        ),
        Gap(8.w * sizeFactor),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp * sizeFactor,
              color: Colors.grey[900],
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConsentSection(double sizeFactor) {
    return Container(
      padding: EdgeInsets.all(18.w * sizeFactor),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            SetuColors.primaryGreen,
            SetuColors.primaryGreen.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r * sizeFactor),
        boxShadow: [
          BoxShadow(
            color: SetuColors.primaryGreen.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w * sizeFactor),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r * sizeFactor),
            ),
            child: Icon(
              PhosphorIcons.handshake(PhosphorIconsStyle.fill),
              color: Colors.white,
              size: 28.sp * sizeFactor,
            ),
          ),
          Gap(14.w * sizeFactor),
          Expanded(
            child: GetTranslatableText(
              'By using Emojani, you agree to this Privacy & Security Policy and consent to the collection and use of your data as described above.',
              style: TextStyle(
                fontSize: 13.sp * sizeFactor,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms).scale(
      begin: const Offset(0.95, 0.95),
      end: const Offset(1, 1),
    );
  }
}