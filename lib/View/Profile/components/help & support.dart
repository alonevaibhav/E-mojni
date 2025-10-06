import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../Constants/color_constant.dart';
import '../../../Controller/get_translation_controller/get_text_form.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeFactor = 0.85;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const GetTranslatableText('Help & Support'),
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
              PhosphorIcons.headset(PhosphorIconsStyle.fill),
              color: SetuColors.primaryGreen,
              size: 40.sp * sizeFactor,
            ),
          ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),

          Gap(16.h * sizeFactor),

          // Title
          GetTranslatableText(
            'Help & Support',
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
              'We\'re here to help you every step of the way',
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
          _buildHowWeCanHelpSection(sizeFactor),
          Gap(16.h * sizeFactor),
          _buildFAQSection(sizeFactor),
          Gap(16.h * sizeFactor),
          _buildContactSection(sizeFactor),
          Gap(16.h * sizeFactor),
          _buildFeedbackSection(sizeFactor),
          Gap(16.h * sizeFactor),
          _buildClosingSection(sizeFactor),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection(double sizeFactor) {
    return Container(
      padding: EdgeInsets.all(18.w * sizeFactor),
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
        children: [
          Container(
            padding: EdgeInsets.all(10.w * sizeFactor),
            decoration: BoxDecoration(
              color: SetuColors.primaryGreen.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12.r * sizeFactor),
            ),
            child: Icon(
              PhosphorIcons.handWaving(PhosphorIconsStyle.fill),
              color: SetuColors.primaryGreen,
              size: 28.sp * sizeFactor,
            ),
          ),
          Gap(14.w * sizeFactor),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetTranslatableText(
                  'Welcome to Emojani Help & Support!',
                  style: TextStyle(
                    fontSize: 16.sp * sizeFactor,
                    fontWeight: FontWeight.bold,
                    color: SetuColors.primaryGreen,
                  ),
                ),
                Gap(4.h * sizeFactor),
                GetTranslatableText(
                  'We\'re here to assist you with any questions or issues while using Emojani.',
                  style: TextStyle(
                    fontSize: 13.sp * sizeFactor,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildHowWeCanHelpSection(double sizeFactor) {
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
                    PhosphorIcons.lifebuoy(PhosphorIconsStyle.regular),
                    color: SetuColors.primaryGreen,
                    size: 20.sp * sizeFactor,
                  ),
                ),
                Gap(12.w * sizeFactor),
                Expanded(
                  child: GetTranslatableText(
                    '1. How We Can Help',
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
                  'Our support team can assist you with:',
                  style: TextStyle(
                    fontSize: 14.sp * sizeFactor,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
                Gap(12.h * sizeFactor),
                ...[
                  'Guidance on how to submit your government service applications through Emojani.',
                  'Help with uploading or correcting your documents.',
                  'Status updates or clarifications about your submitted applications.',
                  'Technical issues such as login errors, payment problems, or app crashes.',
                  'General questions about how Emojani works.',
                ].map((point) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h * sizeFactor),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                        color: SetuColors.primaryGreen,
                        size: 18.sp * sizeFactor,
                      ),
                      Gap(10.w * sizeFactor),
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
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0);
  }

  Widget _buildFAQSection(double sizeFactor) {
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
                    PhosphorIcons.question(PhosphorIconsStyle.regular),
                    color: SetuColors.primaryGreen,
                    size: 20.sp * sizeFactor,
                  ),
                ),
                Gap(12.w * sizeFactor),
                Expanded(
                  child: GetTranslatableText(
                    '2. Common FAQs',
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
                _buildFAQItem(
                  'Is Emojani a government app?',
                  'No. Emojani is an independent third-party platform that helps users submit applications for government services. We are not affiliated with any government department.',
                  sizeFactor,
                ),
                Gap(16.h * sizeFactor),
                _buildFAQItem(
                  'How long does it take to process my application?',
                  'Processing time varies depending on the type of service and the respective government department.',
                  sizeFactor,
                ),
                Gap(16.h * sizeFactor),
                _buildFAQItem(
                  'What should I do if I entered the wrong details?',
                  'You can contact our support team immediately with your registered email or phone number. We\'ll guide you on how to correct it before submission.',
                  sizeFactor,
                ),
                Gap(16.h * sizeFactor),
                _buildFAQItem(
                  'Are my documents safe?',
                  'Yes. All documents and personal details are stored securely and used only for processing your application.',
                  sizeFactor,
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0);
  }

  Widget _buildFAQItem(String question, String answer, double sizeFactor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(4.w * sizeFactor),
              decoration: BoxDecoration(
                color: SetuColors.primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6.r * sizeFactor),
              ),
              child: Text(
                'Q',
                style: TextStyle(
                  fontSize: 12.sp * sizeFactor,
                  fontWeight: FontWeight.bold,
                  color: SetuColors.primaryGreen,
                ),
              ),
            ),
            Gap(10.w * sizeFactor),
            Expanded(
              child: GetTranslatableText(
                question,
                style: TextStyle(
                  fontSize: 14.sp * sizeFactor,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
        Gap(8.h * sizeFactor),
        Padding(
          padding: EdgeInsets.only(left: 32.w * sizeFactor),
          child: GetTranslatableText(
            answer,
            style: TextStyle(
              fontSize: 13.sp * sizeFactor,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ),
      ],
    );
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
                    '3. Contact Our Support Team',
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
                  'If you need help, please reach out to us through any of the following channels:',
                  style: TextStyle(
                    fontSize: 14.sp * sizeFactor,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
                Gap(16.h * sizeFactor),
                _buildContactMethodTile(
                  PhosphorIcons.envelope(PhosphorIconsStyle.fill),
                  'Email',
                  '[your-support@email.com]',
                  Colors.blue,
                  sizeFactor,
                ),
                Gap(12.h * sizeFactor),
                _buildContactMethodTile(
                  PhosphorIcons.phone(PhosphorIconsStyle.fill),
                  'Phone',
                  '[your helpline number]',
                  Colors.green,
                  sizeFactor,
                ),
                Gap(12.h * sizeFactor),
                _buildContactMethodTile(
                  PhosphorIcons.chatCentered(PhosphorIconsStyle.fill),
                  'Chat Support',
                  'Available in the Emojani app (under "Support" section)',
                  Colors.purple,
                  sizeFactor,
                ),
                Gap(12.h * sizeFactor),
                _buildContactMethodTile(
                  PhosphorIcons.clock(PhosphorIconsStyle.fill),
                  'Support Hours',
                  'Monday – Saturday, 9:00 AM to 6:00 PM (IST)',
                  Colors.orange,
                  sizeFactor,
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0);
  }

  Widget _buildContactMethodTile(
      PhosphorIconData icon,
      String title,
      String value,
      Color color,
      double sizeFactor,
      ) {
    return Container(
      padding: EdgeInsets.all(12.w * sizeFactor),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r * sizeFactor),
        border: Border.all(
          color: color.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w * sizeFactor,
            height: 36.w * sizeFactor,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8.r * sizeFactor),
            ),
            child: Icon(
              icon,
              color: color,
              size: 18.sp * sizeFactor,
            ),
          ),
          Gap(12.w * sizeFactor),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetTranslatableText(
                  title,
                  style: TextStyle(
                    fontSize: 13.sp * sizeFactor,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Gap(2.h * sizeFactor),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12.sp * sizeFactor,
                    color: Colors.grey[700],
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackSection(double sizeFactor) {
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
                    PhosphorIcons.lightbulb(PhosphorIconsStyle.regular),
                    color: SetuColors.primaryGreen,
                    size: 20.sp * sizeFactor,
                  ),
                ),
                Gap(12.w * sizeFactor),
                Expanded(
                  child: GetTranslatableText(
                    '4. Feedback & Suggestions',
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
                Row(
                  children: [
                    Icon(
                      PhosphorIcons.heart(PhosphorIconsStyle.fill),
                      color: Colors.red,
                      size: 20.sp * sizeFactor,
                    ),
                    Gap(8.w * sizeFactor),
                    Expanded(
                      child: GetTranslatableText(
                        'We value your feedback!',
                        style: TextStyle(
                          fontSize: 14.sp * sizeFactor,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[900],
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(12.h * sizeFactor),
                GetTranslatableText(
                  'If you have ideas or suggestions to improve Emojani, please share them with us via email. Your input helps us serve you better.',
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
    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0);
  }

  Widget _buildClosingSection(double sizeFactor) {
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
      child: Column(
        children: [
          Icon(
            PhosphorIcons.sealCheck(PhosphorIconsStyle.fill),
            color: Colors.white,
            size: 40.sp * sizeFactor,
          ),
          Gap(12.h * sizeFactor),
          GetTranslatableText(
            'We\'re committed to making your experience with Emojani smooth, secure, and reliable.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp * sizeFactor,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          Gap(12.h * sizeFactor),
          GetTranslatableText(
            'Thank you for choosing Emojani for your government service applications!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp * sizeFactor,
              color: Colors.white.withOpacity(0.9),
              height: 1.4,
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