import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Constants/color_constant.dart';

class GovLink extends StatelessWidget {
  const GovLink({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeFactor = 0.85;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Government Services'),
        backgroundColor: SetuColors.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(PhosphorIcons.info(PhosphorIconsStyle.regular)),
            onPressed: () => _showInfoDialog(context),
            tooltip: 'Information',
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            _buildHeader(sizeFactor),
            Gap(16.h * sizeFactor),
            _buildServicesList(sizeFactor),
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
    color: SetuColors.primaryGreen,
      ),
      child: Column(
        children: [
          Gap(24.h * sizeFactor),
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
              PhosphorIcons.buildings(PhosphorIconsStyle.fill),
              size: 40.sp * sizeFactor,
              color: const Color(0xFF2E7D32),
            ),
          ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
          Gap(16.h * sizeFactor),
          Text(
            'Maharashtra Government',
            style: TextStyle(
              fontSize: 22.sp * sizeFactor,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),
          Gap(4.h * sizeFactor),
          Text(
            'Digital Land Records & Services',
            style: TextStyle(
              fontSize: 13.sp * sizeFactor,
              color: Colors.white.withOpacity(0.9),
            ),
          ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
          Gap(24.h * sizeFactor),
        ],
      ),
    );
  }

  Widget _buildServicesList(double sizeFactor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w * sizeFactor),
      child: Column(
        children: [
          _buildSection(
            'Land Records',
            [
              _buildServiceTile(
                PhosphorIcons.fileText(PhosphorIconsStyle.regular),
                'Online Digital 7/12',
                'Digital Satbara - Land Records',
                'https://digitalsatbara.mahabhumi.gov.in/dslr',
                sizeFactor,
              ),
              _buildServiceTile(
                PhosphorIcons.downloadSimple(PhosphorIconsStyle.regular),
                'Offline 7/12 Download',
                'Bhulekh - Download Land Records',
                'https://bhulekh.mahabhumi.gov.in/',
                sizeFactor,
              ),
              _buildServiceTile(
                PhosphorIcons.addressBook(PhosphorIconsStyle.regular),
                'Online Land Map',
                'Maharashtra Land Map Portal',
                'https://mahabhunakasha.mahabhumi.gov.in/27/index.html',
                sizeFactor,
              ),
              _buildServiceTile(
                PhosphorIcons.folder(PhosphorIconsStyle.regular),
                'E-Record & E-Rights System',
                'Property Documentation System',
                'https://pdeigr.maharashtra.gov.in/',
                sizeFactor,
              ),
              _buildServiceTile(
                PhosphorIcons.newspaper(PhosphorIconsStyle.regular),
                'Property Card',
                'E-Property Card Download',
                'https://bhumiabhilekh.maharashtra.gov.in/Services/PropertyCardDownload',
                sizeFactor,
              ),
            ],
            sizeFactor,
          ),
          Gap(16.h * sizeFactor),
          _buildSection(
            'Legal & Valuation',
            [
              _buildServiceTile(
                PhosphorIcons.scales(PhosphorIconsStyle.regular),
                'Court Cases Search',
                'Search Related Court Cases',
                'https://eqjcourts.gov.in/startup/default.php',
                sizeFactor,
              ),
              _buildServiceTile(
                PhosphorIcons.currencyInr(PhosphorIconsStyle.regular),
                'Plot Valuation',
                'Property Valuation System',
                'https://igreval.maharashtra.gov.in/valuation',
                sizeFactor,
              ),
              _buildServiceTile(
                PhosphorIcons.stamp(PhosphorIconsStyle.regular),
                'Registration Services',
                'IGR Maharashtra Portal',
                'https://igrmaharashtra.gov.in/Home',
                sizeFactor,
              ),
            ],
            sizeFactor,
          ),
          Gap(16.h * sizeFactor),
          _buildSection(
            'Official Documents',
            [
              _buildServiceTile(
                PhosphorIcons.book(PhosphorIconsStyle.regular),
                'Maharashtra Gazette',
                'Government Gazette Search',
                'https://egazzete.mahaonline.gov.in/Forms/GazetteSearch.aspx',
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
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16.sp * sizeFactor,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2E7D32),
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey[200]),
          ...children,
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0);
  }

  Widget _buildServiceTile(
      PhosphorIconData icon,
      String title,
      String description,
      String url,
      double sizeFactor,
      ) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w * sizeFactor,
          vertical: 14.h * sizeFactor,
        ),
        child: Row(
          children: [
            Container(
              width: 48.w * sizeFactor,
              height: 48.w * sizeFactor,
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r * sizeFactor),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF2E7D32),
                size: 24.sp * sizeFactor,
              ),
            ),
            Gap(12.w * sizeFactor),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp * sizeFactor,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[900],
                    ),
                  ),
                  Gap(2.h * sizeFactor),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12.sp * sizeFactor,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              PhosphorIcons.arrowSquareOut(PhosphorIconsStyle.regular),
              size: 20.sp * sizeFactor,
              color: const Color(0xFF2E7D32),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String urlString) async {
    try {
      final Uri url = Uri.parse(urlString);

      // Try launching with different modes
      bool launched = false;

      // Try external application first
      try {
        launched = await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } catch (e) {
        debugPrint('External app launch failed: $e');
      }

      // If external fails, try platform default
      if (!launched) {
        try {
          launched = await launchUrl(
            url,
            mode: LaunchMode.platformDefault,
          );
        } catch (e) {
          debugPrint('Platform default launch failed: $e');
        }
      }

      // If both fail, try external non-browser mode
      if (!launched) {
        try {
          launched = await launchUrl(
            url,
            mode: LaunchMode.externalNonBrowserApplication,
          );
        } catch (e) {
          debugPrint('External non-browser launch failed: $e');
        }
      }

      if (!launched) {
        debugPrint('Could not launch $urlString');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              PhosphorIcons.info(PhosphorIconsStyle.fill),
              color: const Color(0xFF2E7D32),
            ),
            const Gap(8),
            const Text('Information'),
          ],
        ),
        content: const Text(
          'These are official Maharashtra Government portals for accessing land records, property information, and related services. Tap any service to open it in your browser.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Got it',
              style: TextStyle(color: Color(0xFF2E7D32)),
            ),
          ),
        ],
      ),
    );
  }
}