// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:gap/gap.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
// import 'dart:convert';
// import '../../../../../../Constants/color_constant.dart';
// import '../../../../../../Controller/get_translation_controller/get_text_form.dart';
// import '../../../../../../Models/payment_model.dart';
// import '../../../../../../Utils/custimize_image_picker.dart';
//
// Widget buildStatusCard({
//   required double sizeFactor,
//   required List<Color> gradientColors,
//   required Color shadowColor,
//   required IconData icon,
//   required String title,
//   required String description,
//   required String infoMessage,
// }) {
//   return Container(
//     margin: EdgeInsets.all(16.w * sizeFactor),
//     padding: EdgeInsets.all(24.w * sizeFactor),
//     decoration: BoxDecoration(
//       gradient: LinearGradient(
//         colors: gradientColors,
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//       ),
//       borderRadius: BorderRadius.circular(16.r * sizeFactor),
//       boxShadow: [
//         BoxShadow(
//           color: shadowColor.withOpacity(0.3),
//           blurRadius: 15,
//           offset: const Offset(0, 5),
//         ),
//       ],
//     ),
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           padding: EdgeInsets.all(16.w * sizeFactor),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.2),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(
//             icon,
//             color: Colors.white,
//             size: 64.sp * sizeFactor,
//           ),
//         ),
//         Gap(20.h * sizeFactor),
//         GetTranslatableText(
//           title,
//           style: TextStyle(
//             fontSize: 24.sp * sizeFactor,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         Gap(8.h * sizeFactor),
//         GetTranslatableText(
//           description,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 14.sp * sizeFactor,
//             color: Colors.white.withOpacity(0.9),
//             height: 1.5,
//           ),
//         ),
//         Gap(20.h * sizeFactor),
//         Container(
//           padding: EdgeInsets.symmetric(
//             horizontal: 20.w * sizeFactor,
//             vertical: 12.h * sizeFactor,
//           ),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.2),
//             borderRadius: BorderRadius.circular(8.r * sizeFactor),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 PhosphorIcons.info(PhosphorIconsStyle.regular),
//                 color: Colors.white,
//                 size: 16.sp * sizeFactor,
//               ),
//               Gap(8.w * sizeFactor),
//               Expanded(
//                 child: GetTranslatableText(
//                   infoMessage,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 12.sp * sizeFactor,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
// // Reusable Payment Status Widget
// Widget _buildPaymentStatus({
//   required String status,
//   required double sizeFactor,
// }) {
//   Color backgroundColor;
//   Color textColor;
//   Color iconColor;
//   IconData icon;
//   String message;
//
//   switch (status.toLowerCase()) {
//     case 'pending':
//       backgroundColor = Colors.orange.shade50;
//       textColor = Colors.orange.shade800;
//       iconColor = Colors.orange.shade600;
//       icon = Icons.access_time_rounded;
//       message = 'Your payment is pending';
//       break;
//     case 'submitted':
//       backgroundColor = Colors.blue.shade50;
//       textColor = Colors.blue.shade800;
//       iconColor = Colors.blue.shade600;
//       icon = Icons.upload_file_rounded;
//       message = 'Payment receipt submitted for review';
//       break;
//     case 'approved':
//       backgroundColor = Colors.green.shade50;
//       textColor = Colors.green.shade800;
//       iconColor = Colors.green.shade600;
//       icon = Icons.check_circle_rounded;
//       message = 'Payment approved successfully';
//       break;
//     case 'failed':
//       backgroundColor = Colors.red.shade50;
//       textColor = Colors.red.shade800;
//       iconColor = Colors.red.shade600;
//       icon = Icons.error_rounded;
//       message = 'Payment failed. Please try again';
//       break;
//     default:
//       backgroundColor = Colors.grey.shade50;
//       textColor = Colors.grey.shade800;
//       iconColor = Colors.grey.shade600;
//       icon = Icons.info_rounded;
//       message = 'Please pay the bill';
//   }
//
//   return Container(
//     margin: EdgeInsets.symmetric(
//       horizontal: 16.w * sizeFactor,
//       vertical: 8.h * sizeFactor,
//     ),
//     padding: EdgeInsets.all(16.w * sizeFactor),
//     decoration: BoxDecoration(
//       color: backgroundColor,
//       borderRadius: BorderRadius.circular(12.r * sizeFactor),
//       border: Border.all(
//         color: iconColor.withOpacity(0.3),
//         width: 1,
//       ),
//     ),
//     child: Row(
//       children: [
//         Container(
//           padding: EdgeInsets.all(8.w * sizeFactor),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             shape: BoxShape.circle,
//           ),
//           child: Icon(
//             icon,
//             color: iconColor,
//             size: 24.sp * sizeFactor,
//           ),
//         ),
//         SizedBox(width: 12.w * sizeFactor),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 status.toUpperCase(),
//                 style: TextStyle(
//                   fontSize: 11.sp * sizeFactor,
//                   fontWeight: FontWeight.w600,
//                   color: textColor.withOpacity(0.8),
//                   letterSpacing: 0.5,
//                 ),
//               ),
//               SizedBox(height: 2.h * sizeFactor),
//               Text(
//                 message,
//                 style: TextStyle(
//                   fontSize: 14.sp * sizeFactor,
//                   fontWeight: FontWeight.w500,
//                   color: textColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
// // Usage in your buildPaymentContent:
// Widget buildPaymentContent(PaymentData payment, controller, sizeFactor) {
//   return Container(
//     margin: EdgeInsets.all(16.w * sizeFactor),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(16.r * sizeFactor),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.05),
//           blurRadius: 10,
//           offset: const Offset(0, 4),
//         ),
//       ],
//     ),
//     child: Column(
//       children: [
//         // Header
//         _buildPaymentHeader(payment, sizeFactor),
//
//         // Payment Status Banner
//         if (!payment.isFullyPaid) _buildStatusBanner(payment, sizeFactor),
//
//         // Fee Summary
//         _buildFeeSummary(payment, sizeFactor),
//
//         _buildUpiDetails(payment, sizeFactor),
//
//         // QR Code Sections
//         if (!payment.isMeasurementPaid)
//           _buildQrSection(
//             title: 'Measurement Fee',
//             amount: payment.measurementFee,
//             qrCode: payment.measurementQrCode,
//             status: payment.measurementPaymentStatus,
//             sizeFactor: sizeFactor,
//             onTap: () => controller.openQrCodeFullScreen(
//               payment.measurementQrCode,
//               'Measurement Fee QR Code',
//             ),
//           ),
//         _buildChalanUploadSections(payment, sizeFactor, controller),
//
//         // Measurement Payment Status
//         _buildPaymentStatus(
//           status: payment.measurementPaymentStatus,
//           sizeFactor: sizeFactor,
//         ),
//
//         if (!payment.isConveniencePaid)
//           _buildQrSection(
//             title: 'Convenience Fee',
//             amount: payment.convenienceFee,
//             qrCode: payment.convenienceQrCode,
//             status: payment.conveniencePaymentStatus,
//             sizeFactor: sizeFactor,
//             onTap: () => controller.openQrCodeFullScreen(
//               payment.convenienceQrCode,
//               'Convenience Fee QR Code',
//             ),
//           ),
//
//         // Grass Chalan Upload Sections
//         _buildConenienceUploadSections(payment, sizeFactor, controller),
//
//         // Convenience Payment Status
//         _buildPaymentStatus(
//           status: payment.conveniencePaymentStatus,
//           sizeFactor: sizeFactor,
//         ),
//
//         // UPI Details
//
//         Gap(25.h * sizeFactor),
//         Gap(16.h * sizeFactor),
//       ],
//     ),
//   );
// }
//
// Widget _buildChalanUploadSections(PaymentData payment, sizeFactor, controller) {
//   return Column(
//     children: [
//       Gap(8.h * sizeFactor),
//
//       // Measurement Chalan Upload Section
//       Container(
//         margin: EdgeInsets.symmetric(horizontal: 16.w * sizeFactor),
//         padding: EdgeInsets.all(16.w * sizeFactor),
//         decoration: BoxDecoration(
//           color: Colors.grey[50],
//           borderRadius: BorderRadius.circular(12.r * sizeFactor),
//           border: Border.all(color: Colors.grey[300]!),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(
//                   Icons.upload_file,
//                   color: SetuColors.primaryGreen,
//                   size: 20.sp * sizeFactor,
//                 ),
//                 Gap(8.w * sizeFactor),
//                 Expanded(
//                   child: GetTranslatableText(
//                     'Grass Chalan Submission',
//                     style: TextStyle(
//                       fontSize: 15.sp * sizeFactor,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//                 Obx(() => controller.measurementUploadSuccess.value
//                     ? Icon(
//                         Icons.check_circle,
//                         color: Colors.green,
//                         size: 20.sp * sizeFactor,
//                       )
//                     : const SizedBox.shrink()),
//               ],
//             ),
//             Gap(12.h * sizeFactor),
//             ImagePickerUtil.buildFileUploadField(
//               label: 'Measurement Chalan Document *',
//               hint: 'Upload Payment Screenshot/Receipt',
//               icon: PhosphorIcons.fileText(PhosphorIconsStyle.regular),
//               uploadedFiles: controller.measurementChalanFiles,
//               onFilesSelected: (files) => controller
//                   .measurementChalanFiles.value = List<String>.from(files),
//             ),
//             Gap(12.h * sizeFactor),
//             Obx(() => SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: controller.isMeasurementUploading.value ||
//                             controller.measurementChalanFiles.isEmpty
//                         ? null
//                         : () => controller.uploadMeasurementChalan(),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: SetuColors.primaryGreen,
//                       foregroundColor: Colors.white,
//                       padding: EdgeInsets.symmetric(
//                         vertical: 12.h * sizeFactor,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.r * sizeFactor),
//                       ),
//                     ),
//                     child: controller.isMeasurementUploading.value
//                         ? SizedBox(
//                             height: 20.h * sizeFactor,
//                             width: 20.h * sizeFactor,
//                             child: const CircularProgressIndicator(
//                               color: Colors.white,
//                               strokeWidth: 2,
//                             ),
//                           )
//                         : GetTranslatableText(
//                             'Submit Measurement Chalan',
//                             style: TextStyle(
//                               fontSize: 14.sp * sizeFactor,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                   ),
//                 )),
//           ],
//         ),
//       ),
//
//       Gap(12.h * sizeFactor),
//
//       // Convenience Chalan Upload Section
//     ],
//   );
// }
//
// Widget _buildConenienceUploadSections(
//     PaymentData payment, sizeFactor, controller) {
//   return Column(
//     children: [
//       Gap(8.h * sizeFactor),
//       Container(
//         margin: EdgeInsets.symmetric(horizontal: 16.w * sizeFactor),
//         padding: EdgeInsets.all(16.w * sizeFactor),
//         decoration: BoxDecoration(
//           color: Colors.grey[50],
//           borderRadius: BorderRadius.circular(12.r * sizeFactor),
//           border: Border.all(color: Colors.grey[300]!),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(
//                   Icons.upload_file,
//                   color: SetuColors.primaryGreen,
//                   size: 20.sp * sizeFactor,
//                 ),
//                 Gap(8.w * sizeFactor),
//                 Expanded(
//                   child: GetTranslatableText(
//                     'Convenience Fee Submission',
//                     style: TextStyle(
//                       fontSize: 15.sp * sizeFactor,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//                 Obx(() => controller.convenienceUploadSuccess.value
//                     ? Icon(
//                         Icons.check_circle,
//                         color: Colors.green,
//                         size: 20.sp * sizeFactor,
//                       )
//                     : const SizedBox.shrink()),
//               ],
//             ),
//             Gap(12.h * sizeFactor),
//             ImagePickerUtil.buildFileUploadField(
//               label: 'Convenience Chalan Document *',
//               hint: 'Upload Payment Screenshot/Receipt',
//               icon: PhosphorIcons.fileText(PhosphorIconsStyle.regular),
//               uploadedFiles: controller.convenienceChalanFiles,
//               onFilesSelected: (files) => controller
//                   .convenienceChalanFiles.value = List<String>.from(files),
//             ),
//             Gap(12.h * sizeFactor),
//             Obx(() => SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: controller.isConvenienceUploading.value ||
//                             controller.convenienceChalanFiles.isEmpty
//                         ? null
//                         : () => controller.uploadConvenienceChalan(),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: SetuColors.primaryGreen,
//                       foregroundColor: Colors.white,
//                       padding: EdgeInsets.symmetric(
//                         vertical: 12.h * sizeFactor,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.r * sizeFactor),
//                       ),
//                     ),
//                     child: controller.isConvenienceUploading.value
//                         ? SizedBox(
//                             height: 20.h * sizeFactor,
//                             width: 20.h * sizeFactor,
//                             child: const CircularProgressIndicator(
//                               color: Colors.white,
//                               strokeWidth: 2,
//                             ),
//                           )
//                         : GetTranslatableText(
//                             'Submit Convenience Chalan',
//                             style: TextStyle(
//                               fontSize: 14.sp * sizeFactor,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                   ),
//                 )),
//           ],
//         ),
//       ),
//       Gap(8.h * sizeFactor),
//     ],
//   );
// }
//
// Widget _buildPaymentHeader(PaymentData payment, sizeFactor) {
//   return Container(
//     padding: EdgeInsets.all(20.w * sizeFactor),
//     decoration: BoxDecoration(
//       color: payment.isFullyPaid ? Colors.green[50] : Colors.orange[50],
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(16.r * sizeFactor),
//         topRight: Radius.circular(16.r * sizeFactor),
//       ),
//     ),
//     child: Row(
//       children: [
//         Container(
//           padding: EdgeInsets.all(12.w * sizeFactor),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12.r * sizeFactor),
//           ),
//           child: Icon(
//             payment.isFullyPaid
//                 ? PhosphorIcons.checkCircle(PhosphorIconsStyle.fill)
//                 : PhosphorIcons.wallet(PhosphorIconsStyle.regular),
//             size: 32.sp * sizeFactor,
//             color: payment.isFullyPaid ? Colors.green[600] : Colors.orange[600],
//           ),
//         ),
//         Gap(16.w * sizeFactor),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GetTranslatableText(
//                 payment.isFullyPaid ? 'Payment Complete' : 'Payment Required',
//                 style: TextStyle(
//                   fontSize: 18.sp * sizeFactor,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey[800],
//                 ),
//               ),
//               Gap(4.h * sizeFactor),
//               GetTranslatableText(
//                 payment.transactionNote,
//                 style: TextStyle(
//                   fontSize: 12.sp * sizeFactor,
//                   color: Colors.grey[600],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
// Widget _buildStatusBanner(PaymentData payment, sizeFactor) {
//   return Container(
//     margin: EdgeInsets.all(16.w * sizeFactor),
//     padding: EdgeInsets.all(12.w * sizeFactor),
//     decoration: BoxDecoration(
//       color: Colors.orange[100],
//       borderRadius: BorderRadius.circular(12.r * sizeFactor),
//       border: Border.all(color: Colors.orange[300]!),
//     ),
//     child: Row(
//       children: [
//         Icon(
//           PhosphorIcons.warning(PhosphorIconsStyle.fill),
//           color: Colors.orange[800],
//           size: 20.sp * sizeFactor,
//         ),
//         Gap(12.w * sizeFactor),
//         Expanded(
//           child: GetTranslatableText(
//             'Please complete the payment using the QR codes below',
//             style: TextStyle(
//               fontSize: 12.sp * sizeFactor,
//               color: Colors.orange[900],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
// Widget _buildFeeSummary(PaymentData payment, sizeFactor) {
//   return Container(
//     margin: EdgeInsets.symmetric(horizontal: 16.w * sizeFactor),
//     padding: EdgeInsets.all(16.w * sizeFactor),
//     decoration: BoxDecoration(
//       color: Colors.grey[50],
//       borderRadius: BorderRadius.circular(12.r * sizeFactor),
//     ),
//     child: Column(
//       children: [
//         _buildFeeRow('Measurement Fee', payment.measurementFee,
//             payment.isMeasurementPaid, sizeFactor),
//         Gap(8.h * sizeFactor),
//         _buildFeeRow('Convenience Fee', payment.convenienceFee,
//             payment.isConveniencePaid, sizeFactor),
//         Gap(8.h * sizeFactor),
//         Divider(color: Colors.grey[300]),
//         Gap(8.h * sizeFactor),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             GetTranslatableText(
//               'Total Amount',
//               style: TextStyle(
//                 fontSize: 16.sp * sizeFactor,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.grey[800],
//               ),
//             ),
//             GetTranslatableText(
//               '₹${payment.totalAmount.toStringAsFixed(2)}',
//               style: TextStyle(
//                 fontSize: 20.sp * sizeFactor,
//                 fontWeight: FontWeight.bold,
//                 color: SetuColors.primaryGreen,
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }
//
// Widget _buildFeeRow(String label, String amount, bool isPaid, sizeFactor) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Row(
//         children: [
//           GetTranslatableText(
//             label,
//             style: TextStyle(
//               fontSize: 14.sp * sizeFactor,
//               color: Colors.grey[700],
//             ),
//           ),
//           if (isPaid) ...[
//             Gap(8.w * sizeFactor),
//             Icon(
//               PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
//               size: 16.sp * sizeFactor,
//               color: Colors.green[600],
//             ),
//           ],
//         ],
//       ),
//       GetTranslatableText(
//         '₹$amount',
//         style: TextStyle(
//           fontSize: 14.sp * sizeFactor,
//           fontWeight: FontWeight.w600,
//           color: isPaid ? Colors.green[600] : Colors.grey[800],
//           decoration: isPaid ? TextDecoration.lineThrough : null,
//         ),
//       ),
//     ],
//   );
// }
//
// Widget _buildQrSection({
//   required String title,
//   required String amount,
//   required String qrCode,
//   required String status,
//   required VoidCallback onTap,
//   required sizeFactor,
// }) {
//   return Container(
//     margin: EdgeInsets.all(16.w * sizeFactor),
//     padding: EdgeInsets.all(16.w * sizeFactor),
//     decoration: BoxDecoration(
//       border: Border.all(color: Colors.grey[300]!),
//       borderRadius: BorderRadius.circular(12.r * sizeFactor),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             GetTranslatableText(
//               title,
//               style: TextStyle(
//                 fontSize: 16.sp * sizeFactor,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.grey[800],
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 12.w * sizeFactor,
//                 vertical: 6.h * sizeFactor,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.orange[100],
//                 borderRadius: BorderRadius.circular(20.r * sizeFactor),
//               ),
//               child: GetTranslatableText(
//                 '₹$amount',
//                 style: TextStyle(
//                   fontSize: 14.sp * sizeFactor,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.orange[900],
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Gap(16.h * sizeFactor),
//         GestureDetector(
//           onTap: onTap,
//           child: Container(
//             padding: EdgeInsets.all(12.w * sizeFactor),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12.r * sizeFactor),
//               border: Border.all(color: Colors.grey[300]!),
//             ),
//             child: Column(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8.r * sizeFactor),
//                   child: Image.memory(
//                     base64Decode(qrCode.split(',')[1]),
//                     height: 200.h * sizeFactor,
//                     width: 200.w * sizeFactor,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 Gap(12.h * sizeFactor),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       PhosphorIcons.magnifyingGlassPlus(
//                           PhosphorIconsStyle.regular),
//                       size: 16.sp * sizeFactor,
//                       color: SetuColors.primaryGreen,
//                     ),
//                     Gap(8.w * sizeFactor),
//                     GetTranslatableText(
//                       'Tap to enlarge',
//                       style: TextStyle(
//                         fontSize: 12.sp * sizeFactor,
//                         color: SetuColors.primaryGreen,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Gap(12.h * sizeFactor),
//         Container(
//           padding: EdgeInsets.all(12.w * sizeFactor),
//           decoration: BoxDecoration(
//             color: Colors.blue[50],
//             borderRadius: BorderRadius.circular(8.r * sizeFactor),
//           ),
//           child: Row(
//             children: [
//               Icon(
//                 PhosphorIcons.info(PhosphorIconsStyle.regular),
//                 size: 16.sp * sizeFactor,
//                 color: Colors.blue[700],
//               ),
//               Gap(8.w * sizeFactor),
//               Expanded(
//                 child: GetTranslatableText(
//                   'Scan this QR code using any UPI app to pay',
//                   style: TextStyle(
//                     fontSize: 11.sp * sizeFactor,
//                     color: Colors.blue[900],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
// Widget _buildUpiDetails(PaymentData payment, sizeFactor) {
//   return Container(
//     margin: EdgeInsets.symmetric(horizontal: 16.w * sizeFactor),
//     padding: EdgeInsets.all(16.w * sizeFactor),
//     decoration: BoxDecoration(
//       color: Colors.purple[50],
//       borderRadius: BorderRadius.circular(12.r * sizeFactor),
//     ),
//     child: Row(
//       children: [
//         Icon(
//           PhosphorIcons.identificationCard(PhosphorIconsStyle.regular),
//           color: Colors.purple[700],
//           size: 20.sp * sizeFactor,
//         ),
//         Gap(12.w * sizeFactor),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GetTranslatableText(
//                 'UPI ID',
//                 style: TextStyle(
//                   fontSize: 11.sp * sizeFactor,
//                   color: Colors.purple[700],
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               Gap(4.h * sizeFactor),
//               GetTranslatableText(
//                 payment.upiId,
//                 style: TextStyle(
//                   fontSize: 14.sp * sizeFactor,
//                   color: Colors.purple[900],
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:convert';
import '../../../../../../Constants/color_constant.dart';
import '../../../../../../Controller/get_translation_controller/get_text_form.dart';
import '../../../../../../Models/payment_model.dart';
import '../../../../../../Utils/custimize_image_picker.dart';

