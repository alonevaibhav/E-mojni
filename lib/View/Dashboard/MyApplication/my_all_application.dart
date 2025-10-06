// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
// import 'package:gap/gap.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:get/get.dart';
// import '../../../Constants/color_constant.dart';
// import '../../../Controller/Dashboard/MyApplication/get_my_application_controller.dart';
// import '../../../Controller/get_translation_controller/get_text_form.dart';
// import '../../../Models/my_application_model.dart';
// import '../../../State/ui_state_manegment.dart';
//
// class MyAllApplication extends StatelessWidget {
//   const MyAllApplication({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(UserFormsController());
//     final sizeFactor = 0.85;
//
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         title: const GetTranslatableText('My Applications'),
//         backgroundColor: SetuColors.primaryGreen,
//         foregroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: controller.obx(
//         (formsSummary) => _buildFormsContent(formsSummary!, sizeFactor),
//         onLoading: CommonStateWidgets.loading(
//           message: 'Loading applications...',
//           sizeFactor: sizeFactor,
//         ),
//         onError: (error) => CommonStateWidgets.error(
//           error: error ?? 'Unknown error',
//           title: 'Error Loading Applications',
//           onRetry: () => controller.refreshForms(),
//           sizeFactor: sizeFactor,
//         ),
//         onEmpty: CommonStateWidgets.empty(
//           title: 'No Applications Yet',
//           message: 'You haven\'t submitted any applications yet',
//           sizeFactor: sizeFactor,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFormsContent(UserFormsSummary summary, double sizeFactor) {
//     return RefreshIndicator(
//       onRefresh: () => Get.find<UserFormsController>().refreshForms(),
//       color: SetuColors.primaryGreen,
//       child: SingleChildScrollView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         child: Column(
//           children: [
//             _buildSummaryHeader(summary, sizeFactor),
//             Gap(16.h * sizeFactor),
//             _buildFormsBreakdown(summary, sizeFactor),
//             Gap(24.h * sizeFactor),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSummaryHeader(UserFormsSummary summary, double sizeFactor) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             SetuColors.primaryGreen,
//             SetuColors.primaryGreen.withOpacity(0.8),
//           ],
//         ),
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(24.w * sizeFactor),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildStatCard(
//                     icon: PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
//                     label: 'Verified',
//                     value: '${summary.totalVerified}',
//                     color: Colors.green,
//                     sizeFactor: sizeFactor,
//                   ),
//                 ),
//                 Gap(12.w * sizeFactor),
//                 Expanded(
//                   child: _buildStatCard(
//                     icon: PhosphorIcons.clock(PhosphorIconsStyle.fill),
//                     label: 'Pending',
//                     value: '${summary.pendingForms}',
//                     color: Colors.orange,
//                     sizeFactor: sizeFactor,
//                   ),
//                 ),
//               ],
//             ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
//
//             // Progress Bar
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStatCard({
//     required PhosphorIconData icon,
//     required String label,
//     required String value,
//     required Color color,
//     required double sizeFactor,
//   }) {
//     return Container(
//       padding: EdgeInsets.all(16.w * sizeFactor),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.r * sizeFactor),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Icon(
//             icon,
//             color: color,
//             size: 28.sp * sizeFactor,
//           ),
//           Gap(8.h * sizeFactor),
//           GetTranslatableText(
//             value,
//             style: TextStyle(
//               fontSize: 24.sp * sizeFactor,
//               fontWeight: FontWeight.bold,
//               color: color,
//             ),
//           ),
//           Gap(4.h * sizeFactor),
//           GetTranslatableText(
//             label,
//             style: TextStyle(
//               fontSize: 11.sp * sizeFactor,
//               color: Colors.grey[600],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFormsBreakdown(UserFormsSummary summary, double sizeFactor) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.w * sizeFactor),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ...summary.formsBreakdown.entries.map((entry) {
//             return Padding(
//               padding: EdgeInsets.only(bottom: 12.h * sizeFactor),
//               child: _buildFormCard(
//                 formKey: entry.key,
//                 formName: summary.getFormDisplayName(entry.key),
//                 breakdown: entry.value,
//                 sizeFactor: sizeFactor,
//                 controller: Get.find<UserFormsController>(),
//
//               ),
//             );
//           }),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFormCard({
//     required String formKey,
//     required String formName,
//     required FormBreakdown breakdown,
//     required double sizeFactor,
//     required controller,
//   }) {
//     final IconData formIcon = controller.getFormIcon(formKey);
//
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r * sizeFactor),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(16.w * sizeFactor),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   width: 48.w * sizeFactor,
//                   height: 48.w * sizeFactor,
//                   decoration: BoxDecoration(
//                     color: SetuColors.primaryGreen.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12.r * sizeFactor),
//                   ),
//                   child: Icon(
//                     formIcon,
//                     color: SetuColors.primaryGreen,
//                     size: 24.sp * sizeFactor,
//                   ),
//                 ),
//                 Gap(12.w * sizeFactor),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       GetTranslatableText(
//                         formName,
//                         style: TextStyle(
//                           fontSize: 15.sp * sizeFactor,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey[900],
//                         ),
//                       ),
//                       Gap(4.h * sizeFactor),
//                       GetTranslatableText(
//                         '${breakdown.total} total applications',
//                         style: TextStyle(
//                           fontSize: 12.sp * sizeFactor,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Icon(
//                   PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
//                   color: Colors.grey[400],
//                   size: 20.sp * sizeFactor,
//                 ),
//               ],
//             ),
//
//             Gap(20.h * sizeFactor),
//
//             // Stats Row
//             Row(
//               children: [
//                 _buildSmallStat(
//                   icon: PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
//                   label: 'Verified',
//                   value: '${breakdown.verified}',
//                   color: Colors.green,
//                   sizeFactor: sizeFactor,
//                 ),
//                 Gap(16.w * sizeFactor),
//                 _buildSmallStat(
//                   icon: PhosphorIcons.clock(PhosphorIconsStyle.fill),
//                   label: 'Pending',
//                   value: '${breakdown.pending}',
//                   color: Colors.orange,
//                   sizeFactor: sizeFactor,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0);
//   }
//
//   Widget _buildSmallStat({
//     required PhosphorIconData icon,
//     required String label,
//     required String value,
//     required Color color,
//     required double sizeFactor,
//   }) {
//     return Row(
//       children: [
//         Icon(
//           icon,
//           color: color,
//           size: 14.sp * sizeFactor,
//         ),
//         Gap(6.w * sizeFactor),
//         GetTranslatableText(
//           '$value $label',
//           style: TextStyle(
//             fontSize: 12.sp * sizeFactor,
//             color: Colors.grey[700],
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../Constants/color_constant.dart';
import '../../../Controller/Dashboard/MyApplication/get_my_application_controller.dart';
import '../../../Controller/get_translation_controller/get_text_form.dart';
import '../../../Models/my_application_model.dart';
import '../../../Route Manager/app_routes.dart';
import '../../../State/ui_state_manegment.dart';

class MyAllApplication extends StatelessWidget {
  const MyAllApplication({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserFormsController());
    final sizeFactor = 0.85;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const GetTranslatableText('My Applications'),
        backgroundColor: SetuColors.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: controller.obx((formsSummary) => _buildFormsContent(formsSummary!, sizeFactor),
        onLoading: CommonStateWidgets.loading(
          message: 'Loading applications...',
          sizeFactor: sizeFactor,
        ),
        onError: (error) => CommonStateWidgets.error(
          error: error ?? 'Unknown error',
          title: 'Error Loading Applications',
          onRetry: () => controller.refreshForms(),
          sizeFactor: sizeFactor,
        ),
        onEmpty: CommonStateWidgets.empty(
          title: 'No Applications Yet',
          message: 'You haven\'t submitted any applications yet',
          sizeFactor: sizeFactor,
        ),
      ),
    );
  }

  Widget _buildFormsContent(UserFormsSummary summary, double sizeFactor) {
    return RefreshIndicator(
      onRefresh: () => Get.find<UserFormsController>().refreshForms(),
      color: SetuColors.primaryGreen,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            _buildSummaryHeader(summary, sizeFactor),
            Gap(16.h * sizeFactor),
            _buildFormsBreakdown(summary, sizeFactor),
            Gap(24.h * sizeFactor),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryHeader(UserFormsSummary summary, double sizeFactor) {
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
      child: Padding(
        padding: EdgeInsets.all(24.w * sizeFactor),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    icon: PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                    label: 'Verified',
                    value: '${summary.totalVerified}',
                    color: Colors.green,
                    sizeFactor: sizeFactor,
                  ),
                ),
                Gap(12.w * sizeFactor),
                Expanded(
                  child: _buildStatCard(
                    icon: PhosphorIcons.clock(PhosphorIconsStyle.fill),
                    label: 'Pending',
                    value: '${summary.pendingForms}',
                    color: Colors.orange,
                    sizeFactor: sizeFactor,
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required PhosphorIconData icon,
    required String label,
    required String value,
    required Color color,
    required double sizeFactor,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w * sizeFactor),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r * sizeFactor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 28.sp * sizeFactor,
          ),
          Gap(8.h * sizeFactor),
          GetTranslatableText(
            value,
            style: TextStyle(
              fontSize: 24.sp * sizeFactor,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Gap(4.h * sizeFactor),
          GetTranslatableText(
            label,
            style: TextStyle(
              fontSize: 11.sp * sizeFactor,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormsBreakdown(UserFormsSummary summary, double sizeFactor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w * sizeFactor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...summary.formsBreakdown.entries.map((entry) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h * sizeFactor),
              child: _buildFormCard(
                formKey: entry.key,
                formName: summary.getFormDisplayName(entry.key),
                breakdown: entry.value,
                sizeFactor: sizeFactor,
                controller: Get.find<UserFormsController>(),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFormCard({
    required String formKey,
    required String formName,
    required FormBreakdown breakdown,
    required double sizeFactor,
    required controller,
  }) {
    final IconData formIcon = controller.getFormIcon(formKey);

    return InkWell(
      onTap: () {
        // Navigate to form details with the formKey
        _navigateToFormDetails(formKey, formName);
      },
      borderRadius: BorderRadius.circular(16.r * sizeFactor),
      child: Container(
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
        child: Padding(
          padding: EdgeInsets.all(16.w * sizeFactor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48.w * sizeFactor,
                    height: 48.w * sizeFactor,
                    decoration: BoxDecoration(
                      color: SetuColors.primaryGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r * sizeFactor),
                    ),
                    child: Icon(
                      formIcon,
                      color: SetuColors.primaryGreen,
                      size: 24.sp * sizeFactor,
                    ),
                  ),
                  Gap(12.w * sizeFactor),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GetTranslatableText(
                          formName,
                          style: TextStyle(
                            fontSize: 15.sp * sizeFactor,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[900],
                          ),
                        ),
                        Gap(4.h * sizeFactor),
                        GetTranslatableText(
                          '${breakdown.total} total applications',
                          style: TextStyle(
                            fontSize: 12.sp * sizeFactor,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
                    color: Colors.grey[400],
                    size: 20.sp * sizeFactor,
                  ),
                ],
              ),
              Gap(20.h * sizeFactor),
              Row(
                children: [
                  _buildSmallStat(
                    icon: PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                    label: 'Verified',
                    value: '${breakdown.verified}',
                    color: Colors.green,
                    sizeFactor: sizeFactor,
                  ),
                  Gap(16.w * sizeFactor),
                  _buildSmallStat(
                    icon: PhosphorIcons.clock(PhosphorIconsStyle.fill),
                    label: 'Pending',
                    value: '${breakdown.pending}',
                    color: Colors.orange,
                    sizeFactor: sizeFactor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0);
  }

  void _navigateToFormDetails(String formType, String formName) {
    String route;

    switch (formType) {
      case 'counting_land':
        route = AppRoutes.countingLand;
        break;
      case 'bhusampadan_citizen':
        route = AppRoutes.bhusampadanPage; // Replace with actual route
        break;
      case 'court_land_details':
        route = AppRoutes.courtLandPage; // Replace with actual route
        break;
      case 'court_vatap_citizen_application':
        route = AppRoutes.courtVatapPage; // Replace with actual route
        break;
      case 'shaskiya_mojni':
        route = AppRoutes.countingLand; // Replace with actual route
        break;
      default:
        route = AppRoutes.countingLand;
    }

    Get.toNamed(
      route,
      arguments: {
        'formType': formType,
        'formName': formName,
      },
    );
  }

  Widget _buildSmallStat({
    required PhosphorIconData icon,
    required String label,
    required String value,
    required Color color,
    required double sizeFactor,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 14.sp * sizeFactor,
        ),
        Gap(6.w * sizeFactor),
        GetTranslatableText(
          '$value $label',
          style: TextStyle(
            fontSize: 12.sp * sizeFactor,
            color: Colors.grey[700],
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}