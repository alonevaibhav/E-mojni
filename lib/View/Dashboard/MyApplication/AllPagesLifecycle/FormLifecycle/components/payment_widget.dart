//
// import 'package:emojni/View/Dashboard/MyApplication/AllPagesLifecycle/FormLifecycle/components/payment_component.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
// import '../../../../../../Controller/Dashboard/MyApplication/LifecycleController/life_counting_controller.dart';
// import '../../../../../../Models/counting_land_model.dart';
// import '../../../../../../State/ui_state_manegment.dart';
//
// class PaymentWidget extends StatelessWidget {
//   final double sizeFactor;
//   final LifeCountingController controller;
//   final CountingLandForm form;
//
//   const PaymentWidget({
//     super.key,
//     required this.sizeFactor,
//     required this.controller,
//     required this.form,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final sizeFactor = 0.85;
//
//     // Check form status
//     final status = form.status?.toLowerCase() ?? '';
//
//     // if (status == 'pending') {
//     //   return buildStatusCard(
//     //     sizeFactor: sizeFactor,
//     //     gradientColors: [Colors.orange[400]!, Colors.orange[600]!],
//     //     shadowColor: Colors.orange,
//     //     icon: PhosphorIcons.clockCounterClockwise(PhosphorIconsStyle.fill),
//     //     title: 'Form Under Review',
//     //     description:
//     //         'Your application form is currently pending review by our team',
//     //     infoMessage: 'Payment details will be available after approval',
//     //   );
//     // }
//     //
//     // if (status == 'verified') {
//     //   return buildStatusCard(
//     //     sizeFactor: sizeFactor,
//     //     gradientColors: [Colors.blue[400]!, Colors.blue[600]!],
//     //     shadowColor: Colors.blue,
//     //     icon: PhosphorIcons.sealCheck(PhosphorIconsStyle.fill),
//     //     title: 'Form Verified',
//     //     description:
//     //         'Your application form has been successfully verified and approved',
//     //     infoMessage: 'Please proceed with the payment process',
//     //   );
//     // }
//     //
//     // if (status == 'rejected') {
//     //   return buildStatusCard(
//     //     sizeFactor: sizeFactor,
//     //     gradientColors: [Colors.red[400]!, Colors.red[600]!],
//     //     shadowColor: Colors.red,
//     //     icon: PhosphorIcons.xCircle(PhosphorIconsStyle.fill),
//     //     title: 'Form Rejected',
//     //     description:
//     //         'Unfortunately, your application form has been rejected after review',
//     //     infoMessage: 'Please contact support for more details or resubmit',
//     //   );
//     // }
//
//     return controller.obx(
//       (paymentData) {
//         // Check if both payments are completed
//         if (paymentData!.measurementPaymentStatus.toLowerCase() == 'completed' &&
//             paymentData.conveniencePaymentStatus.toLowerCase() == 'completed') {
//           return buildStatusCard(
//             sizeFactor: sizeFactor,
//             gradientColors: [Colors.green[400]!, Colors.green[600]!],
//             shadowColor: Colors.green,
//             icon: PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
//             title: 'Payment Completed!',
//             description:
//                 'Both measurement and convenience fees have been successfully paid',
//             infoMessage: 'Your application is being processed',
//           );
//         }
//         return buildPaymentContent(paymentData, controller, sizeFactor);
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
// }



import 'package:emojni/View/Dashboard/MyApplication/AllPagesLifecycle/FormLifecycle/components/payment_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../../../State/ui_state_manegment.dart';

class PaymentWidget extends StatelessWidget {
  final double sizeFactor;
  final StateMixin controller;
  final VoidCallback onRefresh;
  final String? formStatus;

  const PaymentWidget({
    super.key,
    required this.sizeFactor,
    required this.controller,
    required this.onRefresh,
    this.formStatus,
  });

  @override
  Widget build(BuildContext context) {
    // Use the passed sizeFactor, not hardcoded
    final status = formStatus?.toLowerCase() ?? '';

    // Check form status first
    if (status == 'pending') {
      return buildStatusCard(
        sizeFactor: sizeFactor,
        gradientColors: [Colors.orange[400]!, Colors.orange[600]!],
        shadowColor: Colors.orange,
        icon: PhosphorIcons.clockCounterClockwise(PhosphorIconsStyle.fill),
        title: 'Form Under Review',
        description:
        'Your application form is currently pending review by our team',
        infoMessage: 'Payment details will be available after approval',
      );
    }

    if (status == 'verified') {
      return buildStatusCard(
        sizeFactor: sizeFactor,
        gradientColors: [Colors.blue[400]!, Colors.blue[600]!],
        shadowColor: Colors.blue,
        icon: PhosphorIcons.sealCheck(PhosphorIconsStyle.fill),
        title: 'Form Verified',
        description:
        'Your application form has been successfully verified and approved',
        infoMessage: 'Please proceed with the payment process',
      );
    }

    if (status == 'rejected') {
      return buildStatusCard(
        sizeFactor: sizeFactor,
        gradientColors: [Colors.red[400]!, Colors.red[600]!],
        shadowColor: Colors.red,
        icon: PhosphorIcons.xCircle(PhosphorIconsStyle.fill),
        title: 'Form Rejected',
        description:
        'Unfortunately, your application form has been rejected after review',
        infoMessage: 'Please contact support for more details or resubmit',
      );
    }

    // If status is not pending/verified/rejected, show payment widget
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
        onRetry: onRefresh, // Use the passed callback
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