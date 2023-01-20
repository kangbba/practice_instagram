import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

class CameraState extends ChangeNotifier{
   late CameraController _controller;
   late CameraDescription _cameraDescription;
   bool _readyTakePhoto = false;

   @override
  void dispose() {
    // TODO: implement dispose
    if(_controller != null)
    {
      _controller!.dispose();
    }
    _readyTakePhoto = false;
    notifyListeners();
  }


//available camera 가져오기
// 카메라 리스트에서 첫번쨰 카메라 사용해서 CameraController 인스턴스 생성
// CameraController.Initialize(),
// show preview.
// set ready to take photo -> true 로

   void getReadyToTakePhoto() async
   {
     List<CameraDescription> cameras = await availableCameras();

     if(cameras != null && cameras.isNotEmpty)
     {
        setCameraDescription(cameras[0]);
     }
     bool init = false;
     while(!init)
     {
       if(_controller != null && _cameraDescription != null)
         init = await initialize();
     }
     _readyTakePhoto = true;
     notifyListeners();
   }

   void setCameraDescription(CameraDescription cameraDescription)
   {
     _cameraDescription = cameraDescription;
     _controller = CameraController(_cameraDescription!, ResolutionPreset.medium);

   }
   Future<bool> initialize() async
   {
     try {
       await _controller!.initialize();
       return true;
     }
     catch (e) {
       return false;
     }
   }

   CameraController get controller => _controller;
   CameraDescription get description => _cameraDescription;
   bool get isReadyToTakePhoto =>  _readyTakePhoto;
}