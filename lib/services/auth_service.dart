import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final AuthStateNotifier authNotifier = AuthStateNotifier();

class AuthStateNotifier extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isLoading = true;

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;

  AuthStateNotifier() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      _isLoading = true;
      notifyListeners();

      _isLoggedIn = user != null;

      _isLoading = false;
      notifyListeners();
    });
  }
}
