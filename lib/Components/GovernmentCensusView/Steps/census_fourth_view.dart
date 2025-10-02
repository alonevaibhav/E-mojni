import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:get/get.dart';
import '../Controller/main_controller.dart';
import '../Controller/census_fourth_controller.dart';
import 'ZLandAcquisitionUIUtils.dart';

class CensusFourthView extends StatelessWidget {
  final int currentSubStep;
  final GovernmentCensusController mainController;

  const CensusFourthView({
    Key? key,
    required this.currentSubStep,
    required this.mainController,
  }) : super(key: key);

  // Get the CensusFourthController
  CensusFourthController get controller => Get.find<CensusFourthController>(tag: 'census_fourth');

  @override
  Widget build(BuildContext context) {
    // Get the substeps from main controller configuration
    final subSteps = mainController.stepConfigurations[3] ?? ['calculation'];

    // Ensure currentSubStep is within bounds
    if (currentSubStep >= subSteps.length) {
      return _buildCalculationDetails(); // Fallback
    }

    final currentField = subSteps[currentSubStep];

    switch (currentField) {
      case 'calculation':
        return _buildCalculationDetails();
      default:
        return _buildCalculationDetails();
    }
  }

  Widget _buildCalculationDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GovernmentCensusUIUtils.buildStepHeader(
          'Government Census Calculation',
          'Please provide calculation details',
        ),
        Gap(24.h),

        // Calculation Type
        Obx(() => GovernmentCensusUIUtils.buildDropdownField(
          label: 'Calculation type *',
          value: controller.selectedCalculationType.value?? '',
          items: controller.calculationTypeOptions,
          onChanged: controller.updateCalculationType,
          icon: PhosphorIcons.calculator(PhosphorIconsStyle.regular),
        )),
        Gap(16.h),

        // Duration
        Obx(() => GovernmentCensusUIUtils.buildDropdownField(
          label: 'Duration *',
          value: controller.selectedDuration.value ?? '',
          items: controller.durationOptions,
          onChanged: controller.updateDuration,
          icon: PhosphorIcons.clock(PhosphorIconsStyle.regular),
        )),
        Gap(16.h),

        // Holder Type
        Obx(() => GovernmentCensusUIUtils.buildDropdownField(
          label: 'Holder type *',
          value: controller.selectedHolderType.value ?? '',
          items: controller.holderTypeOptions,
          onChanged: controller.updateHolderType,
          icon: PhosphorIcons.users(PhosphorIconsStyle.regular),
        )),
        Gap(16.h),

        // Calculation Fee Rate
        // Obx(() => GovernmentCensusUIUtils.buildDropdownField(
        //   label: 'Calculation fee rate *',
        //   value: controller.selectedCalculationFeeRate.value ?? '',
        //   items: controller.calculationFeeRateOptions,
        //   onChanged: controller.updateCalculationFeeRate,
        //   icon: PhosphorIcons.currencyInr(PhosphorIconsStyle.regular),
        // )),
        // Gap(24.h),

        // Counting Fee Display
        // Obx(() => Container(
        //   padding: EdgeInsets.all(16.w),
        //   decoration: BoxDecoration(
        //     color: Color(0xFFF8F9FA),
        //     borderRadius: BorderRadius.circular(12.r),
        //     border: Border.all(color: Color(0xFFE9ECEF)),
        //   ),
        //   child: Row(
        //     children: [
        //       Icon(
        //         PhosphorIcons.currencyInr(PhosphorIconsStyle.regular),
        //         color: Color(0xFF6C757D),
        //         size: 20.w,
        //       ),
        //       Gap(12.w),
        //       Text(
        //         'Counting Fee:',
        //         style: TextStyle(
        //           fontSize: 14.sp,
        //           fontWeight: FontWeight.w500,
        //           color: Color(0xFF495057),
        //         ),
        //       ),
        //       Spacer(),
        //       Text(
        //         '₹${controller.countingFee.value}',
        //         style: TextStyle(
        //           fontSize: 18.sp,
        //           fontWeight: FontWeight.bold,
        //           color: Color(0xFF28A745),
        //         ),
        //       ),
        //     ],
        //   ),
        // )),
        // Gap(32.h),

        // Navigation Buttons
        GovernmentCensusUIUtils.buildNavigationButtons(mainController),
      ],
    );
  }
}