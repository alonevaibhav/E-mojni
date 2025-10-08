import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'main_controller.dart';

class CensusSeventhController extends GetxController with StepValidationMixin, StepDataMixin {
  // Observable list for next of kin entries
  final nextOfKinEntries = <Map<String, dynamic>>[].obs;

  // Dropdown options
  final List<String> directionOptions = ['East', 'West', 'North', 'South'];

  final List<String> naturalResourcesOptions = [
    'Name',
    'Road',
    'Pull',
    'River',
    'Broomstick',
    'Forest',
    'Village',
    'Lake',
    'Shiva/Shivarasta',
    'Other'
  ];

  @override
  void onInit() {
    super.onInit();
    // Initialize with one entry
    addNextOfKinEntry();
  }

  void addNextOfKinEntry() {
    nextOfKinEntries.add({
      'addressController': TextEditingController(),
      'mobileController': TextEditingController(),
      'surveyNoController': TextEditingController(),
      'direction': '',
      'naturalResources': '',
      'address': '',
      'mobile': '',
      'surveyNo': '',
      'subEntries': <Map<String, dynamic>>[].obs,
    });
    // Trigger validation update
    nextOfKinEntries.refresh();
  }

  void removeNextOfKinEntry(int index) {
    if (nextOfKinEntries.length > 1 && index < nextOfKinEntries.length) {
      final entry = nextOfKinEntries[index];
      (entry['addressController'] as TextEditingController?)?.dispose();
      (entry['mobileController'] as TextEditingController?)?.dispose();
      (entry['surveyNoController'] as TextEditingController?)?.dispose();

      final subEntries = entry['subEntries'] as RxList<Map<String, dynamic>>?;
      if (subEntries != null) {
        for (final subEntry in subEntries) {
          (subEntry['nameController'] as TextEditingController?)?.dispose();
          (subEntry['addressController'] as TextEditingController?)?.dispose();
          (subEntry['mobileController'] as TextEditingController?)?.dispose();
          (subEntry['surveyNoController'] as TextEditingController?)?.dispose();
        }
      }

      nextOfKinEntries.removeAt(index);
      // Trigger validation update
      nextOfKinEntries.refresh();
    }
  }

  void updateNextOfKinEntry(int index, String field, String value) {
    if (index < nextOfKinEntries.length) {
      nextOfKinEntries[index][field] = value;
      nextOfKinEntries.refresh();
    }
  }

  void updateDirection(int index, String direction) {
    if (index < nextOfKinEntries.length) {
      nextOfKinEntries[index]['direction'] = direction;
      nextOfKinEntries.refresh();
    }
  }

  void updateNaturalResources(int index, String naturalResources) {
    if (index < nextOfKinEntries.length) {
      nextOfKinEntries[index]['naturalResources'] = naturalResources;

      // Clean up existing sub-entries
      final subEntries =
      nextOfKinEntries[index]['subEntries'] as RxList<Map<String, dynamic>>;
      for (final subEntry in subEntries) {
        (subEntry['nameController'] as TextEditingController?)?.dispose();
        (subEntry['addressController'] as TextEditingController?)?.dispose();
        (subEntry['mobileController'] as TextEditingController?)?.dispose();
        (subEntry['surveyNoController'] as TextEditingController?)?.dispose();
      }
      subEntries.clear();

      // Add sub-entry if needed
      if (naturalResources == 'Name' || naturalResources == 'Other') {
        addSubEntry(index);
      }

      nextOfKinEntries.refresh();
    }
  }

  void addSubEntry(int parentIndex) {
    if (parentIndex < nextOfKinEntries.length) {
      final subEntries = nextOfKinEntries[parentIndex]['subEntries']
      as RxList<Map<String, dynamic>>;
      subEntries.add({
        'nameController': TextEditingController(),
        'addressController': TextEditingController(),
        'mobileController': TextEditingController(),
        'surveyNoController': TextEditingController(),
        'name': '',
        'address': '',
        'mobile': '',
        'surveyNo': '',
      });
      subEntries.refresh();
    }
  }

