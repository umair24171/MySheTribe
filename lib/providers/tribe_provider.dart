import 'package:flutter/foundation.dart';
import 'package:myshetribe/models/tribe_model.dart';
import 'package:myshetribe/services/firestore_service.dart';
import 'package:myshetribe/services/analytics_service.dart';

class TribeProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final AnalyticsService _analyticsService = AnalyticsService();

  List<TribeModel> _tribes = [];
  List<TribeModel> _recommendedTribes = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<TribeModel> get tribes => _tribes;
  List<TribeModel> get recommendedTribes => _recommendedTribes;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Load all tribes
  Future<void> loadTribes({String? city}) async {
    try {
      _isLoading = true;
      notifyListeners();

      if (city != null) {
        _tribes = await _firestoreService.getTribesByCity(city);
      } else {
        _tribes = await _firestoreService.getAllTribes();
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Get tribe by ID
  Future<TribeModel?> getTribe(String id) async {
    try {
      return await _firestoreService.getTribe(id);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  // Load recommended tribes for user
  void loadRecommendedTribes(List<String> tribeIds) async {
    try {
      _isLoading = true;
      notifyListeners();

      _recommendedTribes = [];

      for (String tribeId in tribeIds) {
        TribeModel? tribe = await _firestoreService.getTribe(tribeId);
        if (tribe != null) {
          _recommendedTribes.add(tribe);
        }
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Join tribe
  Future<bool> joinTribe(String tribeId, String tribeName) async {
    try {
      await _analyticsService.logTribeJoin(tribeId, tribeName);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Listen to tribes stream
  Stream<List<TribeModel>> getTribesStream() {
    return _firestoreService.getTribesStream();
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