Widget buildPaymentContent(PaymentData payment, controller, sizeFactor) {
  return Container(
    margin: EdgeInsets.all(16.w * sizeFactor),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r * sizeFactor),
      border: Border.all(
        color: Colors.green.shade100, // Light green color
      ),
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
        _buildPaymentHeader(payment, sizeFactor),
        // if (!payment.isFullyPaid) _buildStatusBanner(payment, sizeFactor),
        _buildFeeSummary(payment, sizeFactor),
        _buildUpiDetails(payment, sizeFactor),
        if (!payment.isMeasurementPaid)
          _buildQrSection(
            title: 'Measurement Fee',
            amount: payment.measurementFee,
            qrCode: payment.measurementQrCode,
            status: payment.measurementPaymentStatus,
            sizeFactor: sizeFactor,
            onTap: () => controller.openQrCodeFullScreen(
              payment.measurementQrCode,
              'Measurement Fee QR Code',
            ),
          ),
        _buildChalanUploadSections(payment, sizeFactor, controller),
        _buildPaymentStatus(
          status: payment.measurementPaymentStatus,
          sizeFactor: sizeFactor,
        ),
        if (!payment.isConveniencePaid)
          _buildQrSection(
            title: 'Convenience Fee',
            amount: payment.convenienceFee,
            qrCode: payment.convenienceQrCode,
            status: payment.conveniencePaymentStatus,
            sizeFactor: sizeFactor,
            onTap: () => controller.openQrCodeFullScreen(
              payment.convenienceQrCode,
              'Convenience Fee QR Code',
            ),
          ),
        _buildConenienceUploadSections(payment, sizeFactor, controller),
        _buildPaymentStatus(
          status: payment.conveniencePaymentStatus,
          sizeFactor: sizeFactor,
        ),
        Gap(16.h * sizeFactor),
      ],
    ),
  );
}