  void removeSubEntry(int parentIndex, int subIndex) {
    if (parentIndex < nextOfKinEntries.length) {
      final subEntries = nextOfKinEntries[parentIndex]['subEntries']
      as RxList<Map<String, dynamic>>;
      if (subEntries.length > 1 && subIndex < subEntries.length) {
        final subEntry = subEntries[subIndex];
        (subEntry['nameController'] as TextEditingController?)?.dispose();
        (subEntry['addressController'] as TextEditingController?)?.dispose();
        (subEntry['mobileController'] as TextEditingController?)?.dispose();
        (subEntry['surveyNoController'] as TextEditingController?)?.dispose();

        subEntries.removeAt(subIndex);
        subEntries.refresh();
      }
    }
  }

  void updateSubEntry(
      int parentIndex, int subIndex, String field, String value) {
    if (parentIndex < nextOfKinEntries.length) {
      final subEntries = nextOfKinEntries[parentIndex]['subEntries']
      as RxList<Map<String, dynamic>>;
      if (subIndex < subEntries.length) {
        subEntries[subIndex][field] = value;
        subEntries.refresh();
      }
    }
  }

  bool shouldShowSubEntries(int index) {
    if (index < nextOfKinEntries.length) {
      final naturalResources =
      nextOfKinEntries[index]['naturalResources'] as String;
      return naturalResources == 'Name' || naturalResources == 'Other';
    }
    return false;
  }

  // ✅ Helper: Ensure all four directions are selected
  bool _validateAllDirectionsSelected() {
    final usedDirections = <String>{};

    for (final entry in nextOfKinEntries) {
      final direction = entry['direction'] as String? ?? '';
      if (direction.trim().isNotEmpty) {
        usedDirections.add(direction);
      }
    }

    return usedDirections.containsAll(['East', 'West', 'North', 'South']);
  }

  @override
  bool validateCurrentSubStep(String field) {
    switch (field) {
      case 'next_of_kin':
        return _validateNextOfKinEntries();
      default:
        return true;
    }
  }

  bool _validateNextOfKinEntries() {
    // Must have at least 4 entries (one for each direction)
    if (nextOfKinEntries.isEmpty || nextOfKinEntries.length < 4) {
      return false;
    }

    // Validate all four directions are selected
    if (!_validateAllDirectionsSelected()) {
      return false;
    }

    // Validate each entry
    for (final entry in nextOfKinEntries) {
      final naturalResources = entry['naturalResources'] as String? ?? '';
      final direction = entry['direction'] as String? ?? '';

      if (naturalResources.trim().isEmpty || direction.trim().isEmpty) {
        return false;
      }

      // If Name or Other is selected, validate sub-entries
      if (naturalResources == 'Name' || naturalResources == 'Other') {
        final subEntries = entry['subEntries'] as RxList<Map<String, dynamic>>?;
        if (subEntries == null || subEntries.isEmpty) return false;

        for (final subEntry in subEntries) {
          if ((subEntry['name'] as String? ?? '').trim().isEmpty ||
              (subEntry['address'] as String? ?? '').trim().isEmpty ||
              (subEntry['mobile'] as String? ?? '').trim().isEmpty ||
              (subEntry['surveyNo'] as String? ?? '').trim().isEmpty) {
            return false;
          }

          final mobile = (subEntry['mobile'] as String? ?? '').trim();
          if (mobile.length != 10 || !RegExp(r'^\d+$').hasMatch(mobile)) {
            return false;
          }
        }
      }
    }

    return true;
  }

  @override
  bool isStepCompleted(List<String> fields) {
    for (String field in fields) {
      if (!validateCurrentSubStep(field)) {
        return false;
      }
    }
    return true;
  }

