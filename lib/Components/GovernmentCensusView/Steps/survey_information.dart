import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../Constants/color_constant.dart';
import '../../GovernmentCensusView/Controller/step_three_controller.dart';
import '../Controller/main_controller.dart';
import 'ZLandAcquisitionUIUtils.dart';

class CalculationInformation extends StatelessWidget {
  final int currentSubStep;
  final GovernmentCensusController controller;

  const CalculationInformation({
    Key? key,
    required this.currentSubStep,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subSteps = controller.stepConfigurations[2] ?? ['government_survey'];

    if (currentSubStep >= subSteps.length) {
      return _buildGovernmentSurveyInput();
    }

    final currentField = subSteps[currentSubStep];

    switch (currentField) {
      case 'government_survey':
        return _buildGovernmentSurveyInput();
      default:
        return _buildGovernmentSurveyInput();
    }
  }

  Widget _buildGovernmentSurveyInput() {
    // final surveyController = Get.put(GovernmentSurveyController(), tag: 'government_survey');
    final surveyController = Get.put(CalculationController(), tag: 'calculation');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Custom Header with different styling

        // Survey Entries Section
        _buildSurveyEntries(surveyController),

        Gap(32.h * GovernmentCensusUIUtils.sizeFactor),
        GovernmentCensusUIUtils.buildNavigationButtons(controller),
      ],
    );
  }

  Widget _buildSurveyEntries(CalculationController surveyController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Survey Entries List
        Obx(() => Column(
          children: [
            for (int i = 0; i < surveyController.surveyEntries.length; i++)
              _buildSurveyEntryCard(surveyController, i),
          ],
        )),

        Gap(16.h * GovernmentCensusUIUtils.sizeFactor),

        // Add Another Entry Button
        InkWell(
          onTap: surveyController.addSurveyEntry,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 16.w * GovernmentCensusUIUtils.sizeFactor,
              vertical: 16.h * GovernmentCensusUIUtils.sizeFactor,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: SetuColors.primaryGreen,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12.r),
              color: SetuColors.primaryGreen.withOpacity(0.05),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  PhosphorIcons.plus(PhosphorIconsStyle.bold),
                  color: SetuColors.primaryGreen,
                  size: 24.sp * GovernmentCensusUIUtils.sizeFactor,
                ),
                Gap(12.w * GovernmentCensusUIUtils.sizeFactor),
                Text(
                  'Fill in more information',
                  style: TextStyle(
                    fontSize: 16.sp * GovernmentCensusUIUtils.sizeFactor,
                    color: SetuColors.primaryGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSurveyEntryCard(CalculationController surveyController, int index) {
    final entry = surveyController.surveyEntries[index];

    return Container(
      margin: EdgeInsets.only(bottom: 20.h * GovernmentCensusUIUtils.sizeFactor),
      padding: EdgeInsets.all(20.w * GovernmentCensusUIUtils.sizeFactor),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: SetuColors.primaryGreen.withOpacity(0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w * GovernmentCensusUIUtils.sizeFactor,
                  vertical: 8.h * GovernmentCensusUIUtils.sizeFactor,
                ),
                decoration: BoxDecoration(
                  color: SetuColors.primaryGreen,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Entry ${index + 1}',
                  style: TextStyle(
                    fontSize: 14.sp * GovernmentCensusUIUtils.sizeFactor,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              if (surveyController.surveyEntries.length > 1)
                InkWell(
                  onTap: () => surveyController.removeSurveyEntry(index),
                  child: Container(
                    padding: EdgeInsets.all(8.w * GovernmentCensusUIUtils.sizeFactor),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      PhosphorIcons.trash(PhosphorIconsStyle.regular),
                      color: Colors.red,
                      size: 18.sp * GovernmentCensusUIUtils.sizeFactor,
                    ),
                  ),
                ),
            ],
          ),
          Gap(20.h * GovernmentCensusUIUtils.sizeFactor),

          // Survey No./Group No. Input
          GovernmentCensusUIUtils.buildTextFormField(
            controller: entry['surveyNoController'],
            label: 'Survey No./Gat No./CTS No. *',
            hint: 'Enter Survey No./Gat No./CTS No',
            icon: PhosphorIcons.numberSquareOne(PhosphorIconsStyle.regular),
            onChanged: (value) =>
                surveyController.updateSurveyEntry(index, 'surveyNo', value),
          ),

          Gap(16.h * GovernmentCensusUIUtils.sizeFactor),

          // Part No. Input
          GovernmentCensusUIUtils.buildTextFormField(
            controller: entry['partNoController'],
            label: 'Part No. *',
            hint: 'Enter part number',
            icon: PhosphorIcons.divide(PhosphorIconsStyle.regular),
            onChanged: (value) =>
                surveyController.updateSurveyEntry(index, 'partNo', value),
          ),

          Gap(16.h * GovernmentCensusUIUtils.sizeFactor),

          // Area Input
          GovernmentCensusUIUtils.buildTextFormField(
            controller: entry['areaController'],
            label: 'Area *',
            hint: 'Enter area (in acres/hectares)',
            icon: PhosphorIcons.square(PhosphorIconsStyle.regular),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) =>
                surveyController.updateSurveyEntry(index, 'area', value),
          ),

          Gap(16.h * GovernmentCensusUIUtils.sizeFactor),

        ],
      ),
    );
  }
}
