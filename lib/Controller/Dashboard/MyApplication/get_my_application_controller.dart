import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../Models/my_application_model.dart';
import '../../../Repository/my_application_repo.dart';

class UserFormsController extends GetxController
    with StateMixin<UserFormsSummary> {
  final UserFormsRepository _repository = UserFormsRepository();

  @override
  void onInit() {
    developer.log('Arguments received: formType');

    super.onInit();
    // fetchUserForms();
    fetchUserForms();
  }

  /// Fetch user forms summary from repository
  Future<void> fetchUserForms() async {
    try {
      change(null, status: RxStatus.loading());

      final formsSummary = await _repository.getUserFormsSummary();

      if (formsSummary.totalForms == 0) {
        change(null, status: RxStatus.empty());
      } else {
        change(formsSummary, status: RxStatus.success());
      }
    } catch (e) {
      change(null,
          status: RxStatus.error('Failed to load forms: ${e.toString()}'));
    }
  }

  /// Refresh forms summary
  Future<void> refreshForms() async {
    try {
      change(state, status: RxStatus.loading());

      final formsSummary = await _repository.refreshFormsSummary();

      if (formsSummary.totalForms == 0) {
        change(null, status: RxStatus.empty());
      } else {
        change(formsSummary, status: RxStatus.success());
      }
    } catch (e) {
      change(state,
          status: RxStatus.error('Failed to refresh forms: ${e.toString()}'));
    }
  }

  IconData getFormIcon(String formKey) {
    switch (formKey) {
      case 'counting_land':
        return PhosphorIcons.mapPin();
      case 'bhusampadan_citizen':
        return PhosphorIcons.house();
      case 'court_land_details':
        return PhosphorIcons.grains();
      case 'court_vatap_citizen_application':
        return PhosphorIcons.file();
      case 'shaskiya_mojni':
        return PhosphorIcons.building();
      default:
        return PhosphorIcons.file();
    }
  }
}
