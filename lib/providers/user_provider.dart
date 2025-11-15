import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User? firebaseUser;
  Map<String, dynamic>? profile;

  void setFirebaseUser(User? user) {
    firebaseUser = user;
    notifyListeners();
  }

  void setProfile(Map<String, dynamic>? data) {
    profile = data;
    notifyListeners();
  }
}
