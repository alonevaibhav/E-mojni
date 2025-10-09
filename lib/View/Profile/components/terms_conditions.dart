import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
        title: const GetTranslatableText('Rules and Regulations'),
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
            'Rules and Regulations',
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
            'Application Submission Requirements',
            'Applicants must comply with the following requirements:',
            PhosphorIcons.clipboardText(PhosphorIconsStyle.regular),
            sizeFactor,
            bulletPoints: [
              'Submit a completed application form through the consultancy app with accurate details.',
              'Upload necessary supporting documents such as ownership papers, prior survey plans, and identity proof.',
              'Ensure all information provided is complete and authentic.',
              'Failure to provide accurate information or required documents may lead to rejection or delays in processing the land survey application.',
            ],
          ),
          Gap(16.h * sizeFactor),
          _buildSection(
            'Applicant Responsibilities',
            null,
            PhosphorIcons.userCheck(PhosphorIconsStyle.regular),
            sizeFactor,
            bulletPoints: [
              'Accuracy and Completeness: Fill out the application form accurately and completely, providing all required information truthfully. Any false or misleading information may result in rejection or legal action.',
              'Submission of Documents: Submit all necessary documents as prescribed by the government land survey authority. Incomplete submissions will not be processed.',
              'Authorization: Confirm that you are the rightful owner or authorized representative of the land and have legal authority to apply for the survey.',
              'Consent to Survey: By submitting the application, you consent to allow authorized survey officers access to the land for inspection, measurements, and demarcation.',
              'Information provided in the app must be complete, correct, and true. The applicant will be responsible for any incorrect information.',
            ],
          ),
          Gap(16.h * sizeFactor),
          _buildSection(
            'Consultancy Service Details',
            'Our consultancy services provide assistance in filling land survey applications on government websites. Service charges are mandatory for using our services.',
            PhosphorIcons.handshake(PhosphorIconsStyle.regular),
            sizeFactor,
          ),
          Gap(16.h * sizeFactor),
          _buildSection(
            'Service Provider Responsibilities',
            'As your consultancy service provider, we commit to:',
            PhosphorIcons.checkCircle(PhosphorIconsStyle.regular),
            sizeFactor,
            bulletPoints: [
              'Maintain appropriate systems for verifying the authenticity of applications.',
              'Present applicant information on government sites in a timely manner and according to regulations.',
              'Provide clear information about service terms, timelines, and charges.',
            ],
          ),
          Gap(16.h * sizeFactor),
          _buildSection(
            'Client Rights',
            'As our client, you have the following rights:',
            PhosphorIcons.scales(PhosphorIconsStyle.regular),
            sizeFactor,
            bulletPoints: [
              'Right to view, correct, or delete your data.',
              'Right to immediate notification in case of data breach.',
              'Access to an effective support system for questions and complaints.',
            ],
          ),
          Gap(16.h * sizeFactor),
          _buildSection(
            'Scope of Services',
            'Our consultancy services include:',
            PhosphorIcons.listChecks(PhosphorIconsStyle.regular),
            sizeFactor,
            bulletPoints: [
              'Filling and verifying application information in the consultancy app.',
              'Complete evaluation of the application and suggesting improvements.',
              'Submitting the application information to the government website.',
              'Providing inquiry assistance and technical support to applicants.',
              'Clarifying service opportunities, schedules, and service quality standards.',
              'Specifying what type of information is included in the service (e.g., application filling, document verification, follow-up).',
            ],
          ),
          Gap(16.h * sizeFactor),
          _buildSection(
            'Out of Scope Services',
            'The following services are NOT included in our consultancy:',
            PhosphorIcons.prohibit(PhosphorIconsStyle.regular),
            sizeFactor,
            bulletPoints: [
              'Interfering with or making government decisions.',
              'Providing any form of legal advice (unless specified in the agreement).',
              'Independent management of any other personal matters of the applicant.',
              'Budget or fund management services.',
            ],
            footerText: 'This information will be clearly explained to applicants and their consent will be obtained.',
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
            PhosphorIcons.info(PhosphorIconsStyle.fill),
            color: SetuColors.primaryGreen,
            size: 24.sp * sizeFactor,
          ),
          Gap(12.w * sizeFactor),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetTranslatableText(
                  'Rules and Regulations',
                  style: TextStyle(
                    fontSize: 16.sp * sizeFactor,
                    fontWeight: FontWeight.bold,
                    color: SetuColors.primaryGreen,
                  ),
                ),
                Gap(8.h * sizeFactor),
                GetTranslatableText(
                  'Please read these terms and conditions carefully before using our consultancy services. By submitting an application through our platform, you agree to comply with these rules and regulations.',
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
                  'If you have any questions about these Terms & Conditions or need assistance, please contact us at:',
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
              PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
              color: Colors.white,
              size: 28.sp * sizeFactor,
            ),
          ),
          Gap(14.w * sizeFactor),
          Expanded(
            child: GetTranslatableText(
              'By using Emojani services, you acknowledge that you have read, understood, and agree to be bound by these Terms & Conditions.',
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