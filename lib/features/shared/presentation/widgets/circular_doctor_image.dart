import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:flutter/material.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;

class CircularDoctorImage extends StatelessWidget {
  final String imageUrl;
  final double size;

  const CircularDoctorImage({
    super.key,
    required this.imageUrl,
    this.size = 45.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: const ShapeDecoration(
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
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          errorWidget: (context, url, error) => const Icon(Icons.person),
        ),
      ),
    );
  }
}
