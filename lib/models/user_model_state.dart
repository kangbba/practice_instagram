import 'dart:async';

import 'package:flutter/material.dart';

import 'firestore/user_model.dart';

class UserModelState extends ChangeNotifier{

  late UserModel _userModel;
  StreamSubscription<UserModel>? _currentStreamSub;

  set userModel(UserModel userModel)
  {
    _userModel = userModel;
    notifyListeners();
  }
  UserModel get userModel
  {
    return _userModel;
  }

  set currentStreamSub(StreamSubscription<UserModel> currentStreamSub) => _currentStreamSub = currentStreamSub;

  clear() {
    if(_currentStreamSub != null)
    {
      _currentStreamSub!.cancel();
    }
    _currentStreamSub = null;
  }
}