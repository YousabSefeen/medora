import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:flutter/material.dart';
import 'package:medora/core/constants/common_widgets/app_asset_image.dart'
    show AppAssetImage;
import 'package:medora/generated/assets.dart' show Assets;

class AppNetworkImage extends StatelessWidget {
  final String heroTag;
  final String imageUrl;
  final double? width;
  final double? height;
  final double? imageRadius;

  const AppNetworkImage({
    super.key,
    required this.heroTag,
    required this.imageUrl,
    this.width,
    this.height,
    this.imageRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(imageRadius!),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          width: width,
          height: height,
          placeholder: (context, _) =>
              _buildAppAssetImage(Assets.imagesLoading),
          errorWidget: (context, _, _) =>
              _buildAppAssetImage(Assets.imagesError),
        ),
      ),
    );
  }

  AppAssetImage _buildAppAssetImage(String assetPath) =>
      AppAssetImage(assetPath: assetPath, width: width, height: height);
}
