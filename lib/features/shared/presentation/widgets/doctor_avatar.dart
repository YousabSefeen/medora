import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:flutter/material.dart';
import 'package:medora/core/constants/common_widgets/app_asset_image.dart'
    show AppAssetImage;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/generated/assets.dart' show Assets;

class DoctorAvatar extends StatelessWidget {
  final String heroTag;
  final String imageUrl;
  final double size;

  const DoctorAvatar({
    super.key,
    required this.heroTag,
    required this.imageUrl,
    this.size = 45.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: _buildShapeDecoration(),
      child: Hero(
        tag: heroTag,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, _) =>
                _buildAppAssetImage(Assets.imagesLoading),
            errorWidget: (context, _, _) =>
                _buildAppAssetImage(Assets.imagesError),
          ),
        ),
      ),
    );
  }

  AppAssetImage _buildAppAssetImage(String assetPath) =>
      AppAssetImage(assetPath: assetPath, width: size, height: size);

  ShapeDecoration _buildShapeDecoration() => const ShapeDecoration(
    color: AppColors.softBlue,
    shape: CircleBorder(),
    shadows: [
      BoxShadow(
        color: AppColors.softBlue,
        spreadRadius: 1,
        blurRadius: 1,
        offset: Offset(0, 1),
      ),
    ],
  );
}
