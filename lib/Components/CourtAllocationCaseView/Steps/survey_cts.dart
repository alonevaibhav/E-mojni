
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../Controller/main_controller.dart';
import '../Controller/survey_cts.dart';
import 'ZLandAcquisitionUIUtils.dart';

class SurveyCTSStep extends StatelessWidget {
  final int currentSubStep;
  final CourtAllocationCaseController mainController;

  const SurveyCTSStep({
    Key? key,
    required this.currentSubStep,
    required this.mainController,
  }) : super(key: key);

  // Get the SurveyCTSController
  SurveyCTSController get controller => Get.find<SurveyCTSController>(tag: 'survey_cts');

  @override
  Widget build(BuildContext context) {
    // Get the substeps from main controller configuration
    final subSteps = mainController.stepConfigurations[1] ?? ['survey_number'];

    // Ensure currentSubStep is within bounds
    if (currentSubStep >= subSteps.length) {
      return _buildSurveyNumberInput(); // Fallback
    }

    final currentField = subSteps[currentSubStep];

    switch (currentField) {
      case 'survey_number':
        return _buildSurveyNumberInput();
      case 'department':
        return _buildDepartmentInput();
      case 'district':
        return _buildDistrictInput();
      case 'taluka':
        return _buildTalukaInput();
      case 'village':
        return _buildVillageInput();
      // case 'office':
      //   return _buildOfficeInput();
      default:
        return _buildSurveyNumberInput();
    }
  }


  Widget _buildSurveyNumberInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CourtAllocationCaseUIUtils.buildStepHeader(
          'Group No./ Survey No./ C. T. Survey No./T. P. No. Information',
          // 'Enter Survey No./Gat No./CTS No.',
        ),
        Gap(24.h),



        CourtAllocationCaseUIUtils.buildTextFormField(
          controller: controller.surveyCtsNumber,
          label: 'Survey No./Gat No./CTS No.*',
          hint: 'Enter Survey No./Gat No./CTS No.',
          icon: PhosphorIcons.mapPin(PhosphorIconsStyle.regular),
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.trim().length < 3) {
              return 'Please enter the name of the applicant';
            }
            return null;
          },
        ),

        Gap(32.h),
        CourtAllocationCaseUIUtils.buildNavigationButtons(mainController),
      ],
    );
  }

  Widget _buildDepartmentInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CourtAllocationCaseUIUtils.buildStepHeader(
          'Department Information',
          'Select your department',
        ),
        Gap(24.h),
        Obx(() => CourtAllocationCaseUIUtils.buildDropdownField(
          label: 'Department*',
          value: controller.selectedDepartment.value,
          items: controller.departmentOptions,
          onChanged: controller.updateDepartment,
          icon: PhosphorIcons.buildings(PhosphorIconsStyle.regular),
        )),
        Gap(32.h),
        CourtAllocationCaseUIUtils.buildNavigationButtons(mainController),
      ],
    );
  }

  Widget _buildDistrictInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CourtAllocationCaseUIUtils.buildStepHeader(
          'Location Details',
          'Enter your district',
        ),
        Gap(24.h),
        CourtAllocationCaseUIUtils.buildTextFormField(
          controller: controller.districtController,
          label: 'District*',
          hint: 'Enter district name',
          icon: PhosphorIcons.mapPin(PhosphorIconsStyle.regular),
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter the district';
            }
            return null;
          },
        ),
        Gap(32.h),
        CourtAllocationCaseUIUtils.buildNavigationButtons(mainController),
      ],
    );
  }

  Widget _buildTalukaInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CourtAllocationCaseUIUtils.buildStepHeader(
          'Location Details',
          'Enter your taluka',
        ),
        Gap(24.h),
        CourtAllocationCaseUIUtils.buildTextFormField(
          controller: controller.talukaController,
          label: 'Taluka*',
          hint: 'Enter taluka name',
          icon: PhosphorIcons.mapPin(PhosphorIconsStyle.regular),
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter the taluka';
            }
            return null;
          },
        ),
        Gap(32.h),
        CourtAllocationCaseUIUtils.buildNavigationButtons(mainController),
      ],
    );
  }

  Widget _buildVillageInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CourtAllocationCaseUIUtils.buildStepHeader(
          'Location Details',
          'Enter your village',
        ),
        Gap(24.h),
        CourtAllocationCaseUIUtils.buildTextFormField(
          controller: controller.villageController,
          label: 'Village*',
          hint: 'Enter village name',
          icon: PhosphorIcons.house(PhosphorIconsStyle.regular),
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter the village';
            }
            return null;
          },
        ),
        Gap(32.h),
        CourtAllocationCaseUIUtils.buildNavigationButtons(mainController),
      ],
    );
  }

}