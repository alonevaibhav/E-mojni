
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:get/get.dart';
import 'package:emojni/Components/LandSurveyView/Steps/survey_ui_utils.dart';
import '../../../Constants/color_constant.dart';
import '../../../Utils/custimize_image_picker.dart';
import '../Controller/main_controller.dart';
import '../Controller/survey_eight_controller.dart';

class SurveyEightView extends StatelessWidget {
  final int currentSubStep;
  final MainSurveyController mainController;

  const SurveyEightView({
    super.key,
    required this.currentSubStep,
    required this.mainController,
  });

  @override
  Widget build(BuildContext context) {
    final docController = Get.put(SurveyEightController(), tag: 'survey_eight');

    final subSteps = mainController.stepConfigurations[7] ?? ['documents'];

    if (currentSubStep >= subSteps.length) {
      return _buildDocumentUpload(docController);
    }

    final currentField = subSteps[currentSubStep];

    switch (currentField) {
      case 'documents':
        return _buildDocumentUpload(docController);
      default:
        return _buildDocumentUpload(docController);
    }
  }

  Widget _buildDocumentUpload(SurveyEightController docController) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),

          Gap(24.h),

          _buildIdentityCardSection(docController),

          Gap(20.h),

          _buildRequiredDocuments(docController),

          // Additional documents conditionally displayed
          if (docController.isNonAgricultural) ...[
            Gap(20.h),
            _buildAdditionalDocuments(docController),
          ],

          // Stomach specific documents conditionally displayed
          if (docController.isStomach) ...[
            Gap(20.h),
            _buildStomachDocuments(docController),
          ],

          Gap(32.h),

          SurveyUIUtils.buildNavigationButtons(mainController),

          Gap(40.h),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: SetuColors.primaryGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Document Upload',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: SetuColors.primaryGreen,
            ),
          ),
          Gap(8.h),
          Text(
            'Please upload all required documents for your land survey application',
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildIdentityCardSection(SurveyEightController docController) {
    return _buildSection(
      title: 'Identity Card',
      child: Column(
        children: [
          SurveyUIUtils.buildDropdownField(
            label: 'Select Identity Card Type',
            value: docController.selectedIdentityType.value,
            items: docController.identityCardOptions,
            onChanged: docController.updateSelectedIdentityType,
            icon: PhosphorIcons.identificationBadge(PhosphorIconsStyle.regular),
          ),
          Gap(16.h),
          ImagePickerUtil.buildFileUploadField(
            label: 'Upload Identity Card *',
            hint: 'Upload identity card document',
            icon: PhosphorIcons.identificationCard(PhosphorIconsStyle.regular),
            uploadedFiles: docController.identityCardFiles,
            onFilesSelected: (files) => docController.identityCardFiles.assignAll(files),
          ),
        ],
      ),
    );
  }

  Widget _buildRequiredDocuments(SurveyEightController docController) {
    return _buildSection(
      title: 'Required Documents',
      child: Column(
        children: [
          ImagePickerUtil.buildFileUploadField(
            label: 'Latest 7/12 Of The 3 Month*',
            hint: 'Upload 7/12 document',
            icon: PhosphorIcons.fileText(PhosphorIconsStyle.regular),
            uploadedFiles: docController.sevenTwelveFiles,
            onFilesSelected: (files) => docController.sevenTwelveFiles.assignAll(files),
          ),
          Gap(16.h),
          ImagePickerUtil.buildFileUploadField(
            label: 'Note ',
            hint: 'Upload note document',
            icon: PhosphorIcons.note(PhosphorIconsStyle.regular),
            uploadedFiles: docController.noteFiles,
            onFilesSelected: (files) => docController.noteFiles.assignAll(files),
          ),
          Gap(16.h),
          ImagePickerUtil.buildFileUploadField(
            label: 'Partition ',
            hint: 'Upload partition document',
            icon: PhosphorIcons.fileText(PhosphorIconsStyle.regular),
            uploadedFiles: docController.partitionFiles,
            onFilesSelected: (files) => docController.partitionFiles.assignAll(files),
          ),
          Gap(16.h),
          ImagePickerUtil.buildFileUploadField(
            label: 'Scheme Sheet Utara/ Utara Akharband *',
            hint: 'Upload scheme sheet document',
            icon: PhosphorIcons.fileText(PhosphorIconsStyle.regular),
            uploadedFiles: docController.schemeSheetFiles,
            onFilesSelected: (files) => docController.schemeSheetFiles.assignAll(files),
          ),
          Gap(16.h),
          ImagePickerUtil.buildFileUploadField(
            label: 'Old census map *',
            hint: 'Upload census map',
            icon: PhosphorIcons.mapPin(PhosphorIconsStyle.regular),
            uploadedFiles: docController.oldCensusMapFiles,
            onFilesSelected: (files) => docController.oldCensusMapFiles.assignAll(files),
          ),
          Gap(16.h),
          ImagePickerUtil.buildFileUploadField(
            label: 'Demarcation certificate *',
            hint: 'Upload demarcation certificate',
            icon: PhosphorIcons.certificate(PhosphorIconsStyle.regular),
            uploadedFiles: docController.demarcationCertificateFiles,
            onFilesSelected: (files) => docController.demarcationCertificateFiles.assignAll(files),
          ),
          Gap(16.h),
          ImagePickerUtil.buildFileUploadField(
            label: 'Adhikar Patra *',
            hint: 'Upload demarcation certificate',
            icon: PhosphorIcons.certificate(PhosphorIconsStyle.regular),
            uploadedFiles: docController.adhikarPatra,
            onFilesSelected: (files) => docController.adhikarPatra.assignAll(files),
          ),
          Gap(16.h),
          ImagePickerUtil.buildFileUploadField(
            label: 'Other Document  *',
            hint: 'Upload Other document If You Have Any',
            icon: PhosphorIcons.certificate(PhosphorIconsStyle.regular),
            uploadedFiles: docController.otherDocument,
            onFilesSelected: (files) => docController.otherDocument.assignAll(files),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalDocuments(SurveyEightController docController) {
    return _buildSection(
      title: 'Additional Documents (Non-Agricultural)',
      child: Column(
        children: [
          ImagePickerUtil.buildFileUploadField(
            label: 'Saksham Pradikaran Adesh/ N/A Order*',
            hint: 'Upload Saksham Pradikaran Adesh document',
            icon: PhosphorIcons.stamp(PhosphorIconsStyle.regular),
            uploadedFiles: docController.sakshamPradikaranAdeshFiles,
            onFilesSelected: (files) => docController.sakshamPradikaranAdeshFiles.assignAll(files),
          ),
          Gap(16.h),
          ImagePickerUtil.buildFileUploadField(
            label: 'Nakasha/Layout Blueprint*',
            hint: 'Upload Nakasha document',
            icon: PhosphorIcons.mapPin(PhosphorIconsStyle.regular),
            uploadedFiles: docController.nakashaFiles,
            onFilesSelected: (files) => docController.nakashaFiles.assignAll(files),
          ),
          Gap(16.h),
          ImagePickerUtil.buildFileUploadField(
            label: 'Zone Certificate *',
            hint: 'Upload Zone Certificate',
            icon: PhosphorIcons.mapPin(PhosphorIconsStyle.regular),
            uploadedFiles: docController.nonAgriculturalZoneCertificateFiles,
            onFilesSelected: (files) => docController.nonAgriculturalZoneCertificateFiles.assignAll(files),
          ),
          Gap(16.h),
          ImagePickerUtil.buildFileUploadField(
            label: 'Bhandhakam Parvangi *',
            hint: 'Upload Bhandhakam Parvana document',
            icon: PhosphorIcons.scroll(PhosphorIconsStyle.regular),
            uploadedFiles: docController.bhandhakamParvanaFiles,
            onFilesSelected: (files) => docController.bhandhakamParvanaFiles.assignAll(files),
          ),
        ],
      ),
    );
  }

  Widget _buildStomachDocuments(SurveyEightController docController) {
    return _buildSection(
      title: 'Stomach Specific Documents',
      child: Column(
        children: [
          ImagePickerUtil.buildFileUploadField(
            label: 'Pratisa Karayayche Naksha *',
            hint: 'Upload Pratisa Karayayche Naksha document',
            icon: PhosphorIcons.mapTrifold(PhosphorIconsStyle.regular),
            uploadedFiles: docController.pratisaKarayaycheNakshaFiles,
            onFilesSelected: (files) => docController.pratisaKarayaycheNakshaFiles.assignAll(files),
          ),
          Gap(16.h),
          ImagePickerUtil.buildFileUploadField(
            label: 'Mojni karawayacha Jagecha Photo*',
            hint: 'Upload Band Photo',
            icon: PhosphorIcons.camera(PhosphorIconsStyle.regular),
            uploadedFiles: docController.bandPhotoFiles,
            onFilesSelected: (files) => docController.bandPhotoFiles.assignAll(files),
          ),
          Gap(16.h),
          ImagePickerUtil.buildFileUploadField(
            label: 'Zone Certificate  *',
            hint: 'Upload Zone Certificate ',
            icon: PhosphorIcons.camera(PhosphorIconsStyle.regular),
            uploadedFiles: docController.stomachZoneCertificateFiles,
            onFilesSelected: (files) => docController.stomachZoneCertificateFiles.assignAll(files),
          ),
          Gap(16.h),
          ImagePickerUtil.buildFileUploadField(
            label: 'Sammati Patra/ Pratidnya Patra *',
            hint: 'Upload Sammati Patra document',
            icon: PhosphorIcons.fileText(PhosphorIconsStyle.regular),
            uploadedFiles: docController.sammatiPatraFiles,
            onFilesSelected: (files) => docController.sammatiPatraFiles.assignAll(files),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: SetuColors.primaryGreen,
            ),
          ),
          Gap(16.h),
          child,
        ],
      ),
    );
  }

  double _getUploadProgress(SurveyEightController docController) {

    int uploadedCount = 0;
    int totalRequired = 7; // Basic documents

    if (docController.isNonAgricultural) {
      totalRequired += 3; // Add non-agricultural documents
    }

    if (docController.isStomach) {
      totalRequired += 3; // Add stomach documents
    }

    if (docController.selectedIdentityType.value.isNotEmpty && docController.identityCardFiles.isNotEmpty) uploadedCount++;
    if (docController.sevenTwelveFiles.isNotEmpty) uploadedCount++;
    if (docController.noteFiles.isNotEmpty) uploadedCount++;
    if (docController.partitionFiles.isNotEmpty) uploadedCount++;
    if (docController.schemeSheetFiles.isNotEmpty) uploadedCount++;
    if (docController.oldCensusMapFiles.isNotEmpty) uploadedCount++;
    if (docController.demarcationCertificateFiles.isNotEmpty) uploadedCount++;

    if (docController.isNonAgricultural) {
      if (docController.sakshamPradikaranAdeshFiles.isNotEmpty) uploadedCount++;
      if (docController.nakashaFiles.isNotEmpty) uploadedCount++;
      if (docController.bhandhakamParvanaFiles.isNotEmpty) uploadedCount++;
    }

    if (docController.isStomach) {
      if (docController.pratisaKarayaycheNakshaFiles.isNotEmpty) uploadedCount++;
      if (docController.bandPhotoFiles.isNotEmpty) uploadedCount++;
      if (docController.sammatiPatraFiles.isNotEmpty) uploadedCount++;
    }

    return uploadedCount / totalRequired;
  }
}