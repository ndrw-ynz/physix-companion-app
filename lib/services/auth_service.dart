import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final AuthStateNotifier authNotifier = AuthStateNotifier();

class AuthStateNotifier extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isLoading = true;
  String _userRole = '';

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  String get userRole => _userRole;

  AuthStateNotifier() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      _isLoading = true;
      notifyListeners();

      _isLoggedIn = user != null;
      if (_isLoggedIn && user != null) {
        try {
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
          _userRole = userDoc['role'];
          print("User Role Fetched: $_userRole");
        } catch (e) {
          print("ERROR: $e");
        }
      } else {
        _userRole = '';
      }

      _isLoading = false;
      notifyListeners();
    });
  }
}
