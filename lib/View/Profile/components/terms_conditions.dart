import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../Constants/color_constant.dart';
import '../../../Controller/get_translation_controller/get_text_form.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeFactor = 0.85;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const GetTranslatableText('Terms & Conditions'),
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
              PhosphorIcons.fileText(PhosphorIconsStyle.fill),
              color: SetuColors.primaryGreen,
              size: 40.sp * sizeFactor,
            ),
          ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),

          Gap(16.h * sizeFactor),

          // Title
          GetTranslatableText(
            'Terms and Conditions',
            style: TextStyle(
              fontSize: 24.sp * sizeFactor,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),

          Gap(8.h * sizeFactor),

          // Subtitle
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w * sizeFactor),
            child: GetTranslatableText(
              'Please read carefully before using our services',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp * sizeFactor,
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w400,
              ),
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
            '1. About Our Service',
            'Emojni is a third-party platform that helps users submit their applications for various government services. We are not a government department, agency, or official portal. Our role is limited to assisting users with form filling, document submission, and application tracking as per available public processes.',
            PhosphorIcons.info(PhosphorIconsStyle.regular),
            sizeFactor,
          ),
          Gap(16.h * sizeFactor),
          _buildSection(
            '2. User Responsibility',
            null,
            PhosphorIcons.userCheck(PhosphorIconsStyle.regular),
            sizeFactor,
            bulletPoints: [
              'You agree that all information and documents you provide are accurate, complete, and genuine.',
              'You are solely responsible for any incorrect or false information submitted.',
              'You understand that submission through our app does not guarantee approval of any government service or benefit.',
            ],
          ),
          Gap(16.h * sizeFactor),
          _buildSection(
            '3. Service Charges',
            'Our platform may charge a service or processing fee for assisting with applications. These charges are for our facilitation service only and are not government fees.',
            PhosphorIcons.currencyCircleDollar(PhosphorIconsStyle.regular),
            sizeFactor,
          ),
          Gap(16.h * sizeFactor),
          _buildSection(
            '4. Data Privacy',
            'We take your privacy seriously. All personal data and documents provided will be used only for application processing and will not be shared with unauthorized third parties, except as required to complete your request or by law. Please refer to our Privacy Policy for more details.',
            PhosphorIcons.lock(PhosphorIconsStyle.regular),
            sizeFactor,
          ),
          Gap(16.h * sizeFactor),
          _buildSection(
            '5. No Guarantee or Liability',
            'While we strive to provide accurate and timely service:',
            PhosphorIcons.shieldWarning(PhosphorIconsStyle.regular),
            sizeFactor,
            bulletPoints: [
              'We are not responsible for delays, rejections, or errors caused by government authorities.',
              'We do not guarantee approval or acceptance of any application.',
              'We are not liable for losses, damages, or delays arising from the use of our platform.',
            ],
          ),
          Gap(16.h * sizeFactor),
          _buildSection(
            '6. Changes to Terms',
            'We may update or modify these Terms at any time. Continued use of the app after changes means you accept the updated Terms.',
            PhosphorIcons.clockCounterClockwise(PhosphorIconsStyle.regular),
            sizeFactor,
          ),
          Gap(16.h * sizeFactor),
          _buildContactSection(sizeFactor),
          Gap(16.h * sizeFactor),
          _buildAcceptanceSection(sizeFactor),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection(double sizeFactor) {
    return Container(
      padding: EdgeInsets.all(16.w * sizeFactor),
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
          Row(
            children: [
              Icon(
                PhosphorIcons.handWaving(PhosphorIconsStyle.fill),
                color: SetuColors.primaryGreen,
                size: 24.sp * sizeFactor,
              ),
              Gap(8.w * sizeFactor),
              Expanded(
                child: GetTranslatableText(
                  'Welcome to Emojni',
                  style: TextStyle(
                    fontSize: 16.sp * sizeFactor,
                    fontWeight: FontWeight.bold,
                    color: SetuColors.primaryGreen,
                  ),
                ),
              ),
            ],
          ),
          Gap(12.h * sizeFactor),
          GetTranslatableText(
            'By using our application or submitting any application for government services through our platform, you agree to the following Terms and Conditions. Please read them carefully before using our services.',
            style: TextStyle(
              fontSize: 14.sp * sizeFactor,
              color: Colors.grey[700],
              height: 1.5,
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
          if (description != null || bulletPoints != null)
            Divider(height: 1, color: Colors.grey[200]),
          if (description != null)
            Padding(
              padding: EdgeInsets.all(16.w * sizeFactor),
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
              padding: EdgeInsets.all(16.w * sizeFactor),
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
                    '7. Contact Us',
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
                  'If you have any questions about these Terms, please contact us at:',
                  style: TextStyle(
                    fontSize: 14.sp * sizeFactor,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
                Gap(16.h * sizeFactor),
                _buildContactItem(
                  PhosphorIcons.envelope(PhosphorIconsStyle.regular),
                  '[Your Email Address]',
                  sizeFactor,
                ),
                Gap(12.h * sizeFactor),
                _buildContactItem(
                  PhosphorIcons.phone(PhosphorIconsStyle.regular),
                  '[Your Contact Number]',
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

  Widget _buildAcceptanceSection(double sizeFactor) {
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
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            PhosphorIcons.sealCheck(PhosphorIconsStyle.fill),
            color: SetuColors.primaryGreen,
            size: 24.sp * sizeFactor,
          ),
          Gap(12.w * sizeFactor),
          Expanded(
            child: GetTranslatableText(
              'By using our app, you confirm that you have read, understood, and agreed to these Terms and Conditions.',
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
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms).scale(
      begin: const Offset(0.95, 0.95),
      end: const Offset(1, 1),
    );
  }
}