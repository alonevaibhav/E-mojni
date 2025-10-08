//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:gap/gap.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
// import 'dart:convert';
// import '../../../../../../Constants/color_constant.dart';
// import '../../../../../../Controller/Dashboard/MyApplication/LifecycleController/life_counting_controller.dart';
// import '../../../../../../Controller/get_translation_controller/get_text_form.dart';
// import '../../../../../../Models/payment_model.dart';
// import '../../../../../../State/ui_state_manegment.dart';
// import '../../../../../../Utils/custimize_image_picker.dart';
//
// class PaymentWidget extends StatelessWidget {
//   final double sizeFactor;
//   final LifeCountingController controller;
//
//   const PaymentWidget({
//     super.key,
//     required this.sizeFactor,
//     required this.controller,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final sizeFactor = 0.85;
//     return controller.obx(
//           (paymentData) {
//         // Check if both payments are completed
//         if (paymentData!.measurementPaymentStatus.toLowerCase() == 'completed' &&
//             paymentData.conveniencePaymentStatus.toLowerCase() == 'completed') {
//           return _buildPaymentCompletedCard();
//         }
//         return _buildPaymentContent(paymentData, controller);
//       },
//       onLoading: CommonStateWidgets.loading(
//         message: 'Loading payment data...',
//         sizeFactor: sizeFactor,
//       ),
//       onError: (error) => CommonStateWidgets.error(
//         error: error ?? 'Unknown error',
//         title: 'Error Loading Payment',
//         onRetry: () => controller.refreshPaymentStatus(),
//         sizeFactor: sizeFactor,
//       ),
//       onEmpty: CommonStateWidgets.empty(
//         title: 'No Payment Data',
//         message: 'No payment information available for this form',
//         sizeFactor: sizeFactor,
//       ),
//     );
//   }
//
//
//
//
//
//
//   Widget _buildPaymentCompletedCard() {
//     return Container(
//       margin: EdgeInsets.all(16.w * sizeFactor),
//       padding: EdgeInsets.all(24.w * sizeFactor),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.green[400]!, Colors.green[600]!],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(16.r * sizeFactor),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.green.withOpacity(0.3),
//             blurRadius: 15,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             padding: EdgeInsets.all(16.w * sizeFactor),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
//               color: Colors.white,
//               size: 64.sp * sizeFactor,
//             ),
//           ),
//           Gap(20.h * sizeFactor),
//           GetTranslatableText(
//             'Payment Completed!',
//             style: TextStyle(
//               fontSize: 24.sp * sizeFactor,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           Gap(8.h * sizeFactor),
//           GetTranslatableText(
//             'Both measurement and convenience fees have been successfully paid',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 14.sp * sizeFactor,
//               color: Colors.white.withOpacity(0.9),
//               height: 1.5,
//             ),
//           ),
//           Gap(20.h * sizeFactor),
//           Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: 20.w * sizeFactor,
//               vertical: 12.h * sizeFactor,
//             ),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(8.r * sizeFactor),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   PhosphorIcons.info(PhosphorIconsStyle.regular),
//                   color: Colors.white,
//                   size: 16.sp * sizeFactor,
//                 ),
//                 Gap(8.w * sizeFactor),
//                 GetTranslatableText(
//                   'Your application is being processed',
//                   style: TextStyle(
//                     fontSize: 12.sp * sizeFactor,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPaymentContent(PaymentData payment, controller) {
//     return Container(
//       margin: EdgeInsets.all(16.w * sizeFactor),
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
//       child: Column(
//         children: [
//           // Header
//           _buildPaymentHeader(payment),
//
//           // Payment Status Banner
//           if (!payment.isFullyPaid) _buildStatusBanner(payment),
//
//           // Fee Summary
//           _buildFeeSummary(payment),
//
//           // QR Code Sections
//           if (!payment.isMeasurementPaid)
//             _buildQrSection(
//               title: 'Measurement Fee',
//               amount: payment.measurementFee,
//               qrCode: payment.measurementQrCode,
//               status: payment.measurementPaymentStatus,
//               onTap: () => controller.openQrCodeFullScreen(
//                 payment.measurementQrCode,
//                 'Measurement Fee QR Code',
//               ),
//             ),
//           _buildChalanUploadSections(payment),
//
//
//           if (!payment.isConveniencePaid)
//             _buildQrSection(
//               title: 'Convenience Fee',
//               amount: payment.convenienceFee,
//               qrCode: payment.convenienceQrCode,
//               status: payment.conveniencePaymentStatus,
//               onTap: () => controller.openQrCodeFullScreen(
//                 payment.convenienceQrCode,
//                 'Convenience Fee QR Code',
//               ),
//             ),
//
//           // Grass Chalan Upload Sections
//           _buildConenienceUploadSections(payment),
//
//           // UPI Details
//           _buildUpiDetails(payment),
//
//           Gap(25.h * sizeFactor),
//           Gap(16.h * sizeFactor),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildChalanUploadSections(PaymentData payment) {
//     return Column(
//       children: [
//         Gap(8.h * sizeFactor),
//
//         // Measurement Chalan Upload Section
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: 16.w * sizeFactor),
//           padding: EdgeInsets.all(16.w * sizeFactor),
//           decoration: BoxDecoration(
//             color: Colors.grey[50],
//             borderRadius: BorderRadius.circular(12.r * sizeFactor),
//             border: Border.all(color: Colors.grey[300]!),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                     Icons.upload_file,
//                     color: SetuColors.primaryGreen,
//                     size: 20.sp * sizeFactor,
//                   ),
//                   Gap(8.w * sizeFactor),
//                   Expanded(
//                     child: GetTranslatableText(
//                       'Grass Chalan Submission',
//                       style: TextStyle(
//                         fontSize: 15.sp * sizeFactor,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ),
//                   Obx(() => controller.measurementUploadSuccess.value
//                       ? Icon(
//                     Icons.check_circle,
//                     color: Colors.green,
//                     size: 20.sp * sizeFactor,
//                   )
//                       : const SizedBox.shrink()),
//                 ],
//               ),
//               Gap(12.h * sizeFactor),
//               ImagePickerUtil.buildFileUploadField(
//                 label: 'Measurement Chalan Document *',
//                 hint: 'Upload Payment Screenshot/Receipt',
//                 icon: PhosphorIcons.fileText(PhosphorIconsStyle.regular),
//                 uploadedFiles: controller.measurementChalanFiles,
//                 onFilesSelected: (files) =>
//                     controller.measurementChalanFiles.assignAll(files),
//               ),
//               Gap(12.h * sizeFactor),
//               Obx(() => SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: controller.isMeasurementUploading.value ||
//                       controller.measurementChalanFiles.isEmpty
//                       ? null
//                       : () => controller.uploadMeasurementChalan(),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: SetuColors.primaryGreen,
//                     foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(
//                       vertical: 12.h * sizeFactor,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.r * sizeFactor),
//                     ),
//                   ),
//                   child: controller.isMeasurementUploading.value
//                       ? SizedBox(
//                     height: 20.h * sizeFactor,
//                     width: 20.h * sizeFactor,
//                     child: const CircularProgressIndicator(
//                       color: Colors.white,
//                       strokeWidth: 2,
//                     ),
//                   )
//                       : GetTranslatableText(
//                     'Submit Measurement Chalan',
//                     style: TextStyle(
//                       fontSize: 14.sp * sizeFactor,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               )),
//             ],
//           ),
//         ),
//
//         Gap(12.h * sizeFactor),
//
//         // Convenience Chalan Upload Section
//       ],
//     );
//   }
//
//
//
//
//   Widget _buildConenienceUploadSections(PaymentData payment) {
//     return Column(
//       children: [
//         Gap(8.h * sizeFactor),
//
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: 16.w * sizeFactor),
//           padding: EdgeInsets.all(16.w * sizeFactor),
//           decoration: BoxDecoration(
//             color: Colors.grey[50],
//             borderRadius: BorderRadius.circular(12.r * sizeFactor),
//             border: Border.all(color: Colors.grey[300]!),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                     Icons.upload_file,
//                     color: SetuColors.primaryGreen,
//                     size: 20.sp * sizeFactor,
//                   ),
//                   Gap(8.w * sizeFactor),
//                   Expanded(
//                     child: GetTranslatableText(
//                       'Convenience Fee Submission',
//                       style: TextStyle(
//                         fontSize: 15.sp * sizeFactor,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ),
//                   Obx(() => controller.convenienceUploadSuccess.value
//                       ? Icon(
//                     Icons.check_circle,
//                     color: Colors.green,
//                     size: 20.sp * sizeFactor,
//                   )
//                       : const SizedBox.shrink()),
//                 ],
//               ),
//               Gap(12.h * sizeFactor),
//               ImagePickerUtil.buildFileUploadField(
//                 label: 'Convenience Chalan Document *',
//                 hint: 'Upload Payment Screenshot/Receipt',
//                 icon: PhosphorIcons.fileText(PhosphorIconsStyle.regular),
//                 uploadedFiles: controller.convenienceChalanFiles,
//                 onFilesSelected: (files) =>
//                     controller.convenienceChalanFiles.assignAll(files),
//               ),
//               Gap(12.h * sizeFactor),
//               Obx(() => SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: controller.isConvenienceUploading.value ||
//                       controller.convenienceChalanFiles.isEmpty
//                       ? null
//                       : () => controller.uploadConvenienceChalan(),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: SetuColors.primaryGreen,
//                     foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(
//                       vertical: 12.h * sizeFactor,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.r * sizeFactor),
//                     ),
//                   ),
//                   child: controller.isConvenienceUploading.value
//                       ? SizedBox(
//                     height: 20.h * sizeFactor,
//                     width: 20.h * sizeFactor,
//                     child: const CircularProgressIndicator(
//                       color: Colors.white,
//                       strokeWidth: 2,
//                     ),
//                   )
//                       : GetTranslatableText(
//                     'Submit Convenience Chalan',
//                     style: TextStyle(
//                       fontSize: 14.sp * sizeFactor,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               )),
//             ],
//           ),
//         ),
//
//         Gap(8.h * sizeFactor),
//       ],
//     );
//   }
//
//
//   Widget _buildPaymentHeader(PaymentData payment) {
//     return
//       Container(
//       padding: EdgeInsets.all(20.w * sizeFactor),
//       decoration: BoxDecoration(
//         color: payment.isFullyPaid ? Colors.green[50] : Colors.orange[50],
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(16.r * sizeFactor),
//           topRight: Radius.circular(16.r * sizeFactor),
//         ),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: EdgeInsets.all(12.w * sizeFactor),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12.r * sizeFactor),
//             ),
//             child: Icon(
//               payment.isFullyPaid
//                   ? PhosphorIcons.checkCircle(PhosphorIconsStyle.fill)
//                   : PhosphorIcons.wallet(PhosphorIconsStyle.regular),
//               size: 32.sp * sizeFactor,
//               color:
//               payment.isFullyPaid ? Colors.green[600] : Colors.orange[600],
//             ),
//           ),
//           Gap(16.w * sizeFactor),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 GetTranslatableText(
//                   payment.isFullyPaid ? 'Payment Complete' : 'Payment Required',
//                   style: TextStyle(
//                     fontSize: 18.sp * sizeFactor,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//                 Gap(4.h * sizeFactor),
//                 GetTranslatableText(
//                   payment.transactionNote,
//                   style: TextStyle(
//                     fontSize: 12.sp * sizeFactor,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStatusBanner(PaymentData payment) {
//     return Container(
//       margin: EdgeInsets.all(16.w * sizeFactor),
//       padding: EdgeInsets.all(12.w * sizeFactor),
//       decoration: BoxDecoration(
//         color: Colors.orange[100],
//         borderRadius: BorderRadius.circular(12.r * sizeFactor),
//         border: Border.all(color: Colors.orange[300]!),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             PhosphorIcons.warning(PhosphorIconsStyle.fill),
//             color: Colors.orange[800],
//             size: 20.sp * sizeFactor,
//           ),
//           Gap(12.w * sizeFactor),
//           Expanded(
//             child: GetTranslatableText(
//               'Please complete the payment using the QR codes below',
//               style: TextStyle(
//                 fontSize: 12.sp * sizeFactor,
//                 color: Colors.orange[900],
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFeeSummary(PaymentData payment) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16.w * sizeFactor),
//       padding: EdgeInsets.all(16.w * sizeFactor),
//       decoration: BoxDecoration(
//         color: Colors.grey[50],
//         borderRadius: BorderRadius.circular(12.r * sizeFactor),
//       ),
//       child: Column(
//         children: [
//           _buildFeeRow('Measurement Fee', payment.measurementFee,
//               payment.isMeasurementPaid),
//           Gap(8.h * sizeFactor),
//           _buildFeeRow('Convenience Fee', payment.convenienceFee,
//               payment.isConveniencePaid),
//           Gap(8.h * sizeFactor),
//           Divider(color: Colors.grey[300]),
//           Gap(8.h * sizeFactor),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               GetTranslatableText(
//                 'Total Amount',
//                 style: TextStyle(
//                   fontSize: 16.sp * sizeFactor,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey[800],
//                 ),
//               ),
//               GetTranslatableText(
//                 '₹${payment.totalAmount.toStringAsFixed(2)}',
//                 style: TextStyle(
//                   fontSize: 20.sp * sizeFactor,
//                   fontWeight: FontWeight.bold,
//                   color: SetuColors.primaryGreen,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFeeRow(String label, String amount, bool isPaid) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             GetTranslatableText(
//               label,
//               style: TextStyle(
//                 fontSize: 14.sp * sizeFactor,
//                 color: Colors.grey[700],
//               ),
//             ),
//             if (isPaid) ...[
//               Gap(8.w * sizeFactor),
//               Icon(
//                 PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
//                 size: 16.sp * sizeFactor,
//                 color: Colors.green[600],
//               ),
//             ],
//           ],
//         ),
//         GetTranslatableText(
//           '₹$amount',
//           style: TextStyle(
//             fontSize: 14.sp * sizeFactor,
//             fontWeight: FontWeight.w600,
//             color: isPaid ? Colors.green[600] : Colors.grey[800],
//             decoration: isPaid ? TextDecoration.lineThrough : null,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildQrSection({
//     required String title,
//     required String amount,
//     required String qrCode,
//     required String status,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       margin: EdgeInsets.all(16.w * sizeFactor),
//       padding: EdgeInsets.all(16.w * sizeFactor),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey[300]!),
//         borderRadius: BorderRadius.circular(12.r * sizeFactor),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               GetTranslatableText(
//                 title,
//                 style: TextStyle(
//                   fontSize: 16.sp * sizeFactor,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey[800],
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 12.w * sizeFactor,
//                   vertical: 6.h * sizeFactor,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.orange[100],
//                   borderRadius: BorderRadius.circular(20.r * sizeFactor),
//                 ),
//                 child: GetTranslatableText(
//                   '₹$amount',
//                   style: TextStyle(
//                     fontSize: 14.sp * sizeFactor,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.orange[900],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Gap(16.h * sizeFactor),
//           GestureDetector(
//             onTap: onTap,
//             child: Container(
//               padding: EdgeInsets.all(12.w * sizeFactor),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12.r * sizeFactor),
//                 border: Border.all(color: Colors.grey[300]!),
//               ),
//               child: Column(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(8.r * sizeFactor),
//                     child: Image.memory(
//                       base64Decode(qrCode.split(',')[1]),
//                       height: 200.h * sizeFactor,
//                       width: 200.w * sizeFactor,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   Gap(12.h * sizeFactor),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         PhosphorIcons.magnifyingGlassPlus(
//                             PhosphorIconsStyle.regular),
//                         size: 16.sp * sizeFactor,
//                         color: SetuColors.primaryGreen,
//                       ),
//                       Gap(8.w * sizeFactor),
//                       GetTranslatableText(
//                         'Tap to enlarge',
//                         style: TextStyle(
//                           fontSize: 12.sp * sizeFactor,
//                           color: SetuColors.primaryGreen,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Gap(12.h * sizeFactor),
//           Container(
//             padding: EdgeInsets.all(12.w * sizeFactor),
//             decoration: BoxDecoration(
//               color: Colors.blue[50],
//               borderRadius: BorderRadius.circular(8.r * sizeFactor),
//             ),
//             child: Row(
//               children: [
//                 Icon(
//                   PhosphorIcons.info(PhosphorIconsStyle.regular),
//                   size: 16.sp * sizeFactor,
//                   color: Colors.blue[700],
//                 ),
//                 Gap(8.w * sizeFactor),
//                 Expanded(
//                   child: GetTranslatableText(
//                     'Scan this QR code using any UPI app to pay',
//                     style: TextStyle(
//                       fontSize: 11.sp * sizeFactor,
//                       color: Colors.blue[900],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildUpiDetails(PaymentData payment) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16.w * sizeFactor),
//       padding: EdgeInsets.all(16.w * sizeFactor),
//       decoration: BoxDecoration(
//         color: Colors.purple[50],
//         borderRadius: BorderRadius.circular(12.r * sizeFactor),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             PhosphorIcons.identificationCard(PhosphorIconsStyle.regular),
//             color: Colors.purple[700],
//             size: 20.sp * sizeFactor,
//           ),
//           Gap(12.w * sizeFactor),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 GetTranslatableText(
//                   'UPI ID',
//                   style: TextStyle(
//                     fontSize: 11.sp * sizeFactor,
//                     color: Colors.purple[700],
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 Gap(4.h * sizeFactor),
//                 GetTranslatableText(
//                   payment.upiId,
//                   style: TextStyle(
//                     fontSize: 14.sp * sizeFactor,
//                     color: Colors.purple[900],
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:emojni/View/Dashboard/MyApplication/AllPagesLifecycle/FormLifecycle/components/payment_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../../../Controller/Dashboard/MyApplication/LifecycleController/life_counting_controller.dart';
import '../../../../../../Models/counting_land_model.dart';
import '../../../../../../State/ui_state_manegment.dart';

