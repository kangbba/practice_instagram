import 'package:flutter/material.dart';
import 'package:practice_insta/constants/material_white.dart';
import 'package:practice_insta/home_page.dart';
import 'package:practice_insta/screens/auth_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthScreen(),
      //abcd
      theme: ThemeData(primarySwatch: white),
    );
  }
}
