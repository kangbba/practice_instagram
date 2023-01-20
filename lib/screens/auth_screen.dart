import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:practiceinsta/screens/profile_screen.dart';
import 'package:practiceinsta/widgets/sign_in_form.dart';
import 'package:practiceinsta/widgets/sign_up_form.dart';

import '../widgets/fade_stack.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  Widget signUpForm = SignUpForm();
  Widget signInForm = SignInForm();
  late Widget currentWidget = signInForm;

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.white,
    minimumSize: Size(88, 44),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
    backgroundColor: Colors.white,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedSwitcher(
              child: currentWidget,
              duration: duration,
            ),
            Positioned(
              left :0, right :0, bottom: 0,
              child: Container(
                height: 100,
                child: Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
            ),
            Positioned(
              left :0, right :0, bottom: 0,
              child: Container(
                color: Colors.white,
                child: TextButton(
                  style: flatButtonStyle,
                  onPressed: (){
                    setState(() {
                      if(currentWidget is SignUpForm)
                      {
                       currentWidget = signInForm;
                      }
                      else{
                        currentWidget = signUpForm;
                      }
                    });
                  },
                  child: RichText(
                    text : TextSpan(
                        text : (currentWidget is SignUpForm) ? "Already have an account? " : "Don't have an account? ",
                        style: TextStyle(color: Colors.grey),
                        children: [
                          TextSpan(
                              text: (currentWidget is SignUpForm) ? "Sign In" : "Sign Up",
                              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)
                          ),
                        ]
                    )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
