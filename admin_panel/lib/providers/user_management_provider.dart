import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myshetribe_admin/models/user_model.dart';

enum VerificationStatus { pending, underReview, approved, rejected }

class UserManagementProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<UserModel> _pendingUsers = [];
  List<UserModel> _allUsers = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<UserModel> get pendingUsers => _pendingUsers;
  List<UserModel> get allUsers => _allUsers;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Statistics
  int get totalUsers => _allUsers.length;
  int get pendingVerifications => _pendingUsers.length;
  int get approvedUsers => _allUsers.where((u) => u.verificationStatus == VerificationStatus.approved).length;
  int get rejectedUsers => _allUsers.where((u) => u.verificationStatus == VerificationStatus.rejected).length;

  Future<void> loadPendingVerifications() async {
    try {
      _isLoading = true;
      notifyListeners();

      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .where('verificationStatus', whereIn: ['pending', 'underReview'])
          .orderBy('createdAt', descending: true)
          .get();

      _pendingUsers = snapshot.docs
          .map((doc) => UserModel.fromFirestore(doc))
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load pending verifications: $e';
      notifyListeners();
    }
  }

  Future<void> loadAllUsers() async {
    try {
      _isLoading = true;
      notifyListeners();

      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .orderBy('createdAt', descending: true)
          .get();

      _allUsers = snapshot.docs
          .map((doc) => UserModel.fromFirestore(doc))
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load users: $e';
      notifyListeners();
    }
  }

  Future<bool> approveVerification(String userId, {String? notes}) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _firestore.collection('users').doc(userId).update({
        'verificationStatus': 'approved',
        'verificationNotes': notes,
        'verifiedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Reload data
      await loadPendingVerifications();
      await loadAllUsers();

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to approve verification: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> rejectVerification(String userId, {required String reason}) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _firestore.collection('users').doc(userId).update({
        'verificationStatus': 'rejected',
        'rejectionReason': reason,
        'rejectedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Reload data
      await loadPendingVerifications();
      await loadAllUsers();

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to reject verification: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateUserStatus(String userId, bool isActive) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'isActive': isActive,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      await loadAllUsers();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update user status: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteUser(String userId) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _firestore.collection('users').doc(userId).delete();

      await loadAllUsers();
      await loadPendingVerifications();

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to delete user: $e';
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
