import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

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

  void signInWithFacebook()
  {
    print('signInWithFacebook 완료');
    changeFirebaseAuthStatus(FirebaseAuthStatus.signin);
    _firebaseAuth.signInAnonymously();
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
      SnackBar snackBar = SnackBar(
        content: Text(_errorMessage), //snack bar의 내용. icon, button같은것도 가능하다.
        duration: Duration(milliseconds: 10000),
        action: SnackBarAction( //추가로 작업을 넣기. 버튼넣기라 생각하면 편하다.
          label: 'OK', //버튼이름

          onPressed: (){
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }, //버튼 눌렀을때.
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
          SnackBar snackBar = SnackBar(
            content: Text(_errorMessage), //snack bar의 내용. icon, button같은것도 가능하다.
            duration: Duration(milliseconds: 10000),
            action: SnackBarAction( //추가로 작업을 넣기. 버튼넣기라 생각하면 편하다.
              label: 'OK', //버튼이름

              onPressed: (){
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              }, //버튼 눌렀을때.
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
