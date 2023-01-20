import 'package:flutter/material.dart';
import 'package:practiceinsta/constants/material_white.dart';
import 'package:practiceinsta/home_page.dart';
import 'package:practiceinsta/models/firebase_auth_state.dart';
import 'package:practiceinsta/screens/auth_screen.dart';
import 'package:practiceinsta/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FirebaseAuthState>.value(
      value: _firebaseAuthState,
      child: MaterialApp(
        home: Consumer<FirebaseAuthState>(
          builder: (BuildContext context, FirebaseAuthState firebaseAuthState, Widget? child)
          {
            switch(firebaseAuthState.firebaseAuthStatus)
            {
              case FirebaseAuthStatus.signout:
                return AuthScreen();
              case FirebaseAuthStatus.progress:
                return MyProgressIndicator(containerSize: 100, progressSize: 100);
              case FirebaseAuthStatus.signin:
                return HomePage();
              default:
                return MyProgressIndicator(containerSize: 100, progressSize: 100);
            }
          },
        ),
        theme: ThemeData(primarySwatch: white),
      ),
    );
  }
}
