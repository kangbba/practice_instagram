import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practiceinsta/models/firestore/user_model.dart';

class Transformers{

  final StreamTransformer<DocumentSnapshot<Map<String,dynamic>>, UserModel> toUser = StreamTransformer<DocumentSnapshot<Map<String,dynamic>>, UserModel>.fromHandlers(
      handleData : (snapshot, sink) async{
        sink.add(UserModel.fromSnapshot(snapshot));
      }
  );


}