Widget buildStatusCard({
  required double sizeFactor,
  required List<Color> gradientColors,
  required Color shadowColor,
  required IconData icon,
  required String title,
  required String description,
  required String infoMessage,
}) {
  return Container(
    margin: EdgeInsets.all(16.w * sizeFactor),
    padding: EdgeInsets.all(24.w * sizeFactor),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: gradientColors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.r * sizeFactor),
      boxShadow: [
        BoxShadow(
          color: shadowColor.withOpacity(0.3),
          blurRadius: 15,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(16.w * sizeFactor),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 64.sp * sizeFactor,
          ),
        ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
        Gap(20.h * sizeFactor),
        GetTranslatableText(
          title,
          style: TextStyle(
            fontSize: 24.sp * sizeFactor,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ).animate().fadeIn(duration: 400.ms),
        Gap(8.h * sizeFactor),
        GetTranslatableText(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp * sizeFactor,
            color: Colors.white.withOpacity(0.9),
            height: 1.5,
          ),
        ),
        Gap(20.h * sizeFactor),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w * sizeFactor,
            vertical: 12.h * sizeFactor,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8.r * sizeFactor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                PhosphorIcons.info(PhosphorIconsStyle.fill),
                color: Colors.white,
                size: 16.sp * sizeFactor,
              ),
              Gap(8.w * sizeFactor),
              Expanded(
                child: GetTranslatableText(
                  infoMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp * sizeFactor,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
      ],
    ),
  );
}

