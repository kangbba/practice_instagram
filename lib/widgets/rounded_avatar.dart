
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/common_size.dart';

class RoundedAvatar extends StatelessWidget {

  final double size;

  const RoundedAvatar({
    Key? key,
    required this.size,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: 'https://picsum.photos/id/101/100',
        width: size,
        height: size,
      ),
    );
  }
}
