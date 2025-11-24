import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:flutter/material.dart';
import 'package:medora/core/constants/common_widgets/custom_shimmer.dart'
    show CustomShimmer;
import 'package:medora/core/enum/navigation_source.dart' show NavigationSource;
import 'package:medora/generated/assets.dart' show Assets;

class DoctorImage extends StatelessWidget {
  final NavigationSource navigationSource;
  final String imageUrl;
  final String doctorId;
  final double size;
  final double imageRadius;

  const DoctorImage({
    super.key,
    required this.navigationSource,
    required this.imageUrl,
    required this.doctorId,
    required this.size,
    required this.imageRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(imageRadius),
      ),
      child: _buildImageWithRouteContext(),
    );
  }

  Widget _buildImageWithRouteContext() {
    switch (navigationSource) {
      case NavigationSource.search:
        return _buildImage();
      case NavigationSource.direct:
        return _buildImageWithHero();
    }
  }

  Hero _buildImageWithHero() =>
      Hero(tag: doctorId, child: _buildImage());

  ClipRRect _buildImage() => ClipRRect(
    borderRadius: BorderRadius.circular(imageRadius),
    child: CachedNetworkImage(
      imageUrl: imageUrl,
      width: size,
      height: size,
      fit: BoxFit.cover,
      placeholder: (context, url) => CustomShimmer(height: size, width: size),
      errorWidget: (context, url, error) => Image.asset(
        Assets.imagesErrorImage,
        fit: BoxFit.cover,
        width: size,
        height: size,
      ),
    ),
  );
}
