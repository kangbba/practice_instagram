import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum FirebaseAuthStatus {signout, progress, signin}

class FirebaseAuthState extends ChangeNotifier{

  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.signout;

  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;

  void changeFirebaseAuthStatus(FirebaseAuthStatus m_firebaseAuthStatus)
  {
    _firebaseAuthStatus = m_firebaseAuthStatus;
    notifyListeners();
  }
}
