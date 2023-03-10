import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:practiceinsta/models/gallery_state.dart';
import 'package:local_image_provider/local_image_provider.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practiceinsta/models/user_model_state.dart';
import 'package:practiceinsta/repo/helper/generate_post_key.dart';
import 'package:provider/provider.dart';

import '../screens/share_post_screen.dart';

class MyGallery extends StatefulWidget {
  const MyGallery({Key? key}) : super(key: key);

  @override
  State<MyGallery> createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryState>(

      builder: (BuildContext context, GalleryState galleryState, Widget? child) {
        return GridView.count(
          crossAxisCount: 3,
          children: getImages(context, galleryState)
        );
      },
    );
  }

  List<Widget> getImages(BuildContext context, GalleryState galleryState)
  {
    if(galleryState.images.isNotEmpty) {
      return galleryState.images
          .map((localImage) => InkWell(
          onTap: () async{
            Uint8List bytes = await localImage.getScaledImageBytes(galleryState.localImageProvider, 0.3);
            final String postKey = getNewPostKey(Provider.of<UserModelState>(context, listen: false).userModel);
            try{
              final path = join((await getTemporaryDirectory()).path, '$postKey.png');
              File imageFile = File(path)..writeAsBytesSync(bytes);
              if(!mounted)
              {
                return;
              }
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => SharePostScreen(imageFile, postKey : postKey)));
            }
            catch(e){

            }
          },
          child: Image(
            fit: BoxFit.cover,
            image: DeviceImage(scale : 0.1, localImage),))).toList();
    }
    else{
      throw("dd");
    }
  }
}