Widget _buildPaymentStatus({
  required String status,
  required double sizeFactor,
}) {
  Color backgroundColor;
  Color textColor;
  Color iconColor;
  IconData icon;
  String message;

  switch (status.toLowerCase()) {
    case 'pending':
      backgroundColor = Colors.orange.shade50;
      textColor = Colors.orange.shade800;
      iconColor = Colors.orange.shade600;
      icon = PhosphorIcons.clock(PhosphorIconsStyle.fill);
      message = 'Your payment is pending';
      break;
    case 'under review':
      backgroundColor = Colors.blue.shade50;
      textColor = Colors.blue.shade800;
      iconColor = Colors.blue.shade600;
      icon = PhosphorIcons.uploadSimple(PhosphorIconsStyle.fill);
      message = 'Payment receipt submitted for review';
      break;
    case 'completed':
      backgroundColor = Colors.green.shade50;
      textColor = Colors.green.shade800;
      iconColor = Colors.green.shade600;
      icon = PhosphorIcons.checkCircle(PhosphorIconsStyle.fill);
      message = 'Payment approved successfully';
      break;
    case 'failed':
      backgroundColor = Colors.red.shade50;
      textColor = Colors.red.shade800;
      iconColor = Colors.red.shade600;
      icon = PhosphorIcons.xCircle(PhosphorIconsStyle.fill);
      message = 'Payment failed. Please try again';
      break;
    default:
      backgroundColor = Colors.grey.shade50;
      textColor = Colors.grey.shade800;
      iconColor = Colors.grey.shade600;
      icon = PhosphorIcons.info(PhosphorIconsStyle.fill);
      message = 'Please pay the bill';
  }

  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 16.w * sizeFactor,
      vertical: 8.h * sizeFactor,
    ),
    padding: EdgeInsets.all(16.w * sizeFactor),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12.r * sizeFactor),
      border: Border.all(
        color: iconColor.withOpacity(0.3),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: iconColor.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 40.w * sizeFactor,
          height: 40.w * sizeFactor,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: iconColor.withOpacity(0.2),
                blurRadius: 8,
              ),
            ],
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 20.sp * sizeFactor,
          ),
        ),
        Gap(12.w * sizeFactor),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                status.toUpperCase(),
                style: TextStyle(
                  fontSize: 11.sp * sizeFactor,
                  fontWeight: FontWeight.w600,
                  color: textColor.withOpacity(0.7),
                  letterSpacing: 0.5,
                ),
              ),
              Gap(2.h * sizeFactor),
              Text(
                message,
                style: TextStyle(
                  fontSize: 14.sp * sizeFactor,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0);
}

