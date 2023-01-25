import 'dart:async';

import 'package:flutter/material.dart';

import 'firestore/user_model.dart';

class UserModelState extends ChangeNotifier{

  late UserModel _userModel;
  UserModel get userModel => _userModel;

  set userModel(UserModel userModel)
  {
    _userModel = userModel;
    notifyListeners();
  }


}