class PaymentWidget extends StatelessWidget {
  final double sizeFactor;
  final LifeCountingController controller;
  final CountingLandForm form;

  const PaymentWidget({
    super.key,
    required this.sizeFactor,
    required this.controller,
    required this.form,
  });

  @override
  Widget build(BuildContext context) {
    final sizeFactor = 0.85;

    // Check form status
    final status = form.status?.toLowerCase() ?? '';

    // if (status == 'pending') {
    //   return buildStatusCard(
    //     sizeFactor: sizeFactor,
    //     gradientColors: [Colors.orange[400]!, Colors.orange[600]!],
    //     shadowColor: Colors.orange,
    //     icon: PhosphorIcons.clockCounterClockwise(PhosphorIconsStyle.fill),
    //     title: 'Form Under Review',
    //     description:
    //         'Your application form is currently pending review by our team',
    //     infoMessage: 'Payment details will be available after approval',
    //   );
    // }
    //
    // if (status == 'verified') {
    //   return buildStatusCard(
    //     sizeFactor: sizeFactor,
    //     gradientColors: [Colors.blue[400]!, Colors.blue[600]!],
    //     shadowColor: Colors.blue,
    //     icon: PhosphorIcons.sealCheck(PhosphorIconsStyle.fill),
    //     title: 'Form Verified',
    //     description:
    //         'Your application form has been successfully verified and approved',
    //     infoMessage: 'Please proceed with the payment process',
    //   );
    // }
    //
    // if (status == 'rejected') {
    //   return buildStatusCard(
    //     sizeFactor: sizeFactor,
    //     gradientColors: [Colors.red[400]!, Colors.red[600]!],
    //     shadowColor: Colors.red,
    //     icon: PhosphorIcons.xCircle(PhosphorIconsStyle.fill),
    //     title: 'Form Rejected',
    //     description:
    //         'Unfortunately, your application form has been rejected after review',
    //     infoMessage: 'Please contact support for more details or resubmit',
    //   );
    // }

    return controller.obx(
      (paymentData) {
        // Check if both payments are completed
        if (paymentData!.measurementPaymentStatus.toLowerCase() == 'completed' &&
            paymentData.conveniencePaymentStatus.toLowerCase() == 'completed') {
          return buildStatusCard(
            sizeFactor: sizeFactor,
            gradientColors: [Colors.green[400]!, Colors.green[600]!],
            shadowColor: Colors.green,
            icon: PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
            title: 'Payment Completed!',
            description:
                'Both measurement and convenience fees have been successfully paid',
            infoMessage: 'Your application is being processed',
          );
        }
        return buildPaymentContent(paymentData, controller, sizeFactor);
      },
      onLoading: CommonStateWidgets.loading(
        message: 'Loading payment data...',
        sizeFactor: sizeFactor,
      ),
      onError: (error) => CommonStateWidgets.error(
        error: error ?? 'Unknown error',
        title: 'Error Loading Payment',
        onRetry: () => controller.refreshPaymentStatus(),
        sizeFactor: sizeFactor,
      ),
      onEmpty: CommonStateWidgets.empty(
        title: 'No Payment Data',
        message: 'No payment information available for this form',
        sizeFactor: sizeFactor,
      ),
    );
  }
}
