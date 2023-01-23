import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practiceinsta/constants/firestore_keys.dart';

class UserModel {
  final String userKey;
  final String profileImg;
  final String email;
  final List<dynamic> myPosts;
  final int followers;
  final List<dynamic> likedPosts;
  final String userName;
  final List<dynamic> followings;
  final DocumentReference reference;

  UserModel.fromMap(Map<String, dynamic>? map, this.userKey, {required this.reference})
      : profileImg = map?[KEY_PROFILEIMG],
        email = map?[KEY_EMAIL],
        myPosts = map?[KEY_MYPOSTS],
        followers = map?[KEY_FOLLOWERS],
        likedPosts = map?[KEY_LIKEDPOSTS],
        userName = map?[KEY_USERNAME],
        followings = map?[KEY_FOLLOWINGS];

  UserModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> snapshot)
      : this.fromMap(snapshot.data(), snapshot.id, reference : snapshot.reference);

  static Map<String, dynamic> getMapForCreateUser(String email)
  {
    Map<String, dynamic> map = Map();
    map[KEY_PROFILEIMG] = "";
    map[KEY_EMAIL] = email;
    map[KEY_MYPOSTS] = [];
    map[KEY_FOLLOWERS] = 0;
    map[KEY_LIKEDPOSTS] = [];
    map[KEY_USERNAME] = email.split("@")[0];
    map[KEY_FOLLOWINGS] = [];
    return map;
  }
}