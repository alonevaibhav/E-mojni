import 'package:emojni/View/Dashboard/MyApplication/AllPagesLifecycle/preview_component/preview_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../Constants/color_constant.dart';
import '../../../../../Controller/Dashboard/MyApplication/LifecycleController/life_counting_controller.dart';
import '../../../../../Controller/Dashboard/MyApplication/shaskiya_controller.dart';
import '../../../../../Controller/get_translation_controller/get_text_form.dart';
import '../../../../../Models/shaskiya_model.dart';
import '../../../../../Utils/file_full_screen_view.dart';
import 'components/payment_widget.dart';

class ShaskiyaDetailPage extends StatelessWidget {
  const ShaskiyaDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeFactor = 0.85;
    final arguments = Get.arguments as Map<String, dynamic>;

    final form = arguments['form'] ;
    final formType = arguments['formType'] as String;

    // Pass formType to controller
    final controller = Get.put(LifeCountingController(formId: form.id, formType: formType,), tag: 'payment_${form.id}');

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: GetTranslatableText(form.formId.isNotEmpty ? form.formId : 'Form #${form.id}'),
        backgroundColor: SetuColors.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            _buildHeader(sizeFactor, form),

            // PREVIEW BANNER (Clickable to open bottom sheet)
            _buildPreviewBanner(sizeFactor, form),

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
    );
  }

  Widget _buildHeader(double sizeFactor, ShaskiyaMojniForm form) {
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
              PhosphorIcons.mapTrifold(PhosphorIconsStyle.fill),
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
                  form.applicantFullname ?? form.applicantName ?? 'N/A',
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

  Widget _buildStatusBadgeWhite(double sizeFactor, ShaskiyaMojniForm form) {
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
            form.isVerifiedBool
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

  Widget _buildPreviewBanner(double sizeFactor, ShaskiyaMojniForm form) {
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
                    'Tap to review your shaskiya survey application details',
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

  void _showFormPreviewBottomSheet(ShaskiyaMojniForm form) {
    Get.bottomSheet(
      _buildFormPreviewBottomSheet(form),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildFormPreviewBottomSheet(ShaskiyaMojniForm form) {
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
                          buildDetailItem('Form ID', form.formId.isNotEmpty ? form.formId : 'N/A', sizeFactor),
                          buildDetailItem('Status', form.statusDisplayText, sizeFactor),
                          buildDetailItem('Created Date', form.formattedCreatedDate, sizeFactor),
                          buildDetailItem('User ID', form.userId.toString(), sizeFactor),
                          buildDetailItem('Duration', form.duration ?? 'N/A', sizeFactor),
                          buildDetailItem('Landholder Type', form.landholderType ?? 'N/A', sizeFactor),
                        ],
                        sizeFactor: sizeFactor,
                      ),
                      Gap(20.h * sizeFactor),
                      buildDetailsSection(
                        title: 'Applicant Information',
                        icon: PhosphorIcons.user(PhosphorIconsStyle.fill),
                        children: [
                          buildDetailItem('Full Name', form.applicantFullname ?? 'N/A', sizeFactor),
                          buildDetailItem('Full Address', form.applicantFulladdress ?? 'N/A', sizeFactor),
                          buildDetailItem('Applicant Name', form.applicantName ?? 'N/A', sizeFactor),
                          buildDetailItem('Applicant Address', form.applicantAddress ?? 'N/A', sizeFactor),
                        ],
                        sizeFactor: sizeFactor,
                      ),
                      Gap(20.h * sizeFactor),
                      buildDetailsSection(
                        title: 'Officer Information',
                        icon: PhosphorIcons.userCheck(PhosphorIconsStyle.fill),
                        children: [
                          buildDetailItem('Officer Name', form.officerName ?? 'N/A', sizeFactor),
                          buildDetailItem('Officer Address', form.officerAddress ?? 'N/A', sizeFactor),
                        ],
                        sizeFactor: sizeFactor,
                      ),
                      Gap(20.h * sizeFactor),
                      buildDetailsSection(
                        title: 'Survey Information',
                        icon: PhosphorIcons.mapTrifold(PhosphorIconsStyle.fill),
                        children: [
                          buildDetailItem('Survey Order Number', form.surveyOrderNumber ?? 'N/A', sizeFactor),
                          buildDetailItem('Survey Order Date', form.formattedSurveyOrderDate, sizeFactor),
                          buildDetailItem('Survey Number', form.surveyNumber ?? 'N/A', sizeFactor),
                          buildDetailItem('Survey Details', form.surveyDetails ?? 'N/A', sizeFactor),
                        ],
                        sizeFactor: sizeFactor,
                      ),
                      Gap(20.h * sizeFactor),
                      buildDetailsSection(
                        title: 'Location Details',
                        icon: PhosphorIcons.mapPin(PhosphorIconsStyle.fill),
                        children: [
                          buildDetailItem('Division', form.division?.toString() ?? 'N/A', sizeFactor),
                          buildDetailItem('District', form.district?.toString() ?? 'N/A', sizeFactor),
                          buildDetailItem('Taluka', form.taluka?.toString() ?? 'N/A', sizeFactor),
                          buildDetailItem('Village', form.village?.toString() ?? 'N/A', sizeFactor),
                        ],
                        sizeFactor: sizeFactor,
                      ),
                      Gap(20.h * sizeFactor),
                      buildDetailsSection(
                        title: 'Additional Information',
                        icon: PhosphorIcons.notepad(PhosphorIconsStyle.fill),
                        children: [
                          buildDetailItem('Next of Kin', form.nextOfKin ?? 'N/A', sizeFactor),
                          buildDetailItem('Co-Owners', form.coOwners ?? 'N/A', sizeFactor),
                          buildDetailItem('Applicant Entries', form.applicantEntries ?? 'N/A', sizeFactor),
                          buildDetailItem('Survey Entries', form.surveyEntries ?? 'N/A', sizeFactor),
                          buildDetailItem('Updated At', form.updatedAt, sizeFactor),
                        ],
                        sizeFactor: sizeFactor,
                      ),
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

  Widget _buildBottomSheetHeader(ShaskiyaMojniForm form, double sizeFactor) {
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
              PhosphorIcons.mapTrifold(PhosphorIconsStyle.fill),
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
                  form.formId.isNotEmpty ? form.formId : 'Form #${form.id}',
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

  Widget _buildStatusBadge(ShaskiyaMojniForm form, double sizeFactor) {
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
            form.isVerifiedBool
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

  Widget _buildDocumentsSection(ShaskiyaMojniForm form, double sizeFactor) {
    final controller = Get.find<ShaskiyaMojniController>();
    final documents = <Map<String, dynamic>>[];

    // Add all document paths
    final documentPaths = [
      {'name': 'Survey Order File', 'path': form.surveyOrderFilePath},
      {'name': '7/12 Extract', 'path': form.sevenTwelveExtractPath},
      {'name': 'Identity Proof', 'path': form.identityProofPath},
      {'name': 'Old Measurement', 'path': form.oldMeasurementPath},
      {'name': 'Yojana Patrak', 'path': form.yojanaPatrakPath},
      {'name': 'Tipan', 'path': form.tipanPath},
      {'name': 'Fadani', 'path': form.fadaniPath},
      {'name': 'Demarcation Certificate', 'path': form.demarcationCertificatePath},
      {'name': 'Adhikar Patra', 'path': form.adhikarPatraPath},
      {'name': 'Utara Akharband', 'path': form.utaraAkharbandPath},
      {'name': 'Other Document', 'path': form.otherDocumentPath},
    ];

    // Filter out null paths
    for (var doc in documentPaths) {
      if (doc['path'] != null) {
        documents.add({
          'name': doc['name'],
          'path': doc['path']!,
        });
      }
    }

    if (documents.isEmpty) {
      return buildDetailsSection(
        title: 'Documents',
        icon: PhosphorIcons.files(PhosphorIconsStyle.fill),
        children: [
          Text(
            'No documents available',
            style: TextStyle(
              fontSize: 14.sp * sizeFactor,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
        sizeFactor: sizeFactor,
      );
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
