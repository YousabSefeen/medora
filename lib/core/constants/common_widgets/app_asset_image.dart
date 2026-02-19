


import 'package:flutter/material.dart';


class AppAssetImage extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;


  const AppAssetImage({super.key, required this.assetPath, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      fit: BoxFit.cover,
      width: width,
      height: height,
    );
  }
}
