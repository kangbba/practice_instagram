import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class SharePostScreen extends StatelessWidget {

  const SharePostScreen(this.file, {Key? key, required this.postKey}) : super(key: key);
  final File file;
  final String postKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        ),
        body: Align(
            alignment: Alignment.center,
            child: Image.file(file)
        )
    );
  }
}
