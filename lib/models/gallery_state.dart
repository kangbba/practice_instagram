import 'package:flutter/material.dart';
import 'package:local_image_provider/local_image_provider.dart';

class GalleryState extends ChangeNotifier{
  late LocalImageProvider _localImageProvider;
  late List<LocalImage> _images;
  bool _hasPermission = false;

  Future<bool> initProvider() async{
    _localImageProvider = LocalImageProvider();
    _hasPermission = await _localImageProvider.initialize();
    if(_hasPermission)
    {
      _images = await _localImageProvider.findLatest(30);
      notifyListeners();
      return true;
    }
    else{
      return false;
    }
  }
  ///

  List<LocalImage> get images => _images;
  LocalImageProvider get localImageProvider => _localImageProvider;
}