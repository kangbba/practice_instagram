
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practiceinsta/constants/firestore_keys.dart';

import '../models/firestore/user_model.dart';

class UserNetworkRepository
{

  Future<void> attemptCreateUser({required String userKey, required String email} ) async
  {
      final DocumentReference userRef = FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(userKey);
      DocumentSnapshot snapshot = await userRef.get();
      if(!snapshot.exists)
      {
        return await userRef.set(UserModel.getMapForCreateUser(email));
      }
  }


  Future<void> sendData() async
  {
    FirebaseFirestore.instance
        .collection('Users')
        .doc('123123')
        .set({'email' : 'testing@gmail.com', 'username': 'myUserName'});
  }
  void getData()
  {
    FirebaseFirestore.instance
        .collection('Users')
        .doc('123123')
        .get()
        .then((docSnapShot) => print(docSnapShot.data()));
  }
}
UserNetworkRepository userNetworkRepository = UserNetworkRepository();