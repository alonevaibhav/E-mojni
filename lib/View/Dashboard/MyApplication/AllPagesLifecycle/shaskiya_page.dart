import 'package:emojni/View/Dashboard/MyApplication/AllPagesLifecycle/preview_component/preview_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../Constants/color_constant.dart';
import '../../../../Controller/Dashboard/MyApplication/shaskiya_controller.dart';
import '../../../../Controller/get_translation_controller/get_text_form.dart';
import '../../../../Models/shaskiya_model.dart';
import '../../../../State/ui_state_manegment.dart';
import '../../../../Utils/file_full_screen_view.dart';

class ShaskiyaPage extends StatelessWidget {
  const ShaskiyaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =  Get.put(ShaskiyaMojniController());
    final sizeFactor = 0.85;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: GetTranslatableText(controller.formName),
        backgroundColor: SetuColors.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: controller.obx(
            (formsList) =>
            _buildFormsListContent(formsList!, sizeFactor, controller),
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

  Widget _buildFormsListContent(List<ShaskiyaMojniForm> forms, double sizeFactor,
      ShaskiyaMojniController controller) {
    return RefreshIndicator(
      onRefresh: () => controller.refreshForms(),
      color: SetuColors.primaryGreen,
      child: Column(
        children: [
          _buildSummaryHeader(forms, sizeFactor),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.w * sizeFactor),
              itemCount: forms.length,
              itemBuilder: (context, index) {
                final form = forms[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h * sizeFactor),
                  child: _buildFormItem(form, sizeFactor, index),
                ).animate().fadeIn(
                  delay: (50 * index).ms,
                  duration: 400.ms,
                ).slideX(begin: -0.1, end: 0);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryHeader(List<ShaskiyaMojniForm> forms, double sizeFactor) {
    final verifiedCount = forms.where((f) => f.isVerifiedBool).length;
    final pendingCount = forms.where((f) => f.isPending).length;
    final coOwnersCount = forms.where((f) => f.hasCoOwners).length;
    final totalCount = forms.length;

    return Container(
      width: double.infinity,
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
      child: Padding(
        padding: EdgeInsets.all(20.w * sizeFactor),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: buildHeaderStatCard(
                    icon: PhosphorIcons.files(PhosphorIconsStyle.fill),
                    label: 'Total',
                    value: '$totalCount',
                    color: Colors.blue,
                    sizeFactor: sizeFactor,
                  ),
                ),
                Gap(12.w * sizeFactor),
                Expanded(
                  child: buildHeaderStatCard(
                    icon: PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                    label: 'Verified',
                    value: '$verifiedCount',
                    color: Colors.green,
                    sizeFactor: sizeFactor,
                  ),
                ),
                Gap(12.w * sizeFactor),
                Expanded(
                  child: buildHeaderStatCard(
                    icon: PhosphorIcons.clock(PhosphorIconsStyle.fill),
                    label: 'Pending',
                    value: '$pendingCount',
                    color: Colors.orange,
                    sizeFactor: sizeFactor,
                  ),
                ),
                Gap(12.w * sizeFactor),
                // Expanded(
                //   child: buildHeaderStatCard(
                //     icon: PhosphorIcons.users(PhosphorIconsStyle.fill),
                //     label: 'Co-Owners',
                //     value: '$coOwnersCount',
                //     color: Colors.purple,
                //     sizeFactor: sizeFactor,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildFormItem(ShaskiyaMojniForm form, double sizeFactor, int index) {
    return InkWell(
      onTap: () => _showFormDetails(form),
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
                      PhosphorIcons.mapTrifold(PhosphorIconsStyle.fill),
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
                            Expanded(
                              child: GetTranslatableText(
                                form.formId.isNotEmpty ? form.formId : 'Form #${form.id}',
                                style: TextStyle(
                                  fontSize: 15.sp * sizeFactor,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900],
                                ),
                              ),
                            ),
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
                value: form.applicantFullname ?? form.applicantName ?? 'N/A',
                sizeFactor: sizeFactor,
              ),
              Gap(8.h * sizeFactor),
              buildInfoRow(
                icon: PhosphorIcons.userCheck(PhosphorIconsStyle.regular),
                label: 'Officer',
                value: form.officerName ?? 'N/A',
                sizeFactor: sizeFactor,
              ),
              Gap(8.h * sizeFactor),
              buildInfoRow(
                icon: PhosphorIcons.tag(PhosphorIconsStyle.regular),
                label: 'Survey Number',
                value: form.surveyNumber ?? 'N/A',
                sizeFactor: sizeFactor,
              ),
              if (form.surveyOrderNumber != null) ...[
                Gap(8.h * sizeFactor),
                buildInfoRow(
                  icon: PhosphorIcons.fileText(PhosphorIconsStyle.regular),
                  label: 'Order Number',
                  value: form.surveyOrderNumber!,
                  sizeFactor: sizeFactor,
                ),
              ],
              Gap(16.h * sizeFactor),
              Row(
                children: [
                  if (form.hasSurveyDetails)
                    buildFeatureChip(
                      icon: PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                      label: 'Details Available',
                      color: Colors.green,
                      sizeFactor: sizeFactor,
                    ),
                  if (!form.hasSurveyDetails)
                    buildFeatureChip(
                      icon: PhosphorIcons.warning(PhosphorIconsStyle.fill),
                      label: 'Details Pending',
                      color: Colors.orange,
                      sizeFactor: sizeFactor,
                    ),
                  const Spacer(),
                  // if (form.hasCoOwners)
                  //   buildFeatureChip(
                  //     icon: PhosphorIcons.users(PhosphorIconsStyle.fill),
                  //     label: 'Co-Owners',
                  //     color: Colors.purple,
                  //     sizeFactor: sizeFactor,
                  //   ),
                  Gap(8.w * sizeFactor),
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

  Widget buildStatusBadge(ShaskiyaMojniForm form, double sizeFactor) {
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

  void _showFormDetails(ShaskiyaMojniForm form) {
    Get.bottomSheet(
      _buildFormDetailsBottomSheet(form),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildFormDetailsBottomSheet(ShaskiyaMojniForm form) {
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
                buildStatusBadge(form, sizeFactor),
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
