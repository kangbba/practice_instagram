import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practiceinsta/constants/material_white.dart';
import 'package:practiceinsta/home_page.dart';
import 'package:practiceinsta/models/firebase_auth_state.dart';
import 'package:practiceinsta/models/user_model_state.dart';
import 'package:practiceinsta/repo/user_network_repository.dart';
import 'package:practiceinsta/screens/auth_screen.dart';
import 'package:practiceinsta/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget{

  Widget _currentWidget = Container(color: Colors.pink,);

  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();

@override
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseAuthState>.value(
        value: _firebaseAuthState),

        ChangeNotifierProvider<UserModelState>(create: (_) => UserModelState(),),
      ],
      child: MaterialApp(
        home: Consumer<FirebaseAuthState>(
          builder: (BuildContext context, FirebaseAuthState firebaseAuthState, Widget? child)
          {
            switch(firebaseAuthState.firebaseAuthStatus)
            {
              case FirebaseAuthStatus.signout:
                _clearUserModel(context);
                _currentWidget = AuthScreen();
                break;
              case FirebaseAuthStatus.signin:
                _initUserModel(firebaseAuthState, context);
                _currentWidget = HomePage();
                break;
              default:
                print(firebaseAuthState.firebaseAuthStatus);
                _currentWidget = Container(color: Colors.yellow,);
                break;
            }

            return AnimatedSwitcher(
              duration: Duration(milliseconds: 1000),
              child: _currentWidget,
            );
          },
        ),
        theme: ThemeData(primarySwatch: white),
      ),
    );
  }

  void _initUserModel(FirebaseAuthState firebaseAuthState, BuildContext context)
  {
    UserModelState userModelState = Provider.of<UserModelState>(context, listen: false);
    userModelState.currentStreamSub = userNetworkRepository.getUserModelStream(firebaseAuthState.firebaseUser!.uid)
        .listen((userModel) {
          userModelState.userModel = userModel;
    });
  }
  void _clearUserModel(BuildContext context)
  {
    UserModelState userModelState =
    Provider.of<UserModelState>(context, listen: false);
    userModelState.clear();
  }
}
