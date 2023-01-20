import 'package:flutter/material.dart';
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
                Provider.of<FirebaseAuthState>(context, listen : false).changeFirebaseAuthStatus(FirebaseAuthStatus.signout);

              },
            ),

          ],
        ),
      ),
    );
  }
}


