import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:gap/gap.dart';
import '../Constants/color_constant.dart';
import '../Controller/get_translation_controller/get_text_form.dart';

/// Common state widgets that can be reused across the application
class CommonStateWidgets {
  /// Loading state widget
  static Widget loading({
    String? message,
    double sizeFactor = 0.85,
    Color? loadingColor,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              loadingColor ?? SetuColors.primaryGreen,
            ),
          ),
          Gap(16.h * sizeFactor),
          GetTranslatableText(
            message ?? 'Loading...',
            style: TextStyle(
              fontSize: 14.sp * sizeFactor,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  /// Error state widget
  static Widget error({
    required String error,
    String? title,
    VoidCallback? onRetry,
    double sizeFactor = 0.85,
    IconData? icon,
    Color? iconColor,
    String? retryButtonText,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w * sizeFactor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? PhosphorIcons.warningCircle(PhosphorIconsStyle.regular),
              size: 64.sp * sizeFactor,
              color: iconColor ?? Colors.red,
            ),
            Gap(16.h * sizeFactor),
            GetTranslatableText(
              title ?? 'Error',
              style: TextStyle(
                fontSize: 18.sp * sizeFactor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(8.h * sizeFactor),
            GetTranslatableText(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp * sizeFactor,
                color: Colors.grey[600],
              ),
            ),
            if (onRetry != null) ...[
              Gap(24.h * sizeFactor),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: Icon(
                  PhosphorIcons.arrowClockwise(PhosphorIconsStyle.regular),
                ),
                label: GetTranslatableText(retryButtonText ?? 'Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: SetuColors.primaryGreen,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w * sizeFactor,
                    vertical: 12.h * sizeFactor,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Empty state widget
  static Widget empty({
    required String title,
    String? message,
    double sizeFactor = 0.85,
    IconData? icon,
    Color? iconColor,
    Widget? action,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w * sizeFactor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? PhosphorIcons.fileX(PhosphorIconsStyle.regular),
              size: 80.sp * sizeFactor,
              color: iconColor ?? Colors.grey[400],
            ),
            Gap(16.h * sizeFactor),
            GetTranslatableText(
              title,
              style: TextStyle(
                fontSize: 18.sp * sizeFactor,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            if (message != null) ...[
              Gap(8.h * sizeFactor),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp * sizeFactor,
                  color: Colors.grey[600],
                ),
              ),
            ],
            if (action != null) ...[
              Gap(24.h * sizeFactor),
              action,
            ],
          ],
        ),
      ),
    );
  }

  /// No data state widget (similar to empty but more specific)
  static Widget noData({
    required String title,
    String? message,
    double sizeFactor = 0.85,
    VoidCallback? onRefresh,
  }) {
    return empty(
      title: title,
      message: message,
      sizeFactor: sizeFactor,
      icon: PhosphorIcons.database(PhosphorIconsStyle.regular),
      action: onRefresh != null
          ? ElevatedButton.icon(
        onPressed: onRefresh,
        icon: Icon(
          PhosphorIcons.arrowClockwise(PhosphorIconsStyle.regular),
        ),
        label: const GetTranslatableText('Refresh'),
        style: ElevatedButton.styleFrom(
          backgroundColor: SetuColors.primaryGreen,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: 24.w * sizeFactor,
            vertical: 12.h * sizeFactor,
          ),
        ),
      )
          : null,
    );
  }

  /// No internet state widget
  static Widget noInternet({
    VoidCallback? onRetry,
    double sizeFactor = 0.85,
  }) {
    return error(
      error: 'Please check your internet connection and try again',
      title: 'No Internet Connection',
      onRetry: onRetry,
      sizeFactor: sizeFactor,
      icon: PhosphorIcons.wifiSlash(PhosphorIconsStyle.regular),
      iconColor: Colors.orange,
    );
  }

  /// Success state widget (can be used for confirmations)
  static Widget success({
    required String title,
    String? message,
    double sizeFactor = 0.85,
    VoidCallback? onContinue,
    String? continueButtonText,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w * sizeFactor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
              size: 80.sp * sizeFactor,
              color: Colors.green,
            ),
            Gap(16.h * sizeFactor),
            GetTranslatableText(
              title,
              style: TextStyle(
                fontSize: 18.sp * sizeFactor,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            if (message != null) ...[
              Gap(8.h * sizeFactor),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp * sizeFactor,
                  color: Colors.grey[600],
                ),
              ),
            ],
            if (onContinue != null) ...[
              Gap(24.h * sizeFactor),
              ElevatedButton(
                onPressed: onContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: SetuColors.primaryGreen,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w * sizeFactor,
                    vertical: 12.h * sizeFactor,
                  ),
                ),
                child: GetTranslatableText(continueButtonText ?? 'Continue'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}