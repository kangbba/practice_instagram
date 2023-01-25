import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:practiceinsta/constants/common_size.dart';
import 'package:practiceinsta/models/camera_state.dart';
import 'package:practiceinsta/models/user_model_state.dart';
import 'package:practiceinsta/repo/helper/generate_post_key.dart';
import 'package:practiceinsta/screens/share_post_screen.dart';
import 'package:practiceinsta/widgets/my_progress_indicator.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../constants/screen_size.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({Key? key}) : super(key: key);

  @override
  State<TakePhoto> createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  Widget _progress = MyProgressIndicator(containerSize: 300, progressSize: 300);

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraState>(
      builder: (BuildContext context, CameraState cameraState, Widget? child) {
        return Column(
            children: [
              Container(
                width: size.width,
                height: size.width,
                color: Colors.black,
                child: (cameraState.isReadyToTakePhoto) ? _getPreview(cameraState) : _progress,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: OutlinedButton(
                    onPressed: () {
                      print('');
                      setState(() {
                          if(cameraState.isReadyToTakePhoto)
                            {
                              _attemptTakePhoto(cameraState, context);
                            }
                      });
                    },
                    child: Text(''),
                    style: OutlinedButton.styleFrom(
                      shape: CircleBorder(),
                      side: BorderSide(color: Colors.black12, width: 10),
                      padding: EdgeInsets.all(1),
                    ),
                  ),
                ),
              )
            ]
        );
      },
    );

  }
  Widget _getPreview(CameraState cameraState)
  {
    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
              width: size.width, height: size.width/cameraState.controller.value.aspectRatio,
              child: CameraPreview(cameraState.controller)),
        ),
      ),
    );
  }

  void _attemptTakePhoto(CameraState cameraState, BuildContext context) async{

    final String postKey = getNewPostKey(Provider.of<UserModelState>(context, listen: false).userModel);
    try {
      final XFile xFile = await cameraState.controller.takePicture();
      if(!mounted){
        return;
      }
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=> SharePostScreen(File(xFile.path), postKey : postKey)));
    }
    catch(e){

    }
  }

}