Widget _buildChalanUploadSections(PaymentData payment, sizeFactor, controller) {
  return Column(
    children: [
      Gap(8.h * sizeFactor),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w * sizeFactor),
        padding: EdgeInsets.all(16.w * sizeFactor),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r * sizeFactor),
          border: Border.all(
            color: SetuColors.primaryGreen.withOpacity(0.2),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40.w * sizeFactor,
                  height: 40.w * sizeFactor,
                  decoration: BoxDecoration(
                    color: SetuColors.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r * sizeFactor),
                  ),
                  child: Icon(
                    PhosphorIcons.uploadSimple(PhosphorIconsStyle.regular),
                    color: SetuColors.primaryGreen,
                    size: 20.sp * sizeFactor,
                  ),
                ),
                Gap(12.w * sizeFactor),
                Expanded(
                  child: GetTranslatableText(
                    'Grass Chalan Submission',
                    style: TextStyle(
                      fontSize: 16.sp * sizeFactor,
                      fontWeight: FontWeight.bold,
                      color: SetuColors.primaryGreen,
                    ),
                  ),
                ),
                Obx(() => controller.measurementUploadSuccess.value
                    ? Icon(
                        PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                        color: Colors.green,
                        size: 20.sp * sizeFactor,
                      )
                    : const SizedBox.shrink()),
              ],
            ),
            Gap(16.h * sizeFactor),
            Divider(height: 1, color: Colors.grey[200]),
            Gap(16.h * sizeFactor),
            ImagePickerUtil.buildFileUploadField(
              label: 'Measurement Chalan Document *',
              hint: 'Upload Payment Screenshot/Receipt',
              icon: PhosphorIcons.fileText(PhosphorIconsStyle.regular),
              uploadedFiles: controller.measurementChalanFiles,
              onFilesSelected: (files) => controller
                  .measurementChalanFiles.value = List<String>.from(files),
            ),
            Gap(16.h * sizeFactor),
            Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isMeasurementUploading.value ||
                            controller.measurementChalanFiles.isEmpty
                        ? null
                        : () => controller.uploadMeasurementChalan(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SetuColors.primaryGreen,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey[300],
                      padding: EdgeInsets.symmetric(
                        vertical: 14.h * sizeFactor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r * sizeFactor),
                      ),
                      elevation: 0,
                    ),
                    child: controller.isMeasurementUploading.value
                        ? SizedBox(
                            height: 20.h * sizeFactor,
                            width: 20.h * sizeFactor,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                PhosphorIcons.paperPlaneTilt(
                                    PhosphorIconsStyle.fill),
                                size: 18.sp * sizeFactor,
                              ),
                              Gap(8.w * sizeFactor),
                              GetTranslatableText(
                                'Submit Measurement Chalan',
                                style: TextStyle(
                                  fontSize: 14.sp * sizeFactor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                  ),
                )),
          ],
        ),
      ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0),
      Gap(12.h * sizeFactor),
    ],
  );
}

