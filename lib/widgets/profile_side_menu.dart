import 'package:flutter/material.dart';
import 'package:practiceinsta/models/firestore/user_model.dart';
import 'package:practiceinsta/models/user_model_state.dart';
import 'package:provider/provider.dart';

import '../models/firebase_auth_state.dart';
import '../screens/auth_screen.dart';

class ProfileSideMenu extends StatelessWidget {
  const ProfileSideMenu(this.menuWidth, {Key? key, }) : super(key: key);

  final double menuWidth;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: menuWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title:  Text('Setting', style: TextStyle(fontWeight: FontWeight.bold),),
            ),

            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.black87,),
              title: Text('Sign Out'),
              onTap: (){
                print('signout 상태변경 ');
                UserModelState currentUserModelState = Provider.of<UserModelState>(context, listen: false);
                Provider.of<FirebaseAuthState>(context, listen : false).signOut(currentUserModelState);
              },
            ),
          ],
        ),
      ),
    );
  }
}


