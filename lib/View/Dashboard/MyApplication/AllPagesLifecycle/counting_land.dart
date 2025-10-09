// import 'package:emojni/View/Dashboard/MyApplication/AllPagesLifecycle/preview_component/preview_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:gap/gap.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import '../../../../Constants/color_constant.dart';
// import '../../../../Controller/Dashboard/MyApplication/counting_land_controller.dart';
// import '../../../../Controller/get_translation_controller/get_text_form.dart';
// import '../../../../Models/counting_land_model.dart';
// import '../../../../State/ui_state_manegment.dart';
// import '../../../../Utils/file_full_screen_view.dart';
//
// class CountingLand extends StatelessWidget {
//   const CountingLand({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<CountingLandController>();
//     final sizeFactor = 0.85;
//
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         title: GetTranslatableText(controller.formName),
//         backgroundColor: SetuColors.primaryGreen,
//         foregroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: controller.obx(
//         (formsList) =>
//             _buildFormsListContent(formsList!, sizeFactor, controller),
//         onLoading: CommonStateWidgets.loading(
//           message: 'Loading ${controller.formName}...',
//           sizeFactor: sizeFactor,
//         ),
//         onError: (error) => CommonStateWidgets.error(
//           error: error ?? 'Unknown error',
//           title: 'Error Loading Forms',
//           onRetry: () => controller.refreshForms(),
//           sizeFactor: sizeFactor,
//         ),
//         onEmpty: CommonStateWidgets.empty(
//           title: 'No Forms Found',
//           message: 'No ${controller.formName} forms available',
//           sizeFactor: sizeFactor,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFormsListContent(List<CountingLandForm> forms, double sizeFactor,
//       CountingLandController controller) {
//     return RefreshIndicator(
//       onRefresh: () => controller.refreshForms(),
//       color: SetuColors.primaryGreen,
//       child: Column(
//         children: [
//           _buildSummaryHeader(forms, sizeFactor),
//           Expanded(
//             child: ListView.builder(
//               padding: EdgeInsets.all(16.w * sizeFactor),
//               itemCount: forms.length,
//               itemBuilder: (context, index) {
//                 final form = forms[index];
//                 return Padding(
//                   padding: EdgeInsets.only(bottom: 12.h * sizeFactor),
//                   child: _buildFormItem(form, sizeFactor, index),
//                 )
//                     .animate()
//                     .fadeIn(
//                       delay: (50 * index).ms,
//                       duration: 400.ms,
//                     )
//                     .slideX(begin: -0.1, end: 0);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSummaryHeader(List<CountingLandForm> forms, double sizeFactor) {
//     final verifiedCount = forms.where((f) => f.isVerified).length;
//     final pendingCount = forms.where((f) => f.isPending).length;
//     final totalCount = forms.length;
//
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
//         padding: EdgeInsets.all(20.w * sizeFactor),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: buildHeaderStatCard(
//                     icon: PhosphorIcons.files(PhosphorIconsStyle.fill),
//                     label: 'Total',
//                     value: '$totalCount',
//                     color: Colors.blue,
//                     sizeFactor: sizeFactor,
//                   ),
//                 ),
//                 Gap(12.w * sizeFactor),
//                 Expanded(
//                   child: buildHeaderStatCard(
//                     icon: PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
//                     label: 'Verified',
//                     value: '$verifiedCount',
//                     color: Colors.green,
//                     sizeFactor: sizeFactor,
//                   ),
//                 ),
//                 Gap(12.w * sizeFactor),
//                 Expanded(
//                   child: buildHeaderStatCard(
//                     icon: PhosphorIcons.clock(PhosphorIconsStyle.fill),
//                     label: 'Pending',
//                     value: '$pendingCount',
//                     color: Colors.orange,
//                     sizeFactor: sizeFactor,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ).animate().fadeIn(duration: 400.ms);
//   }
//
//   Widget _buildFormItem(CountingLandForm form, double sizeFactor, int index) {
//     return InkWell(
//       onTap: () => _showFormDetails(form),
//       borderRadius: BorderRadius.circular(16.r * sizeFactor),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16.r * sizeFactor),
//           border: Border.all(
//             color: form.statusColor.withOpacity(0.3),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(16.w * sizeFactor),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(10.w * sizeFactor),
//                     decoration: BoxDecoration(
//                       color: form.statusColor.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(10.r * sizeFactor),
//                     ),
//                     child: Icon(
//                       PhosphorIcons.fileText(PhosphorIconsStyle.fill),
//                       color: form.statusColor,
//                       size: 20.sp * sizeFactor,
//                     ),
//                   ),
//                   Gap(12.w * sizeFactor),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             GetTranslatableText(
//                               'Application #${form.id}',
//                               style: TextStyle(
//                                 fontSize: 15.sp * sizeFactor,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.grey[900],
//                               ),
//                             ),
//                             const Spacer(),
//                             buildStatusBadge(form, sizeFactor),
//                           ],
//                         ),
//                         Gap(4.h * sizeFactor),
//                         Row(
//                           children: [
//                             Icon(
//                               PhosphorIcons.calendar(
//                                   PhosphorIconsStyle.regular),
//                               size: 12.sp * sizeFactor,
//                               color: Colors.grey[500],
//                             ),
//                             Gap(4.w * sizeFactor),
//                             GetTranslatableText(
//                               form.formattedCreatedDate,
//                               style: TextStyle(
//                                 fontSize: 11.sp * sizeFactor,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Gap(16.h * sizeFactor),
//               buildInfoRow(
//                 icon: PhosphorIcons.user(PhosphorIconsStyle.regular),
//                 label: 'Applicant',
//                 value: form.applicantName,
//                 sizeFactor: sizeFactor,
//               ),
//               Gap(8.h * sizeFactor),
//               buildInfoRow(
//                 icon: PhosphorIcons.mapPin(PhosphorIconsStyle.regular),
//                 label: 'Address',
//                 value: form.applicantAddress,
//                 sizeFactor: sizeFactor,
//               ),
//               Gap(8.h * sizeFactor),
//               buildInfoRow(
//                 icon: PhosphorIcons.tag(PhosphorIconsStyle.regular),
//                 label: 'Operation',
//                 value: form.operationType ?? 'N/A',
//                 sizeFactor: sizeFactor,
//               ),
//               if (form.department.isNotEmpty) ...[
//                 Gap(8.h * sizeFactor),
//                 buildInfoRow(
//                   icon: PhosphorIcons.buildings(PhosphorIconsStyle.regular),
//                   label: 'Department',
//                   value: form.department,
//                   sizeFactor: sizeFactor,
//                 ),
//               ],
//               Gap(16.h * sizeFactor),
//               Row(
//                 children: [
//                   if (form.isPaymentDone)
//                     buildFeatureChip(
//                       icon: PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
//                       label: 'Payment Done',
//                       color: Colors.green,
//                       sizeFactor: sizeFactor,
//                     ),
//                   if (!form.isPaymentDone)
//                     buildFeatureChip(
//                       icon: PhosphorIcons.warning(PhosphorIconsStyle.fill),
//                       label: 'Payment Pending',
//                       color: Colors.orange,
//                       sizeFactor: sizeFactor,
//                     ),
//                   const Spacer(),
//                   Icon(
//                     PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
//                     color: SetuColors.primaryGreen,
//                     size: 18.sp * sizeFactor,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildStatusBadge(CountingLandForm form, double sizeFactor) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: 10.w * sizeFactor,
//         vertical: 4.h * sizeFactor,
//       ),
//       decoration: BoxDecoration(
//         color: form.statusColor,
//         borderRadius: BorderRadius.circular(8.r * sizeFactor),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             form.isVerified
//                 ? PhosphorIcons.checkCircle(PhosphorIconsStyle.fill)
//                 : PhosphorIcons.clock(PhosphorIconsStyle.fill),
//             color: Colors.white,
//             size: 10.sp * sizeFactor,
//           ),
//           Gap(4.w * sizeFactor),
//           GetTranslatableText(
//             form.statusDisplayText,
//             style: TextStyle(
//               fontSize: 10.sp * sizeFactor,
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showFormDetails(CountingLandForm form) {
//     Get.bottomSheet(
//       _buildFormDetailsBottomSheet(form),
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//     );
//   }
//
//   Widget _buildFormDetailsBottomSheet(CountingLandForm form) {
//     final sizeFactor = 0.85;
//
//     return DraggableScrollableSheet(
//       initialChildSize: 0.9,
//       minChildSize: 0.5,
//       maxChildSize: 0.95,
//       builder: (context, scrollController) {
//         return Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(
//               top: Radius.circular(24.r * sizeFactor),
//             ),
//           ),
//           child: Column(
//             children: [
//               _buildBottomSheetHandle(sizeFactor),
//               _buildBottomSheetHeader(form, sizeFactor),
//               Expanded(
//                 child: SingleChildScrollView(
//                   controller: scrollController,
//                   padding: EdgeInsets.all(20.w * sizeFactor),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       buildDetailsSection(
//                         title: 'Basic Information',
//                         icon: PhosphorIcons.info(PhosphorIconsStyle.fill),
//                         children: [
//                           buildDetailItem(
//                               'Application ID', '#${form.id}', sizeFactor),
//                           buildDetailItem(
//                               'Status', form.statusDisplayText, sizeFactor),
//                           buildDetailItem('Created Date',
//                               form.formattedCreatedDate, sizeFactor),
//                           buildDetailItem(
//                               'Department', form.department, sizeFactor),
//                           buildDetailItem(
//                               'Payment Status',
//                               form.isPaymentDone ? 'Completed' : 'Pending',
//                               sizeFactor),
//                         ],
//                         sizeFactor: sizeFactor,
//                       ),
//                       Gap(20.h * sizeFactor),
//                       buildDetailsSection(
//                         title: 'Applicant Details',
//                         icon: PhosphorIcons.user(PhosphorIconsStyle.fill),
//                         children: [
//                           buildDetailItem(
//                               'Name', form.applicantName, sizeFactor),
//                           buildDetailItem(
//                               'Address', form.applicantAddress, sizeFactor),
//                           buildDetailItem(
//                               'Sub Part Area',
//                               '${form.applicantSubPartArea} hectares',
//                               sizeFactor),
//                         ],
//                         sizeFactor: sizeFactor,
//                       ),
//                       if (form.operationType != null) ...[
//                         Gap(20.h * sizeFactor),
//                         buildDetailsSection(
//                           title: 'Operation Details',
//                           icon: PhosphorIcons.gear(PhosphorIconsStyle.fill),
//                           children: [
//                             buildDetailItem('Operation Type',
//                                 form.operationType!, sizeFactor),
//                             if (form.surveyDetailType != null)
//                               buildDetailItem('Survey Detail Type',
//                                   form.surveyDetailType!, sizeFactor),
//                             if (form.consolidationOrderNumber != null)
//                               buildDetailItem('Consolidation Order',
//                                   form.consolidationOrderNumber!, sizeFactor),
//                           ],
//                           sizeFactor: sizeFactor,
//                         ),
//                       ],
//                       if (form.coOwnerName != null) ...[
//                         Gap(20.h * sizeFactor),
//                         buildDetailsSection(
//                           title: 'Co-Owner Information',
//                           icon: PhosphorIcons.users(PhosphorIconsStyle.fill),
//                           children: [
//                             buildDetailItem(
//                                 'Name', form.coOwnerName!, sizeFactor),
//                             if (form.coOwnerAddress != null)
//                               buildDetailItem(
//                                   'Address', form.coOwnerAddress!, sizeFactor),
//                             if (form.coOwnerMobileNumber != null)
//                               buildDetailItem('Mobile',
//                                   form.coOwnerMobileNumber!, sizeFactor),
//                           ],
//                           sizeFactor: sizeFactor,
//                         ),
//                       ],
//                       if (form.adjacentOwnerName != null) ...[
//                         Gap(20.h * sizeFactor),
//                         buildDetailsSection(
//                           title: 'Adjacent Owner Information',
//                           icon:
//                               PhosphorIcons.houseLine(PhosphorIconsStyle.fill),
//                           children: [
//                             buildDetailItem(
//                                 'Name', form.adjacentOwnerName!, sizeFactor),
//                             if (form.adjacentOwnerAddress != null)
//                               buildDetailItem('Address',
//                                   form.adjacentOwnerAddress!, sizeFactor),
//                             buildDetailItem(
//                                 'Total Area',
//                                 '${form.adjacentOwnerTotalArea} hectares',
//                                 sizeFactor),
//                             if (form.adjacentOwnerMobileNumber != null)
//                               buildDetailItem('Mobile',
//                                   form.adjacentOwnerMobileNumber!, sizeFactor),
//                           ],
//                           sizeFactor: sizeFactor,
//                         ),
//                       ],
//                       Gap(20.h * sizeFactor),
//                       _buildDocumentsSection(form, sizeFactor),
//                       Gap(20.h * sizeFactor),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildBottomSheetHandle(double sizeFactor) {
//     return Container(
//       margin: EdgeInsets.only(top: 12.h * sizeFactor),
//       width: 40.w * sizeFactor,
//       height: 4.h * sizeFactor,
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         borderRadius: BorderRadius.circular(2.r * sizeFactor),
//       ),
//     );
//   }
//
//   Widget _buildBottomSheetHeader(CountingLandForm form, double sizeFactor) {
//     return Container(
//       padding: EdgeInsets.all(20.w * sizeFactor),
//       decoration: BoxDecoration(
//         color: SetuColors.primaryGreen.withOpacity(0.1),
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(24.r * sizeFactor),
//         ),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: EdgeInsets.all(12.w * sizeFactor),
//             decoration: BoxDecoration(
//               color: form.statusColor,
//               borderRadius: BorderRadius.circular(12.r * sizeFactor),
//             ),
//             child: Icon(
//               PhosphorIcons.fileText(PhosphorIconsStyle.fill),
//               color: Colors.white,
//               size: 24.sp * sizeFactor,
//             ),
//           ),
//           Gap(12.w * sizeFactor),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 GetTranslatableText(
//                   'Application #${form.id}',
//                   style: TextStyle(
//                     fontSize: 18.sp * sizeFactor,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey[900],
//                   ),
//                 ),
//                 Gap(4.h * sizeFactor),
//                 buildStatusBadge(form, sizeFactor),
//               ],
//             ),
//           ),
//           IconButton(
//             onPressed: () => Get.back(),
//             icon: Icon(
//               PhosphorIcons.x(PhosphorIconsStyle.bold),
//               size: 20.sp * sizeFactor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDocumentsSection(CountingLandForm form, double sizeFactor) {
//     final controller = Get.find<CountingLandController>();
//     final documents = <Map<String, dynamic>>[];
//
//     if (form.identityProofPath != null) {
//       documents.add({
//         'name': 'Identity Proof',
//         'path': form.identityProofPath!,
//       });
//     }
//     if (form.poaDocumentPath != null) {
//       documents.add({
//         'name': 'POA Document',
//         'path': form.poaDocumentPath!,
//       });
//     }
//     if (form.tipanPath != null) {
//       documents.add({
//         'name': 'Tipan',
//         'path': form.tipanPath!,
//       });
//     }
//     if (form.fadniPath != null) {
//       documents.add({
//         'name': 'Fadni',
//         'path': form.fadniPath!,
//       });
//     }
//     if (form.yojanPatrakPath != null) {
//       documents.add({
//         'name': 'Yojana Patrak',
//         'path': form.yojanPatrakPath!,
//       });
//     }
//     if (form.adhikarPatrasPath != null) {
//       documents.add({
//         'name': 'Adhikar Patras',
//         'path': form.adhikarPatrasPath!,
//       });
//     }
//
//     if (documents.isEmpty) {
//       return const SizedBox.shrink();
//     }
//
//     return buildDetailsSection(
//       title: 'Documents',
//       icon: PhosphorIcons.files(PhosphorIconsStyle.fill),
//       children: [
//         Wrap(
//           spacing: 8.w * sizeFactor,
//           runSpacing: 8.h * sizeFactor,
//           children: documents.asMap().entries.map((entry) {
//             final index = entry.key;
//             final doc = entry.value;
//             final fileName = controller.getFileName(doc['path']);
//             final isImage = controller.isImageFile(fileName);
//             final isPdf = controller.isPdfFile(fileName);
//             final isWord = controller.isWordFile(fileName);
//
//             return GestureDetector(
//               onTap: () {
//                 final allPaths =
//                     documents.map((d) => d['path'] as String).toList();
//                 Get.to(() => FileFullScreenView(
//                       filePath: doc['path'],
//                       allFiles: allPaths,
//                       initialIndex: index,
//                     ));
//               },
//               child: Container(
//                 width: 80.w * sizeFactor,
//                 height: 80.h * sizeFactor,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade100,
//                   borderRadius: BorderRadius.circular(8.r * sizeFactor),
//                   border: Border.all(color: Colors.grey.shade300),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       isImage
//                           ? PhosphorIcons.image(PhosphorIconsStyle.regular)
//                           : isPdf
//                               ? PhosphorIcons.filePdf(
//                                   PhosphorIconsStyle.regular)
//                               : isWord
//                                   ? PhosphorIcons.fileDoc(
//                                       PhosphorIconsStyle.regular)
//                                   : PhosphorIcons.file(
//                                       PhosphorIconsStyle.regular),
//                       size: 24.w * sizeFactor,
//                       color: isImage
//                           ? Colors.blue
//                           : isPdf
//                               ? Colors.red
//                               : isWord
//                                   ? Colors.blue.shade800
//                                   : Colors.grey,
//                     ),
//                     Gap(4.h * sizeFactor),
//                     Text(
//                       doc['name'],
//                       style: TextStyle(
//                         fontSize: 8.sp * sizeFactor,
//                         color: Colors.black54,
//                       ),
//                       maxLines: 2,
//                       textAlign: TextAlign.center,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//       sizeFactor: sizeFactor,
//     );
//   }
// }

import 'package:emojni/View/Dashboard/MyApplication/AllPagesLifecycle/preview_component/preview_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../Constants/color_constant.dart';
import '../../../../Controller/Dashboard/MyApplication/counting_land_controller.dart';
import '../../../../Controller/get_translation_controller/get_text_form.dart';
import '../../../../Models/counting_land_model.dart';
import '../../../../Route Manager/app_routes.dart';
import '../../../../State/ui_state_manegment.dart';

class CountingLand extends StatelessWidget {
  const CountingLand({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CountingLandController>();
    final sizeFactor = 0.85;
    // Access the arguments
    final arguments = Get.arguments as Map<String, dynamic>;
    final formType = arguments['formType'] as String;
    print("Form type: $formType");

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: GetTranslatableText(controller.formName),
        backgroundColor: SetuColors.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: controller.obx(
        (formsList) => _buildFormsListContent(
            formsList!, sizeFactor, controller, formType),
        onLoading: CommonStateWidgets.loading(
          message: 'Loading ${controller.formName}...',
          sizeFactor: sizeFactor,
        ),
        onError: (error) => CommonStateWidgets.error(
          error: error ?? 'Unknown error',
          title: 'Error Loading Forms',
          onRetry: () => controller.refreshForms(),
          sizeFactor: sizeFactor,
        ),
        onEmpty: CommonStateWidgets.empty(
          title: 'No Forms Found',
          message: 'No ${controller.formName} forms available',
          sizeFactor: sizeFactor,
        ),
      ),
    );
  }

  Widget _buildFormsListContent(List<CountingLandForm> forms, double sizeFactor,
      CountingLandController controller, String formType) {
    return RefreshIndicator(
      onRefresh: () => controller.refreshForms(),
      color: SetuColors.primaryGreen,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.w * sizeFactor),
              itemCount: forms.length,
              itemBuilder: (context, index) {
                final form = forms[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h * sizeFactor),
                  child: _buildFormItem(form, sizeFactor, index, formType),
                )
                    .animate()
                    .fadeIn(
                      delay: (50 * index).ms,
                      duration: 400.ms,
                    )
                    .slideX(begin: -0.1, end: 0);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormItem(
      CountingLandForm form, double sizeFactor, int index, String formType) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          AppRoutes.countingLandDetailPage,
          arguments: {
            'form': form,
            'formType': formType,
          },
        );
      },
      borderRadius: BorderRadius.circular(16.r * sizeFactor),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r * sizeFactor),
          border: Border.all(
            color: form.statusColor.withOpacity(0.3),
            width: 1.5,
          ),
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
                    padding: EdgeInsets.all(10.w * sizeFactor),
                    decoration: BoxDecoration(
                      color: form.statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.r * sizeFactor),
                    ),
                    child: Icon(
                      PhosphorIcons.fileText(PhosphorIconsStyle.fill),
                      color: form.statusColor,
                      size: 20.sp * sizeFactor,
                    ),
                  ),
                  Gap(12.w * sizeFactor),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GetTranslatableText(
                              'Application #${form.id}',
                              style: TextStyle(
                                fontSize: 15.sp * sizeFactor,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900],
                              ),
                            ),
                            const Spacer(),
                            buildStatusBadge(form, sizeFactor),
                          ],
                        ),
                        Gap(4.h * sizeFactor),
                        Row(
                          children: [
                            Icon(
                              PhosphorIcons.calendar(
                                  PhosphorIconsStyle.regular),
                              size: 12.sp * sizeFactor,
                              color: Colors.grey[500],
                            ),
                            Gap(4.w * sizeFactor),
                            GetTranslatableText(
                              form.formattedCreatedDate,
                              style: TextStyle(
                                fontSize: 11.sp * sizeFactor,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(16.h * sizeFactor),
              buildInfoRow(
                icon: PhosphorIcons.user(PhosphorIconsStyle.regular),
                label: 'Applicant',
                value: form.applicantName,
                sizeFactor: sizeFactor,
              ),
              Gap(8.h * sizeFactor),
              buildInfoRow(
                icon: PhosphorIcons.mapPin(PhosphorIconsStyle.regular),
                label: 'Address',
                value: form.applicantAddress,
                sizeFactor: sizeFactor,
              ),
              Gap(8.h * sizeFactor),
              buildInfoRow(
                icon: PhosphorIcons.tag(PhosphorIconsStyle.regular),
                label: 'Operation',
                value: form.operationType ?? 'N/A',
                sizeFactor: sizeFactor,
              ),
              if (form.department.isNotEmpty) ...[
                Gap(8.h * sizeFactor),
                buildInfoRow(
                  icon: PhosphorIcons.buildings(PhosphorIconsStyle.regular),
                  label: 'Department',
                  value: form.department,
                  sizeFactor: sizeFactor,
                ),
              ],
              Gap(16.h * sizeFactor),
              Row(
                children: [
                  if (form.isPaymentDone)
                    buildFeatureChip(
                      icon: PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                      label: 'Payment Done',
                      color: Colors.green,
                      sizeFactor: sizeFactor,
                    ),
                  if (!form.isPaymentDone)
                    buildFeatureChip(
                      icon: PhosphorIcons.warning(PhosphorIconsStyle.fill),
                      label: 'Payment Pending',
                      color: Colors.orange,
                      sizeFactor: sizeFactor,
                    ),
                  const Spacer(),
                  Icon(
                    PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
                    color: SetuColors.primaryGreen,
                    size: 18.sp * sizeFactor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStatusBadge(CountingLandForm form, double sizeFactor) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w * sizeFactor,
        vertical: 4.h * sizeFactor,
      ),
      decoration: BoxDecoration(
        color: form.statusColor,
        borderRadius: BorderRadius.circular(8.r * sizeFactor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            form.isVerified
                ? PhosphorIcons.checkCircle(PhosphorIconsStyle.fill)
                : PhosphorIcons.clock(PhosphorIconsStyle.fill),
            color: Colors.white,
            size: 10.sp * sizeFactor,
          ),
          Gap(4.w * sizeFactor),
          GetTranslatableText(
            form.statusDisplayText,
            style: TextStyle(
              fontSize: 10.sp * sizeFactor,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
