// repositories/preview_repository.dart
import 'dart:developer' as developer;
import '../API Service/api_service.dart';
import '../Constants/api_constant.dart';
import '../Models/counting_land_model.dart';

class PreviewRepository {
  // Cache storage
  static final Map<String, _CacheData<List<CountingLandForm>>> _cache = {};
  static const _cacheDuration = Duration(minutes: 5);

  Future<List<CountingLandForm>> getFormsByType(
      String formType, {
        bool forceRefresh = false,
      }) async {
    final cacheKey = formType;

    // Check cache validity
    if (!forceRefresh && _isCacheValid(cacheKey)) {
      developer.log('📦 Using cached data for $formType');
      return _cache[cacheKey]!.data;
    }

    // Fetch fresh data
    developer.log('🌐 Fetching fresh data for $formType');
    final data = await _fetchFromApi(formType);

    // Update cache
    _cache[cacheKey] = _CacheData(
      data: data,
      timestamp: DateTime.now(),
    );

    return data;
  }

  Future<List<CountingLandForm>> _fetchFromApi(String formType) async {
    try {
      String userId = (await ApiService.getUid()) ?? "0";

      final response = await ApiService.get<CountingLandFormResponse>(
        endpoint: getPreviewData(int.parse(userId), formType),
        fromJson: (json) => CountingLandFormResponse.fromJson(json),
        includeToken: true,
      );

      if (response.success && response.data != null) {
        return response.data!.data.forms;
      } else {
        throw Exception(response.errorMessage ?? 'Failed to load forms');
      }
    } catch (e) {
      developer.log('❌ API Error: $e');
      rethrow;
    }
  }

  bool _isCacheValid(String key) {
    if (!_cache.containsKey(key)) return false;

    final cacheData = _cache[key]!;
    final age = DateTime.now().difference(cacheData.timestamp);

    return age < _cacheDuration;
  }

  void clearCache([String? formType]) {
    if (formType != null) {
      _cache.remove(formType);
    } else {
      _cache.clear();
    }
  }
}

class _CacheData<T> {
  final T data;
  final DateTime timestamp;

  _CacheData({required this.data, required this.timestamp});
}