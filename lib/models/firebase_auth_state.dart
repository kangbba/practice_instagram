import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:path/path.dart';
import 'package:practiceinsta/models/user_model_state.dart';
import 'package:practiceinsta/repo/user_network_repository.dart';
import 'package:practiceinsta/utils/simple_snackbar.dart';
import 'package:provider/provider.dart';

import 'firestore/user_model.dart';

enum FirebaseAuthStatus {signout, signin}

class FirebaseAuthState extends ChangeNotifier {

  bool isSignInProgress = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FacebookLogin _facebookLogin = FacebookLogin();
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.signout;
  User? _firebaseUser;
  User? get firebaseUser => _firebaseUser;

  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;
  void watchAuthChange() {
    _firebaseAuth.authStateChanges().listen((firebaseUser) {

      if(firebaseUser == null)
      {
        return;
      }
      else if(firebaseUser != _firebaseUser)
      {
        _firebaseUser = firebaseUser;
      }
      // do whatever you want based on the firebaseUser state
    });
  }

  void signInWithFacebook(BuildContext context) async
  {
    print('signInWithFacebook 완료');
    isSignInProgress = true;
    notifyListeners();
    final result = await _facebookLogin.logIn(customPermissions: ['email']);
    isSignInProgress = false;
    notifyListeners();
    if(result.accessToken == null)
    {
      throw('access token is null');
    }
    switch(result.status)
    {
      case FacebookLoginStatus.success:
        _handleFacebookTokenFirebase(context,  result.accessToken!.token);
        break;
      case FacebookLoginStatus.cancel:
        simpleSnackbar(context, 'User cancel facebook sign in');
        break;
      case FacebookLoginStatus.error:
        _facebookLogin.logOut();
        simpleSnackbar(context, 'error');
        break;
    }
    changeFirebaseAuthStatus(FirebaseAuthStatus.signin);

  }

  void _handleFacebookTokenFirebase(BuildContext context, String token) async
  {
      AuthCredential credential = FacebookAuthProvider.credential(token);
      final UserCredential userCredential =  await _firebaseAuth.signInWithCredential(credential);
      _firebaseUser = userCredential.user;
      if(userCredential.user == null)
      {
        simpleSnackbar(context, 'UserCredential 로그인이 잘안됐음');
      }
      else{
      }


  }
  void signIn(BuildContext context, String email, String pw)
  {
    print('signIn 완료');
    isSignInProgress = true;
    notifyListeners();
    _firebaseAuth.signInWithEmailAndPassword(email: email.trim(), password: pw.trim())
        .catchError((error){
      print(error.code);
      String _errorMessage = "";
      switch(error.code)
      {
   //**invalid-email**:
      // Thrown if the email address is not valid.
      // **user-disabled**:
      // Thrown if the user corresponding to the given email has been disabled.
      // **user-not-found**:
      // Thrown if there is no user corresponding to the given email.
      // **wrong-password**:
      // Thrown if the password is invalid for the given email, or the account corresponding to the email does not have a password set.
        case 'invalid-email':
          _errorMessage = "invalid-email";
          break;
        case 'user-disabled':
          _errorMessage = "user-disabled";
          break;
        case 'user-not-found':
          _errorMessage = "user-not-found";
          break;
        case 'wrong-password':
          _errorMessage = "wrong-password";
          break;
        default:
          _errorMessage = error.code;
          break;
      }
      simpleSnackbar(context, _errorMessage);
      isSignInProgress = false;
      notifyListeners();
    })
        .then((value) {
      isSignInProgress = false;
      notifyListeners();
    });


    changeFirebaseAuthStatus(FirebaseAuthStatus.signin);
  }
  void signUp(BuildContext context, String mEmail, String mPassword) async {
    print('signUp 완료');
    isSignInProgress = true;
    notifyListeners();
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: mEmail.trim(),password: mPassword.trim())
        .catchError((error) {
      String _errorMessage = "";
      switch (error.code) {
        case 'weak-password':
          _errorMessage = "패스워드 약합니다";
          break;
        case 'operation-not-allowed':
          _errorMessage = "작동이 허가되지 않음";
          break;
        case 'invalid-email':
          _errorMessage = "이메일주소가 유효하지 않습니다";
          break;
        case 'email-already-in-use':
          _errorMessage = "이미 있는 이메일입니다";
          break;
        default:
          _errorMessage = "없는 에러";
          break;
      }
      simpleSnackbar(context, _errorMessage);
      isSignInProgress = false;
      notifyListeners();
    });
    notifyListeners();
    _firebaseUser = userCredential.user;
    if(_firebaseUser == null){
      simpleSnackbar(context, "Please try again later!");
    }
    else{
      userNetworkRepository.attemptCreateUser(userKey : _firebaseUser!.uid, email : _firebaseUser!.email!);
      signIn(context, mEmail, mPassword);
    }
  }
  void signOut(UserModelState userModelState) async
  {
    print('signOut 완료');
    changeFirebaseAuthStatus(FirebaseAuthStatus.signout);
    await _firebaseAuth.signOut();
    if(_facebookLogin != null)
    {
      if(await _facebookLogin.isLoggedIn)
      {
        await _facebookLogin.logOut();
      }
    }
  }
  void changeFirebaseAuthStatus(FirebaseAuthStatus mFirebaseAuthStatus)
  {
    _firebaseAuthStatus = mFirebaseAuthStatus;
    if(_firebaseAuth != null)
    {
      _firebaseUser = _firebaseAuth.currentUser;
    }
    else{
      throw("why _firebase auth is null");
    }
    notifyListeners();
  }
}
