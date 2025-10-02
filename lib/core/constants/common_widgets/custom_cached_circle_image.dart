import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../generated/assets.dart';

class CustomCachedCircleImage extends StatelessWidget {
  final double radius;
  final String imageUrl;

  const CustomCachedCircleImage({required this.radius,required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            border: Border.all(
              color: Colors.black12,
              width: 2,
            ),
          ),
        ),
           placeholder: (context, _) => _buildContainer(Assets.imagesLoading),
        errorWidget: (context, s, _) =>  _buildContainer(Assets.imagesError),

      ),
    );
  }

  Container _buildContainer(String image) {
    return Container(

      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black38,width: 2),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,

        ),
      ),
    );
  }
}
