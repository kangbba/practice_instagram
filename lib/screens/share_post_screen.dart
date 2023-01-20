import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class SharePostScreen extends StatelessWidget {

  const SharePostScreen(this.file, {Key? key}) : super(key: key);
  final File file;

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
