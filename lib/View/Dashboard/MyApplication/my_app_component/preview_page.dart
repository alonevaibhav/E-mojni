import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../Constants/color_constant.dart';
import '../../../../Controller/Dashboard/MyApplication/preview_controller.dart';
import '../../../../Controller/get_translation_controller/get_text_form.dart';
import '../../../../Models/preview_model.dart';
import '../../../../State/ui_state_manegment.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PreviewController());
    final sizeFactor = 0.85;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: GetTranslatableText(controller.formName),
        backgroundColor: SetuColors.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              PhosphorIcons.funnel(PhosphorIconsStyle.bold),
              size: 20.sp * sizeFactor,
            ),
            onPressed: () => _showFilterBottomSheet(context, controller, sizeFactor),
          ),
        ],
      ),
      body: controller.obx((formsList) => _buildFormsListContent(formsList!, sizeFactor, controller),
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

  Widget _buildFormsListContent(
      List<CountingLandForm> forms, double sizeFactor, PreviewController controller) {
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

  Widget _buildSummaryHeader(List<CountingLandForm> forms, double sizeFactor) {
    final verifiedCount = forms.where((f) => f.isVerified).length;
    final pendingCount = forms.where((f) => f.isPending).length;
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
                  child: _buildHeaderStatCard(
                    icon: PhosphorIcons.files(PhosphorIconsStyle.fill),
                    label: 'Total',
                    value: '$totalCount',
                    color: Colors.blue,
                    sizeFactor: sizeFactor,
                  ),
                ),
                Gap(12.w * sizeFactor),
                Expanded(
                  child: _buildHeaderStatCard(
                    icon: PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                    label: 'Verified',
                    value: '$verifiedCount',
                    color: Colors.green,
                    sizeFactor: sizeFactor,
                  ),
                ),
                Gap(12.w * sizeFactor),
                Expanded(
                  child: _buildHeaderStatCard(
                    icon: PhosphorIcons.clock(PhosphorIconsStyle.fill),
                    label: 'Pending',
                    value: '$pendingCount',
                    color: Colors.orange,
                    sizeFactor: sizeFactor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildHeaderStatCard({
    required PhosphorIconData icon,
    required String label,
    required String value,
    required Color color,
    required double sizeFactor,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w * sizeFactor),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r * sizeFactor),
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
          Icon(icon, color: color, size: 22.sp * sizeFactor),
          Gap(6.h * sizeFactor),
          GetTranslatableText(
            value,
            style: TextStyle(
              fontSize: 20.sp * sizeFactor,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Gap(2.h * sizeFactor),
          GetTranslatableText(
            label,
            style: TextStyle(
              fontSize: 10.sp * sizeFactor,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormItem(CountingLandForm form, double sizeFactor, int index) {
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
                      PhosphorIcons.fileText(PhosphorIconsStyle.fill),
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
                            GetTranslatableText(
                              'Application #${form.id}',
                              style: TextStyle(
                                fontSize: 15.sp * sizeFactor,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900],
                              ),
                            ),
                            const Spacer(),
                            _buildStatusBadge(form, sizeFactor),
                          ],
                        ),
                        Gap(4.h * sizeFactor),
                        Row(
                          children: [
                            Icon(
                              PhosphorIcons.calendar(PhosphorIconsStyle.regular),
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
              _buildInfoRow(
                icon: PhosphorIcons.user(PhosphorIconsStyle.regular),
                label: 'Applicant',
                value: form.applicantName,
                sizeFactor: sizeFactor,
              ),
              Gap(8.h * sizeFactor),
              _buildInfoRow(
                icon: PhosphorIcons.mapPin(PhosphorIconsStyle.regular),
                label: 'Address',
                value: form.applicantAddress,
                sizeFactor: sizeFactor,
              ),
              Gap(8.h * sizeFactor),
              _buildInfoRow(
                icon: PhosphorIcons.tag(PhosphorIconsStyle.regular),
                label: 'Operation',
                value: form.operationType ?? 'N/A',
                sizeFactor: sizeFactor,
              ),
              if (form.department.isNotEmpty) ...[
                Gap(8.h * sizeFactor),
                _buildInfoRow(
                  icon: PhosphorIcons.buildings(PhosphorIconsStyle.regular),
                  label: 'Department',
                  value: form.department,
                  sizeFactor: sizeFactor,
                ),
              ],
              Gap(16.h * sizeFactor),
              Row(
                children: [
                  if (form.isPaymentDone)
                    _buildFeatureChip(
                      icon: PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                      label: 'Payment Done',
                      color: Colors.green,
                      sizeFactor: sizeFactor,
                    ),
                  if (!form.isPaymentDone)
                    _buildFeatureChip(
                      icon: PhosphorIcons.warning(PhosphorIconsStyle.fill),
                      label: 'Payment Pending',
                      color: Colors.orange,
                      sizeFactor: sizeFactor,
                    ),
                  const Spacer(),
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

  Widget _buildInfoRow({
    required PhosphorIconData icon,
    required String label,
    required String value,
    required double sizeFactor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 14.sp * sizeFactor,
          color: SetuColors.primaryGreen,
        ),
        Gap(8.w * sizeFactor),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetTranslatableText(
                label,
                style: TextStyle(
                  fontSize: 10.sp * sizeFactor,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(2.h * sizeFactor),
              GetTranslatableText(
                value,
                style: TextStyle(
                  fontSize: 12.sp * sizeFactor,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureChip({
    required PhosphorIconData icon,
    required String label,
    required Color color,
    required double sizeFactor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w * sizeFactor,
        vertical: 6.h * sizeFactor,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r * sizeFactor),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.sp * sizeFactor, color: color),
          Gap(4.w * sizeFactor),
          GetTranslatableText(
            label,
            style: TextStyle(
              fontSize: 10.sp * sizeFactor,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showFormDetails(CountingLandForm form) {
    Get.bottomSheet(
      _buildFormDetailsBottomSheet(form),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildFormDetailsBottomSheet(CountingLandForm form) {
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
                      _buildDetailsSection(
                        title: 'Basic Information',
                        icon: PhosphorIcons.info(PhosphorIconsStyle.fill),
                        children: [
                          _buildDetailItem('Application ID', '#${form.id}', sizeFactor),
                          _buildDetailItem('Status', form.statusDisplayText, sizeFactor),
                          _buildDetailItem('Created Date', form.formattedCreatedDate, sizeFactor),
                          _buildDetailItem('Department', form.department, sizeFactor),
                          _buildDetailItem('Payment Status', form.isPaymentDone ? 'Completed' : 'Pending', sizeFactor),
                        ],
                        sizeFactor: sizeFactor,
                      ),
                      Gap(20.h * sizeFactor),
                      _buildDetailsSection(
                        title: 'Applicant Details',
                        icon: PhosphorIcons.user(PhosphorIconsStyle.fill),
                        children: [
                          _buildDetailItem('Name', form.applicantName, sizeFactor),
                          _buildDetailItem('Address', form.applicantAddress, sizeFactor),
                          _buildDetailItem('Sub Part Area', '${form.applicantSubPartArea} hectares', sizeFactor),
                        ],
                        sizeFactor: sizeFactor,
                      ),
                      if (form.operationType != null) ...[
                        Gap(20.h * sizeFactor),
                        _buildDetailsSection(
                          title: 'Operation Details',
                          icon: PhosphorIcons.gear(PhosphorIconsStyle.fill),
                          children: [
                            _buildDetailItem('Operation Type', form.operationType!, sizeFactor),
                            if (form.surveyDetailType != null)
                              _buildDetailItem('Survey Detail Type', form.surveyDetailType!, sizeFactor),
                            if (form.consolidationOrderNumber != null)
                              _buildDetailItem('Consolidation Order', form.consolidationOrderNumber!, sizeFactor),
                          ],
                          sizeFactor: sizeFactor,
                        ),
                      ],
                      if (form.coOwnerName != null) ...[
                        Gap(20.h * sizeFactor),
                        _buildDetailsSection(
                          title: 'Co-Owner Information',
                          icon: PhosphorIcons.users(PhosphorIconsStyle.fill),
                          children: [
                            _buildDetailItem('Name', form.coOwnerName!, sizeFactor),
                            if (form.coOwnerAddress != null)
                              _buildDetailItem('Address', form.coOwnerAddress!, sizeFactor),
                            if (form.coOwnerMobileNumber != null)
                              _buildDetailItem('Mobile', form.coOwnerMobileNumber!, sizeFactor),
                          ],
                          sizeFactor: sizeFactor,
                        ),
                      ],
                      if (form.adjacentOwnerName != null) ...[
                        Gap(20.h * sizeFactor),
                        _buildDetailsSection(
                          title: 'Adjacent Owner Information',
                          icon: PhosphorIcons.houseLine(PhosphorIconsStyle.fill),
                          children: [
                            _buildDetailItem('Name', form.adjacentOwnerName!, sizeFactor),
                            if (form.adjacentOwnerAddress != null)
                              _buildDetailItem('Address', form.adjacentOwnerAddress!, sizeFactor),
                            _buildDetailItem('Total Area', '${form.adjacentOwnerTotalArea} hectares', sizeFactor),
                            if (form.adjacentOwnerMobileNumber != null)
                              _buildDetailItem('Mobile', form.adjacentOwnerMobileNumber!, sizeFactor),
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

  Widget _buildDetailsSection({
    required String title,
    required PhosphorIconData icon,
    required List<Widget> children,
    required double sizeFactor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r * sizeFactor),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.w * sizeFactor),
            decoration: BoxDecoration(
              color: SetuColors.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12.r * sizeFactor),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 18.sp * sizeFactor,
                  color: SetuColors.primaryGreen,
                ),
                Gap(8.w * sizeFactor),
                GetTranslatableText(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp * sizeFactor,
                    fontWeight: FontWeight.bold,
                    color: SetuColors.primaryGreen,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.w * sizeFactor),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, double sizeFactor) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h * sizeFactor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: GetTranslatableText(
              label,
              style: TextStyle(
                fontSize: 12.sp * sizeFactor,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Gap(8.w * sizeFactor),
          Expanded(
            flex: 3,
            child: GetTranslatableText(
              value,
              style: TextStyle(
                fontSize: 12.sp * sizeFactor,
                color: Colors.grey[900],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsSection(CountingLandForm form, double sizeFactor) {
    final documents = <Map<String, String>>[];

    if (form.identityProofPath != null) {
      documents.add({'name': 'Identity Proof', 'path': form.identityProofPath!});
    }
    if (form.poaDocumentPath != null) {
      documents.add({'name': 'POA Document', 'path': form.poaDocumentPath!});
    }
    if (form.tipanPath != null) {
      documents.add({'name': 'Tipan', 'path': form.tipanPath!});
    }
    if (form.fadniPath != null) {
      documents.add({'name': 'Fadni', 'path': form.fadniPath!});
    }
    if (form.yojanPatrakPath != null) {
      documents.add({'name': 'Yojana Patrak', 'path': form.yojanPatrakPath!});
    }
    if (form.adhikarPatrasPath != null) {
      documents.add({'name': 'Adhikar Patras', 'path': form.adhikarPatrasPath!});
    }

    if (documents.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildDetailsSection(
      title: 'Documents',
      icon: PhosphorIcons.files(PhosphorIconsStyle.fill),
      children: documents.map((doc) {
        return _buildDocumentItem(doc['name']!, doc['path']!, sizeFactor);
      }).toList(),
      sizeFactor: sizeFactor,
    );
  }

  Widget _buildDocumentItem(String name, String path, double sizeFactor) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h * sizeFactor),
      child: InkWell(
        onTap: () => _viewDocument(path),
        borderRadius: BorderRadius.circular(8.r * sizeFactor),
        child: Container(
          padding: EdgeInsets.all(10.w * sizeFactor),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r * sizeFactor),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            children: [
              Icon(
                PhosphorIcons.filePdf(PhosphorIconsStyle.fill),
                size: 16.sp * sizeFactor,
                color: Colors.red,
              ),
              Gap(10.w * sizeFactor),
              Expanded(
                child: GetTranslatableText(
                  name,
                  style: TextStyle(
                    fontSize: 12.sp * sizeFactor,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                PhosphorIcons.eye(PhosphorIconsStyle.regular),
                size: 16.sp * sizeFactor,
                color: SetuColors.primaryGreen,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _viewDocument(String path) {
    // Implement document viewing logic
    Get.snackbar(
      'Document',
      'Opening document...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: SetuColors.primaryGreen,
      colorText: Colors.white,
    );
  }

  void _showFilterBottomSheet(BuildContext context, PreviewController controller, double sizeFactor) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24.r * sizeFactor),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w * sizeFactor),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBottomSheetHandle(sizeFactor),
              Gap(16.h * sizeFactor),
              GetTranslatableText(
                'Filter Applications',
                style: TextStyle(
                  fontSize: 18.sp * sizeFactor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(20.h * sizeFactor),
              _buildFilterOption(
                'All Applications',
                PhosphorIcons.files(PhosphorIconsStyle.fill),
                    () {
                  Get.back();
                  controller.refreshForms();
                },
                sizeFactor,
              ),
              Gap(12.h * sizeFactor),
              _buildFilterOption(
                'Verified Only',
                PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                    () {
                  Get.back();
                  // Implement filter logic
                },
                sizeFactor,
              ),
              Gap(12.h * sizeFactor),
              _buildFilterOption(
                'Pending Only',
                PhosphorIcons.clock(PhosphorIconsStyle.fill),
                    () {
                  Get.back();
                  // Implement filter logic
                },
                sizeFactor,
              ),
              Gap(20.h * sizeFactor),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildFilterOption(
      String label,
      PhosphorIconData icon,
      VoidCallback onTap,
      double sizeFactor,
      ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r * sizeFactor),
      child: Container(
        padding: EdgeInsets.all(16.w * sizeFactor),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12.r * sizeFactor),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20.sp * sizeFactor,
              color: SetuColors.primaryGreen,
            ),
            Gap(12.w * sizeFactor),
            GetTranslatableText(
              label,
              style: TextStyle(
                fontSize: 14.sp * sizeFactor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Icon(
              PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
              size: 16.sp * sizeFactor,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}