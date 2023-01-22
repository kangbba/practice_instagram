import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:path/path.dart';
import 'package:practiceinsta/utils/simple_snackbar.dart';

enum FirebaseAuthStatus {signout, signin}

class FirebaseAuthState extends ChangeNotifier {

  bool isSignInProgress = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.signout;
  late User _firebaseUser;

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
    final facebookLogin = FacebookLogin();
    isSignInProgress = true;
    notifyListeners();
    final result = await facebookLogin.logIn(customPermissions: ['email']);
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
        simpleSnackbar(context, 'error');
        break;
    }
    changeFirebaseAuthStatus(FirebaseAuthStatus.signin);

  }

  void _handleFacebookTokenFirebase(BuildContext context, String token) async
  {
      AuthCredential credential = FacebookAuthProvider.credential(token);
      final UserCredential userCredential =  await _firebaseAuth.signInWithCredential(credential);
      if(userCredential.user == null)
      {
        simpleSnackbar(context, 'UserCredential 로그인이 잘안됐음');
      }
      else{
        _firebaseUser = userCredential.user!;
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
      changeFirebaseAuthStatus(FirebaseAuthStatus.signin);
    });
  }
  void signUp(BuildContext context, String mEmail, String mPassword) {
    print('signUp 완료');
    isSignInProgress = true;
    notifyListeners();
    _firebaseAuth
        .createUserWithEmailAndPassword(
        email: mEmail.trim(),
        password: mPassword.trim())
        .catchError((error) {
          print(error.code);
          String _errorMessage = "";
          switch(error.code)
          {
            //**email-already-in-use**:
          // Thrown if there already exists an account with the given email address.
          // **invalid-email**:
          // Thrown if the email address is not valid.
          // **operation-not-allowed**:
          // Thrown if email/password accounts are not enabled. Enable email/password accounts in the Firebase Console, under the Auth tab.
          // **weak-password**:
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
    })
        .then((value) { (signIn(context, mEmail, mPassword) );
    });
    notifyListeners();
  }
  void signOut()
  {
    print('signOut 완료');
    changeFirebaseAuthStatus(FirebaseAuthStatus.signout);
    _firebaseAuth.signOut();
  }
  void changeFirebaseAuthStatus(FirebaseAuthStatus mFirebaseAuthStatus)
  {
    _firebaseAuthStatus = mFirebaseAuthStatus;
    notifyListeners();
  }
}