Widget _buildConenienceUploadSections(
    PaymentData payment, sizeFactor, controller) {
  return Column(
    children: [
      Gap(8.h * sizeFactor),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w * sizeFactor),
        padding: EdgeInsets.all(16.w * sizeFactor),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r * sizeFactor),
          border: Border.all(
            color: SetuColors.primaryGreen.withOpacity(0.2),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40.w * sizeFactor,
                  height: 40.w * sizeFactor,
                  decoration: BoxDecoration(
                    color: SetuColors.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r * sizeFactor),
                  ),
                  child: Icon(
                    PhosphorIcons.uploadSimple(PhosphorIconsStyle.regular),
                    color: SetuColors.primaryGreen,
                    size: 20.sp * sizeFactor,
                  ),
                ),
                Gap(12.w * sizeFactor),
                Expanded(
                  child: GetTranslatableText(
                    'Convenience Fee Submission',
                    style: TextStyle(
                      fontSize: 16.sp * sizeFactor,
                      fontWeight: FontWeight.bold,
                      color: SetuColors.primaryGreen,
                    ),
                  ),
                ),
                Obx(() => controller.convenienceUploadSuccess.value
                    ? Icon(
                        PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                        color: Colors.green,
                        size: 20.sp * sizeFactor,
                      )
                    : const SizedBox.shrink()),
              ],
            ),
            Gap(16.h * sizeFactor),
            Divider(height: 1, color: Colors.grey[200]),
            Gap(16.h * sizeFactor),
            ImagePickerUtil.buildFileUploadField(
              label: 'Convenience Chalan Document *',
              hint: 'Upload Payment Screenshot/Receipt',
              icon: PhosphorIcons.fileText(PhosphorIconsStyle.regular),
              uploadedFiles: controller.convenienceChalanFiles,
              onFilesSelected: (files) => controller
                  .convenienceChalanFiles.value = List<String>.from(files),
            ),
            Gap(16.h * sizeFactor),
            Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isConvenienceUploading.value ||
                            controller.convenienceChalanFiles.isEmpty
                        ? null
                        : () => controller.uploadConvenienceChalan(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SetuColors.primaryGreen,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey[300],
                      padding: EdgeInsets.symmetric(
                        vertical: 14.h * sizeFactor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r * sizeFactor),
                      ),
                      elevation: 0,
                    ),
                    child: controller.isConvenienceUploading.value
                        ? SizedBox(
                            height: 20.h * sizeFactor,
                            width: 20.h * sizeFactor,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                PhosphorIcons.paperPlaneTilt(
                                    PhosphorIconsStyle.fill),
                                size: 18.sp * sizeFactor,
                              ),
                              Gap(8.w * sizeFactor),
                              GetTranslatableText(
                                'Submit Convenience Chalan',
                                style: TextStyle(
                                  fontSize: 14.sp * sizeFactor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                  ),
                )),
          ],
        ),
      ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0),
      Gap(8.h * sizeFactor),
    ],
  );
}

