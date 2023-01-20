import 'package:flutter/material.dart';
import 'package:practice_insta/models/camera_state.dart';
import 'package:practice_insta/models/gallery_state.dart';
import 'package:practice_insta/widgets/my_gallery.dart';
import 'package:provider/provider.dart';

import '../widgets/take_photo.dart';

class CameraScreen extends StatefulWidget {
  CameraState _cameraState = CameraState();
  GalleryState _galleryState = GalleryState();
  @override
  State<CameraScreen> createState() {
    _cameraState.getReadyToTakePhoto();
    _galleryState.initProvider();
    return _CameraScreenState();
  }
}


class _CameraScreenState extends State<CameraScreen> {
  int _currentIndex = 1;
  PageController _pageController = PageController(initialPage: 1);
  String _title = "Photo";
  @override

  void dispose() {
    _pageController.dispose();
    widget._cameraState.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CameraState>.value(value: widget._cameraState),
        ChangeNotifierProvider<GalleryState>.value(value: widget._galleryState),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: PageView(
          controller: _pageController,
          children: [
            MyGallery(),
            TakePhoto(),
            Container(
              color: Colors.greenAccent,
            ),
          ],
          onPageChanged: (index){
            print('pageChanged = $index');
            _currentIndex = index;
            setState(() {
              switch(index)
              {
                case 0:
                  _title = "Gallery";
                  break;
                case 1:
                  _title = "Photo";
                  break;
                case 2:
                  _title = "Video";
                  break;
              }
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 0,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          currentIndex: _currentIndex,
          onTap: _onItemTabbed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.radio_button_checked),
                label: 'GALLERY',

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.radio_button_checked),
              label: 'PHOTO',

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.radio_button_checked),
              label: 'VIDEO',

            ),
          ]
        )
      ),
    );
  }

  void _onItemTabbed(int index) {
    print(index);
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
    });
  }
}


