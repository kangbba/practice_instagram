import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practiceinsta/models/firestore/user_model.dart';

class Transformers{

  final toUser = StreamTransformer<DocumentSnapshot<dynamic>, UserModel>.fromHandlers(
      handleData : (snapshot, sink) async{
        sink.add(UserModel.fromSnapshot(snapshot));
      }
  );


}