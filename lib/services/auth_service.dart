import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:physix_companion_app/utils.dart';

final AuthStateNotifier authNotifier = AuthStateNotifier();

class AuthStateNotifier extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isLoading = true;
  UserType? userType;

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;

  AuthStateNotifier() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      _isLoading = true;
      notifyListeners();

      _isLoggedIn = user != null;

      if (_isLoggedIn) {
        await updateUserRole(user!.uid);
      }

      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> updateUserRole(String uid) async {
    final adminDoc =
        await FirebaseFirestore.instance.collection('admins').doc(uid).get();
    if (adminDoc.exists) {
      userType = UserType.admin;
      return;
    }

    final teacherDoc =
        await FirebaseFirestore.instance.collection('teachers').doc(uid).get();
    if (teacherDoc.exists) {
      userType = UserType.teachers;
      return;
    }

    final studentDoc =
        await FirebaseFirestore.instance.collection('students').doc(uid).get();
    if (studentDoc.exists) {
      userType = UserType.students;
      return;
    }

    userType = null;
  }

  void logoutUser() {
    _isLoggedIn = false;
    userType = null;
    notifyListeners();
  }
}
