import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminAuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _currentUser;
  bool _isAdmin = false;
  bool _isLoading = false;
  String? _errorMessage;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null && _isAdmin;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  AdminAuthProvider() {
    _auth.authStateChanges().listen((User? user) async {
      _currentUser = user;
      if (user != null) {
        await _checkAdminStatus(user.uid);
      } else {
        _isAdmin = false;
      }
      notifyListeners();
    });
  }

  Future<void> _checkAdminStatus(String uid) async {
    try {
      DocumentSnapshot adminDoc = await _firestore
          .collection('admins')
          .doc(uid)
          .get();

      _isAdmin = adminDoc.exists && (adminDoc.data() as Map<String, dynamic>)['isActive'] == true;
    } catch (e) {
      _isAdmin = false;
      debugPrint('Error checking admin status: $e');
    }
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _currentUser = userCredential.user;

      // Check if user is an admin
      await _checkAdminStatus(_currentUser!.uid);

      if (!_isAdmin) {
        await _auth.signOut();
        _currentUser = null;
        _errorMessage = 'You do not have admin privileges';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      _currentUser = null;
      _isAdmin = false;

      switch (e.code) {
        case 'user-not-found':
          _errorMessage = 'No admin found for that email';
          break;
        case 'wrong-password':
          _errorMessage = 'Wrong password provided';
          break;
        case 'invalid-email':
          _errorMessage = 'Invalid email address';
          break;
        case 'user-disabled':
          _errorMessage = 'This admin account has been disabled';
          break;
        default:
          _errorMessage = 'Authentication error: ${e.message}';
      }

      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An unexpected error occurred: $e';
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _currentUser = null;
    _isAdmin = false;
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
