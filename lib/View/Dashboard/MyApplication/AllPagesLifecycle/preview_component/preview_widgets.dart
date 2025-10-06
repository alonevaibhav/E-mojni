import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../Constants/color_constant.dart';
import '../../../../../Controller/get_translation_controller/get_text_form.dart';


Widget buildFilterOption(
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


Widget buildDetailItem(String label, String value, double sizeFactor) {
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

Widget buildDetailsSection({
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

Widget buildFeatureChip({
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

Widget buildInfoRow({
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


Widget buildHeaderStatCard({
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