Widget _buildPaymentHeader(PaymentData payment, sizeFactor) {
  return Container(
    padding: EdgeInsets.all(20.w * sizeFactor),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: payment.isFullyPaid
            ? [Colors.green[600]!, Colors.green[500]!]
            : [Colors.orange[600]!, Colors.orange[500]!],
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.r * sizeFactor),
        topRight: Radius.circular(16.r * sizeFactor),
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 50.w * sizeFactor,
          height: 50.w * sizeFactor,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r * sizeFactor),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              ),
            ],
          ),
          child: Icon(
            payment.isFullyPaid
                ? PhosphorIcons.checkCircle(PhosphorIconsStyle.fill)
                : PhosphorIcons.wallet(PhosphorIconsStyle.fill),
            size: 28.sp * sizeFactor,
            color: payment.isFullyPaid ? Colors.green[600] : Colors.orange[600],
          ),
        ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
        Gap(16.w * sizeFactor),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetTranslatableText(
                payment.isFullyPaid ? 'Payment Complete' : 'Payment Required',
                style: TextStyle(
                  fontSize: 18.sp * sizeFactor,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Gap(4.h * sizeFactor),
              GetTranslatableText(
                payment.transactionNote,
                style: TextStyle(
                  fontSize: 12.sp * sizeFactor,
                  color: Colors.white.withOpacity(0.9),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ).animate().fadeIn(duration: 400.ms);
}

Widget _buildStatusBanner(PaymentData payment, sizeFactor) {
  return Container(
    margin: EdgeInsets.all(16.w * sizeFactor),
    padding: EdgeInsets.all(14.w * sizeFactor),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.orange[50]!,
          Colors.orange[100]!,
        ],
      ),
      borderRadius: BorderRadius.circular(12.r * sizeFactor),
      border: Border.all(
        color: Colors.orange[300]!,
        width: 1.5,
      ),
    ),
    child: Row(
      children: [
        Icon(
          PhosphorIcons.warning(PhosphorIconsStyle.fill),
          color: Colors.orange[800],
          size: 22.sp * sizeFactor,
        ),
        Gap(12.w * sizeFactor),
        Expanded(
          child: GetTranslatableText(
            'Please complete the payment using the QR codes below',
            style: TextStyle(
              fontSize: 13.sp * sizeFactor,
              color: Colors.orange[900],
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1, end: 0);
}

Widget _buildFeeSummary(PaymentData payment, sizeFactor) {
  return Container(
    margin: EdgeInsets.all(16.w * sizeFactor),
    padding: EdgeInsets.all(16.w * sizeFactor),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r * sizeFactor),
      border: Border.all(
        color: Colors.grey[200]!,
        width: 1.5,
      ),
    ),
    child: Column(
      children: [
        _buildFeeRow('Measurement Fee', payment.measurementFee,
            payment.isMeasurementPaid, sizeFactor),
        Gap(12.h * sizeFactor),
        _buildFeeRow('Convenience Fee', payment.convenienceFee,
            payment.isConveniencePaid, sizeFactor),
        Gap(12.h * sizeFactor),
        Divider(color: Colors.grey[300], thickness: 1),
        Gap(12.h * sizeFactor),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GetTranslatableText(
              'Total Amount',
              style: TextStyle(
                fontSize: 16.sp * sizeFactor,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            GetTranslatableText(
              '₹${payment.totalAmount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20.sp * sizeFactor,
                fontWeight: FontWeight.bold,
                color: SetuColors.primaryGreen,
              ),
            ),
          ],
        ),
      ],
    ),
  ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0);
}

Widget _buildFeeRow(String label, String amount, bool isPaid, sizeFactor) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          GetTranslatableText(
            label,
            style: TextStyle(
              fontSize: 14.sp * sizeFactor,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          if (isPaid) ...[
            Gap(8.w * sizeFactor),
            Icon(
              PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
              size: 16.sp * sizeFactor,
              color: Colors.green[600],
            ),
          ],
        ],
      ),
      GetTranslatableText(
        '₹$amount',
        style: TextStyle(
          fontSize: 14.sp * sizeFactor,
          fontWeight: FontWeight.w600,
          color: isPaid ? Colors.green[600] : Colors.grey[800],
          decoration: isPaid ? TextDecoration.lineThrough : null,
        ),
      ),
    ],
  );
}

