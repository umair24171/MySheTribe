import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:myshetribe/models/user_model.dart';
import 'package:myshetribe/services/firestore_service.dart';
import 'package:myshetribe/services/storage_service.dart';
import 'package:myshetribe/services/analytics_service.dart';

class UserProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final StorageService _storageService = StorageService();
  final AnalyticsService _analyticsService = AnalyticsService();

  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Load user data
  Future<void> loadUser(String uid) async {
    try {
      _isLoading = true;
      notifyListeners();

      _user = await _firestoreService.getUser(uid);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Update user profile
  Future<bool> updateProfile({
    String? fullName,
    String? phoneNumber,
    String? city,
    String? country,
    String? nationality,
    String? ageRange,
    String? language,
    String? profession,
    List<String>? interests,
    String? bio,
  }) async {
    if (_user == null) return false;

    try {
      _isLoading = true;
      notifyListeners();

      Map<String, dynamic> updateData = {};
      if (fullName != null) updateData['fullName'] = fullName;
      if (phoneNumber != null) updateData['phoneNumber'] = phoneNumber;
      if (city != null) updateData['city'] = city;
      if (country != null) updateData['country'] = country;
      if (nationality != null) updateData['nationality'] = nationality;
      if (ageRange != null) updateData['ageRange'] = ageRange;
      if (language != null) updateData['language'] = language;
      if (profession != null) updateData['profession'] = profession;
      if (interests != null) updateData['interests'] = interests;
      if (bio != null) updateData['bio'] = bio;

      await _firestoreService.updateUser(_user!.uid, updateData);

      // Reload user data
      await loadUser(_user!.uid);

      await _analyticsService.logProfileUpdate();

      _isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Upload profile image
  Future<bool> uploadProfileImage(File imageFile) async {
    if (_user == null) return false;

    try {
      _isLoading = true;
      notifyListeners();

      String imageUrl = await _storageService.uploadProfileImage(imageFile, _user!.uid);

      await _firestoreService.updateUser(_user!.uid, {
        'profileImageUrl': imageUrl,
      });

      // Reload user data
      await loadUser(_user!.uid);

      _isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Upload verification document
  Future<bool> uploadVerificationDocument(File docFile) async {
    if (_user == null) return false;

    try {
      _isLoading = true;
      notifyListeners();

      String docUrl = await _storageService.uploadVerificationDocument(docFile, _user!.uid);

      await _firestoreService.updateUser(_user!.uid, {
        'verificationDocUrl': docUrl,
        'verificationStatus': VerificationStatus.underReview.toString().split('.').last,
      });

      // Reload user data
      await loadUser(_user!.uid);

      _isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Update relocation information
  Future<bool> updateRelocationInfo(RelocationInfo relocationInfo) async {
    if (_user == null) return false;

    try {
      _isLoading = true;
      notifyListeners();

      await _firestoreService.updateUser(_user!.uid, {
        'relocationInfo': relocationInfo.toMap(),
      });

      // Reload user data
      await loadUser(_user!.uid);

      await _analyticsService.logProfileUpdate();

      _isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Listen to user updates in real-time
  Stream<UserModel?> getUserStream(String uid) {
    return _firestoreService.getUserStream(uid);
  }
}
