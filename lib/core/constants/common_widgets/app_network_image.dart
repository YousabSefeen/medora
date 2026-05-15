import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:flutter/material.dart';
import 'package:medora/generated/assets.dart' show Assets;

class AppNetworkImage extends StatelessWidget {
  final String heroTag;
  final String imageUrl;
  final double? width;
  final double? height;
  final double? imageRadius;
  final Alignment? alignment;

  const AppNetworkImage({
    super.key,
    required this.heroTag,
    required this.imageUrl,
    this.width,
    this.height,
    this.imageRadius = 0,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(imageRadius!),
        child: CachedNetworkImage(
          alignment: alignment!,
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          width: width,
          height: height,
          placeholder: (context, _) => Assets.images.loading.image(
            fit: BoxFit.cover,
            width: width,
            height: height,
          ),
          errorWidget: (context, _, _) => Assets.images.error.image(
            fit: BoxFit.cover,
            width: width,
            height: height,
          ),
        ),
      ),
    );
  }
}