Widget _buildQrSection({
  required String title,
  required String amount,
  required String qrCode,
  required String status,
  required VoidCallback onTap,
  required sizeFactor,
}) {
  return Container(
    margin: EdgeInsets.all(16.w * sizeFactor),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r * sizeFactor),
      border: Border.all(
        color: SetuColors.primaryGreen.withOpacity(0.2),
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
                  PhosphorIcons.qrCode(PhosphorIconsStyle.regular),
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
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w * sizeFactor,
                  vertical: 6.h * sizeFactor,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange[400]!, Colors.orange[600]!],
                  ),
                  borderRadius: BorderRadius.circular(20.r * sizeFactor),
                ),
                child: GetTranslatableText(
                  '₹$amount',
                  style: TextStyle(
                    fontSize: 13.sp * sizeFactor,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
            children: [
              GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: EdgeInsets.all(12.w * sizeFactor),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12.r * sizeFactor),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r * sizeFactor),
                        child: Image.memory(
                          base64Decode(qrCode.split(',')[1]),
                          height: 200.h * sizeFactor,
                          width: 200.w * sizeFactor,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Gap(12.h * sizeFactor),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            PhosphorIcons.magnifyingGlassPlus(
                                PhosphorIconsStyle.fill),
                            size: 16.sp * sizeFactor,
                            color: SetuColors.primaryGreen,
                          ),
                          Gap(8.w * sizeFactor),
                          GetTranslatableText(
                            'Tap to enlarge',
                            style: TextStyle(
                              fontSize: 12.sp * sizeFactor,
                              color: SetuColors.primaryGreen,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Gap(12.h * sizeFactor),
              Container(
                padding: EdgeInsets.all(12.w * sizeFactor),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue[50]!,
                      Colors.blue[100]!,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8.r * sizeFactor),
                  border: Border.all(
                    color: Colors.blue[200]!,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      PhosphorIcons.info(PhosphorIconsStyle.fill),
                      size: 16.sp * sizeFactor,
                      color: Colors.blue[700],
                    ),
                    Gap(8.w * sizeFactor),
                    Expanded(
                      child: GetTranslatableText(
                        'Scan this QR code using any UPI app to pay',
                        style: TextStyle(
                          fontSize: 12.sp * sizeFactor,
                          color: Colors.blue[900],
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
        ),
      ],
    ),
  ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0);
}

Widget _buildUpiDetails(PaymentData payment, sizeFactor) {
  return GestureDetector(
    onTap: () {
      Clipboard.setData(ClipboardData(text: payment.upiId));
      // Show toast message
      Fluttertoast.showToast(
        msg: "UPI ID copied!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.purple[700],
        textColor: Colors.white,
        fontSize: 14.sp * sizeFactor,
      );
    },
    child: Container(
      margin: EdgeInsets.all(16.w * sizeFactor),
      padding: EdgeInsets.all(16.w * sizeFactor),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple[50]!,
            Colors.purple[100]!,
          ],
        ),
        borderRadius: BorderRadius.circular(12.r * sizeFactor),
        border: Border.all(
          color: Colors.purple[200]!,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w * sizeFactor,
            height: 40.w * sizeFactor,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r * sizeFactor),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.2),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Icon(
              PhosphorIcons.identificationCard(PhosphorIconsStyle.fill),
              color: Colors.purple[700],
              size: 20.sp * sizeFactor,
            ),
          ),
          Gap(12.w * sizeFactor),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetTranslatableText(
                  'UPI ID',
                  style: TextStyle(
                    fontSize: 11.sp * sizeFactor,
                    color: Colors.purple[700],
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                Gap(4.h * sizeFactor),
                GetTranslatableText(
                  payment.upiId,
                  style: TextStyle(
                    fontSize: 14.sp * sizeFactor,
                    color: Colors.purple[900],
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            PhosphorIcons.copy(PhosphorIconsStyle.regular),
            color: Colors.purple[600],
            size: 18.sp * sizeFactor,
          ),
        ],
      ),
    ),
  ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0);
}