  @override
  String getFieldError(String field) {
    switch (field) {
      case 'next_of_kin':
        if (nextOfKinEntries.isEmpty) {
          return 'At least one next of kin entry is required';
        }

        if (nextOfKinEntries.length < 4) {
          return 'You must add entries for all four directions (East, West, North, South)';
        }

        if (!_validateAllDirectionsSelected()) {
          return 'All four directions (East, West, North, South) must be selected';
        }

        // Check for duplicate directions
        final usedDirections = <String>[];
        for (int i = 0; i < nextOfKinEntries.length; i++) {
          final direction = nextOfKinEntries[i]['direction'] as String? ?? '';
          if (direction.trim().isNotEmpty) {
            if (usedDirections.contains(direction)) {
              return 'Direction "$direction" is used multiple times. Each direction should be used only once.';
            }
            usedDirections.add(direction);
          }
        }

        // Validate individual entries
        for (int i = 0; i < nextOfKinEntries.length; i++) {
          final entry = nextOfKinEntries[i];
          final naturalResources = entry['naturalResources'] as String? ?? '';
          final direction = entry['direction'] as String? ?? '';

          if (naturalResources.trim().isEmpty) {
            return 'Natural resources is required in entry ${i + 1}';
          }

          if (direction.trim().isEmpty) {
            return 'Direction is required in entry ${i + 1}';
          }

          if (naturalResources == 'Name' || naturalResources == 'Other') {
            final subEntries =
            entry['subEntries'] as RxList<Map<String, dynamic>>?;
            if (subEntries == null || subEntries.isEmpty) {
              return 'At least one sub-entry is required for $naturalResources in entry ${i + 1}';
            }

            for (int j = 0; j < subEntries.length; j++) {
              final subEntry = subEntries[j];
              if ((subEntry['name'] as String? ?? '').trim().isEmpty) {
                return 'Full name is required in entry ${i + 1}, sub-entry ${j + 1}';
              }
              if ((subEntry['address'] as String? ?? '').trim().isEmpty) {
                return 'Address is required in entry ${i + 1}, sub-entry ${j + 1}';
              }
              if ((subEntry['mobile'] as String? ?? '').trim().isEmpty) {
                return 'Mobile number is required in entry ${i + 1}, sub-entry ${j + 1}';
              }
              if ((subEntry['surveyNo'] as String? ?? '').trim().isEmpty) {
                return 'Survey No./Group No. is required in entry ${i + 1}, sub-entry ${j + 1}';
              }

              final mobile = (subEntry['mobile'] as String? ?? '').trim();
              if (mobile.length != 10) {
                return 'Mobile number must be exactly 10 digits in entry ${i + 1}, sub-entry ${j + 1}';
              }
              if (!RegExp(r'^\d+$').hasMatch(mobile)) {
                return 'Mobile number must contain only digits in entry ${i + 1}, sub-entry ${j + 1}';
              }
            }
          }
        }
        return 'Please fill all required fields';
      default:
        return 'This field is required';
    }
  }

  @override
  Map<String, dynamic> getStepData() {
    final List<Map<String, dynamic>> entriesData = [];

    for (final entry in nextOfKinEntries) {
      final naturalResources = entry['naturalResources'] as String? ?? '';
      final direction = entry['direction'] as String? ?? '';

      if (naturalResources == 'Name' || naturalResources == 'Other') {
        final subEntries = entry['subEntries'] as RxList<Map<String, dynamic>>?;
        final List<Map<String, dynamic>> subEntriesData = [];

        if (subEntries != null) {
          for (final subEntry in subEntries) {
            subEntriesData.add({
              'name': subEntry['name'] as String? ?? '',
              'address': subEntry['address'] as String? ?? '',
              'mobile': subEntry['mobile'] as String? ?? '',
              'surveyNo': subEntry['surveyNo'] as String? ?? '',
            });
          }
        }

        entriesData.add({
          'naturalResources': naturalResources,
          'direction': direction,
          'subEntries': subEntriesData,
          'totalSubEntries': subEntriesData.length,
        });
      } else {
        entriesData.add({
          'direction': direction,
          'naturalResources': naturalResources,
        });
      }
    }

    return {
      'nextOfKinEntries': entriesData,
      'totalNextOfKinEntries': entriesData.length,
    };
  }

  @override
  void onClose() {
    for (final entry in nextOfKinEntries) {
      (entry['addressController'] as TextEditingController?)?.dispose();
      (entry['mobileController'] as TextEditingController?)?.dispose();
      (entry['surveyNoController'] as TextEditingController?)?.dispose();

      final subEntries = entry['subEntries'] as RxList<Map<String, dynamic>>?;
      if (subEntries != null) {
        for (final subEntry in subEntries) {
          (subEntry['nameController'] as TextEditingController?)?.dispose();
          (subEntry['addressController'] as TextEditingController?)?.dispose();
          (subEntry['mobileController'] as TextEditingController?)?.dispose();
          (subEntry['surveyNoController'] as TextEditingController?)?.dispose();
        }
      }
    }
    super.onClose();
  }
}