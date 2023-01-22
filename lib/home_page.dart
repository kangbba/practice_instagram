import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:practiceinsta/screens/camera_screen.dart';
import 'package:practiceinsta/screens/feed_screen.dart';
import 'package:practiceinsta/screens/profile_screen.dart';
import 'package:practiceinsta/screens/search_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:camera/camera.dart';
import 'package:practiceinsta/utils/simple_snackbar.dart';
import 'constants/screen_size.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> btmNavItems =
  [
     BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label:(''),
    ),
     BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label:(''),
    ),
     BottomNavigationBarItem(
      icon: Icon(Icons.add),
      label:(''),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.ac_unit_sharp),
      label:(''),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outlined),
      label:(''),
    ),
  ];

  int _selectedIndex = 0;
  static List<Widget> _screens = <Widget>[
    FeedScreen(),
    SearchScreen(),
    Container(color: Colors.blueAccent, ),
    Container(color: Colors.blueAccent, ),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: btmNavItems,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black54,
        currentIndex: _selectedIndex,
        onTap: _onBtnItemClick,
      ),
    );
  }

  void _onBtnItemClick(int index)
  {
    switch(index)
    {
      case 2:
        _openCamera();
        break;
      default:
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openCamera() async {
    if(await checkIfPermisionGranted(context))
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CameraScreen()));
    }
    else{
      SnackBar snackBar = SnackBar(
        content: Text('권한 허용 해주셔야 사용 가능합니다.'), //snack bar의 내용. icon, button같은것도 가능하다.
        action: SnackBarAction( //추가로 작업을 넣기. 버튼넣기라 생각하면 편하다.
          label: 'OK', //버튼이름
          onPressed: (){
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            AppSettings.openAppSettings();
          }, //버튼 눌렀을때.
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<bool> checkIfPermisionGranted(BuildContext context) async
  {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Platform.isIOS ? Permission.photos : Permission.storage
    ].request();
    bool permitted = true;
    statuses.forEach((permission, permissionStatus){
      if(!permissionStatus.isGranted){
        permitted = false;
      }
    });
    print(permitted);
    return permitted;
  }
}


