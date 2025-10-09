import 'package:emojni/View/Dashboard/MyApplication/AllPagesLifecycle/preview_component/preview_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../Constants/color_constant.dart';
import '../../../../../Controller/Dashboard/MyApplication/LifecycleController/life_counting_controller.dart';
import '../../../../../Controller/Dashboard/MyApplication/counting_land_controller.dart';
import '../../../../../Controller/get_translation_controller/get_text_form.dart';
import '../../../../../Models/counting_land_model.dart';
import '../../../../../Utils/file_full_screen_view.dart';
import 'components/payment_widget.dart';

class CountingLandDetailPage extends StatelessWidget {
  const CountingLandDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sizeFactor = 0.85;

// Get arguments as Map
    final arguments = Get.arguments as Map<String, dynamic>;
    final form = arguments['form'] ;
    final formType = arguments['formType'] as String;

    // Pass formType to controller
    final controller = Get.put(LifeCountingController(formId: form.id, formType: formType,), tag: 'payment_${form.id}');

    return RefreshIndicator(
      onRefresh: controller.refreshPaymentStatus,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: GetTranslatableText('Application #${form.id}'),
          backgroundColor: SetuColors.primaryGreen,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // ✅ Add this

          child: Column(
            children: [
              // Header Section
              _buildHeader(sizeFactor, form),

              // PREVIEW BANNER (Clickable to open bottom sheet)
              _buildPreviewBanner(sizeFactor, form),

              // PaymentWidget(
              //   sizeFactor: sizeFactor,
              //   controller: controller,
              //     form:form
              // ),

              PaymentWidget(
                sizeFactor: sizeFactor,
                controller: controller,
                onRefresh: () => controller.refreshPaymentStatus(),
                formStatus: form.status,
              ),

              Gap(20.h * sizeFactor),
            ],
          ),
        ),
      ),
    );
  }
































  // PREVIEW BANNER-----------------------------------
  Widget _buildPreviewBanner(double sizeFactor, CountingLandForm form) {
    return GestureDetector(
      onTap: () => _showFormPreviewBottomSheet(form),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16.w * sizeFactor,
          vertical: 12.h * sizeFactor,
        ),
        padding: EdgeInsets.all(16.w * sizeFactor),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade50,
              Colors.blue.shade100,
            ],
          ),
          borderRadius: BorderRadius.circular(12.r * sizeFactor),
          border: Border.all(
            color: Colors.blue.shade200,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w * sizeFactor),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.r * sizeFactor),
              ),
              child: Icon(
                PhosphorIcons.eye(PhosphorIconsStyle.fill),
                color: Colors.white,
                size: 24.sp * sizeFactor,
              ),
            ),
            Gap(12.w * sizeFactor),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetTranslatableText(
                    'Preview Your Form',
                    style: TextStyle(
                      fontSize: 16.sp * sizeFactor,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  Gap(4.h * sizeFactor),
                  GetTranslatableText(
                    'Tap to review your application details',
                    style: TextStyle(
                      fontSize: 12.sp * sizeFactor,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
              color: Colors.blue.shade700,
              size: 20.sp * sizeFactor,
            ),
          ],
        ),
      ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2, end: 0),
    );
  }

  void _showFormPreviewBottomSheet(CountingLandForm form) {
    Get.bottomSheet(
      _buildFormPreviewBottomSheet(form),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildFormPreviewBottomSheet(CountingLandForm form) {
    final sizeFactor = 0.85;

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24.r * sizeFactor),
            ),
          ),
          child: Column(
            children: [
              _buildBottomSheetHandle(sizeFactor),
              _buildBottomSheetHeader(form, sizeFactor),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.all(20.w * sizeFactor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildDetailsSection(
                        title: 'Basic Information',
                        icon: PhosphorIcons.info(PhosphorIconsStyle.fill),
                        children: [
                          buildDetailItem(
                              'Application ID', '#${form.id}', sizeFactor),
                          buildDetailItem(
                              'Status', form.statusDisplayText, sizeFactor),
                          buildDetailItem('Created Date',
                              form.formattedCreatedDate, sizeFactor),
                          buildDetailItem(
                              'Department', form.department, sizeFactor),
                          buildDetailItem(
                              'Payment Status',
                              form.isPaymentDone ? 'Completed' : 'Pending',
                              sizeFactor),
                        ],
                        sizeFactor: sizeFactor,
                      ),
                      Gap(20.h * sizeFactor),
                      buildDetailsSection(
                        title: 'Applicant Details',
                        icon: PhosphorIcons.user(PhosphorIconsStyle.fill),
                        children: [
                          buildDetailItem(
                              'Name', form.applicantName, sizeFactor),
                          buildDetailItem(
                              'Address', form.applicantAddress, sizeFactor),
                          buildDetailItem(
                              'Sub Part Area',
                              '${form.applicantSubPartArea} hectares',
                              sizeFactor),
                        ],
                        sizeFactor: sizeFactor,
                      ),
                      if (form.operationType != null) ...[
                        Gap(20.h * sizeFactor),
                        buildDetailsSection(
                          title: 'Operation Details',
                          icon: PhosphorIcons.gear(PhosphorIconsStyle.fill),
                          children: [
                            buildDetailItem('Operation Type',
                                form.operationType!, sizeFactor),
                            if (form.surveyDetailType != null)
                              buildDetailItem('Survey Detail Type',
                                  form.surveyDetailType!, sizeFactor),
                            if (form.consolidationOrderNumber != null)
                              buildDetailItem('Consolidation Order',
                                  form.consolidationOrderNumber!, sizeFactor),
                          ],
                          sizeFactor: sizeFactor,
                        ),
                      ],
                      if (form.coOwnerName != null) ...[
                        Gap(20.h * sizeFactor),
                        buildDetailsSection(
                          title: 'Co-Owner Information',
                          icon: PhosphorIcons.users(PhosphorIconsStyle.fill),
                          children: [
                            buildDetailItem(
                                'Name', form.coOwnerName!, sizeFactor),
                            if (form.coOwnerAddress != null)
                              buildDetailItem(
                                  'Address', form.coOwnerAddress!, sizeFactor),
                            if (form.coOwnerMobileNumber != null)
                              buildDetailItem('Mobile',
                                  form.coOwnerMobileNumber!, sizeFactor),
                          ],
                          sizeFactor: sizeFactor,
                        ),
                      ],
                      if (form.adjacentOwnerName != null) ...[
                        Gap(20.h * sizeFactor),
                        buildDetailsSection(
                          title: 'Adjacent Owner Information',
                          icon:
                              PhosphorIcons.houseLine(PhosphorIconsStyle.fill),
                          children: [
                            buildDetailItem(
                                'Name', form.adjacentOwnerName!, sizeFactor),
                            if (form.adjacentOwnerAddress != null)
                              buildDetailItem('Address',
                                  form.adjacentOwnerAddress!, sizeFactor),
                            buildDetailItem(
                                'Total Area',
                                '${form.adjacentOwnerTotalArea} hectares',
                                sizeFactor),
                            if (form.adjacentOwnerMobileNumber != null)
                              buildDetailItem('Mobile',
                                  form.adjacentOwnerMobileNumber!, sizeFactor),
                          ],
                          sizeFactor: sizeFactor,
                        ),
                      ],
                      Gap(20.h * sizeFactor),
                      _buildDocumentsSection(form, sizeFactor),
                      Gap(20.h * sizeFactor),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetHandle(double sizeFactor) {
    return Container(
      margin: EdgeInsets.only(top: 12.h * sizeFactor),
      width: 40.w * sizeFactor,
      height: 4.h * sizeFactor,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(2.r * sizeFactor),
      ),
    );
  }

  Widget _buildBottomSheetHeader(CountingLandForm form, double sizeFactor) {
    return Container(
      padding: EdgeInsets.all(20.w * sizeFactor),
      decoration: BoxDecoration(
        color: SetuColors.primaryGreen.withOpacity(0.1),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.r * sizeFactor),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w * sizeFactor),
            decoration: BoxDecoration(
              color: form.statusColor,
              borderRadius: BorderRadius.circular(12.r * sizeFactor),
            ),
            child: Icon(
              PhosphorIcons.fileText(PhosphorIconsStyle.fill),
              color: Colors.white,
              size: 24.sp * sizeFactor,
            ),
          ),
          Gap(12.w * sizeFactor),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetTranslatableText(
                  'Application #${form.id}',
                  style: TextStyle(
                    fontSize: 18.sp * sizeFactor,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900],
                  ),
                ),
                Gap(4.h * sizeFactor),
                _buildStatusBadge(form, sizeFactor),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              PhosphorIcons.x(PhosphorIconsStyle.bold),
              size: 20.sp * sizeFactor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(CountingLandForm form, double sizeFactor) {
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

  Widget _buildHeader(double sizeFactor, form) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w * sizeFactor),
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
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w * sizeFactor),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r * sizeFactor),
            ),
            child: Icon(
              PhosphorIcons.fileText(PhosphorIconsStyle.fill),
              color: form.statusColor,
              size: 32.sp * sizeFactor,
            ),
          ),
          Gap(16.w * sizeFactor),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetTranslatableText(
                  form.applicantName,
                  style: TextStyle(
                    fontSize: 18.sp * sizeFactor,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Gap(4.h * sizeFactor),
                _buildStatusBadgeWhite(sizeFactor, form),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildStatusBadgeWhite(double sizeFactor, form) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w * sizeFactor,
        vertical: 4.h * sizeFactor,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r * sizeFactor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            form.isVerified
                ? PhosphorIcons.checkCircle(PhosphorIconsStyle.fill)
                : PhosphorIcons.clock(PhosphorIconsStyle.fill),
            color: form.statusColor,
            size: 12.sp * sizeFactor,
          ),
          Gap(4.w * sizeFactor),
          GetTranslatableText(
            form.statusDisplayText,
            style: TextStyle(
              fontSize: 11.sp * sizeFactor,
              color: form.statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsSection(CountingLandForm form, double sizeFactor) {
    final controller = Get.find<CountingLandController>();
    final documents = <Map<String, dynamic>>[];

    if (form.identityProofPath != null) {
      documents.add({
        'name': 'Identity Proof',
        'path': form.identityProofPath!,
      });
    }
    if (form.poaDocumentPath != null) {
      documents.add({
        'name': 'POA Document',
        'path': form.poaDocumentPath!,
      });
    }
    if (form.tipanPath != null) {
      documents.add({
        'name': 'Tipan',
        'path': form.tipanPath!,
      });
    }
    if (form.fadniPath != null) {
      documents.add({
        'name': 'Fadni',
        'path': form.fadniPath!,
      });
    }
    if (form.yojanPatrakPath != null) {
      documents.add({
        'name': 'Yojana Patrak',
        'path': form.yojanPatrakPath!,
      });
    }
    if (form.adhikarPatrasPath != null) {
      documents.add({
        'name': 'Adhikar Patras',
        'path': form.adhikarPatrasPath!,
      });
    }

    if (documents.isEmpty) {
      return const SizedBox.shrink();
    }

    return buildDetailsSection(
      title: 'Documents',
      icon: PhosphorIcons.files(PhosphorIconsStyle.fill),
      children: [
        Wrap(
          spacing: 8.w * sizeFactor,
          runSpacing: 8.h * sizeFactor,
          children: documents.asMap().entries.map((entry) {
            final index = entry.key;
            final doc = entry.value;
            final fileName = controller.getFileName(doc['path']);
            final isImage = controller.isImageFile(fileName);
            final isPdf = controller.isPdfFile(fileName);
            final isWord = controller.isWordFile(fileName);

            return GestureDetector(
              onTap: () {
                final allPaths =
                    documents.map((d) => d['path'] as String).toList();
                Get.to(() => FileFullScreenView(
                      filePath: doc['path'],
                      allFiles: allPaths,
                      initialIndex: index,
                    ));
              },
              child: Container(
                width: 80.w * sizeFactor,
                height: 80.h * sizeFactor,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.r * sizeFactor),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isImage
                          ? PhosphorIcons.image(PhosphorIconsStyle.regular)
                          : isPdf
                              ? PhosphorIcons.filePdf(
                                  PhosphorIconsStyle.regular)
                              : isWord
                                  ? PhosphorIcons.fileDoc(
                                      PhosphorIconsStyle.regular)
                                  : PhosphorIcons.file(
                                      PhosphorIconsStyle.regular),
                      size: 24.w * sizeFactor,
                      color: isImage
                          ? Colors.blue
                          : isPdf
                              ? Colors.red
                              : isWord
                                  ? Colors.blue.shade800
                                  : Colors.grey,
                    ),
                    Gap(4.h * sizeFactor),
                    Text(
                      doc['name'],
                      style: TextStyle(
                        fontSize: 8.sp * sizeFactor,
                        color: Colors.black54,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
      sizeFactor: sizeFactor,
    );
  }
}
