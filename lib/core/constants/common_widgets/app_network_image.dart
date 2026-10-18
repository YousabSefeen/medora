import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:flutter/material.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/generated/assets.dart' show Assets;

class AppNetworkImage extends StatelessWidget {
  final String heroTag;
  final String imageUrl;
  final double? width;
  final double? height;
  final double? imageRadius;
  final Alignment? alignment;
  final EdgeInsetsGeometry? padding;
  final BorderSide? side;
  const AppNetworkImage({
    super.key,
    required this.heroTag,
    required this.imageUrl,
    this.width,
    this.height,
    this.imageRadius = 0,
    // 💡 محاذاة الأسفل لثبات الطبيب على القاعدة
    this.alignment = Alignment.bottomCenter,
    this.padding =const EdgeInsets.only(left: 8.0, top: 8),
    this.side=BorderSide.none,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: Hero(
        tag: heroTag,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(imageRadius!),
          child: Material(
            color: AppColors.customWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(imageRadius!),
              side:side!,
            ),
            child: CachedNetworkImage(
              alignment: alignment!,
              imageUrl: imageUrl,
              // 💡 BoxFit.contain هو السر هنا لمنع تشويه وتكبير/قص الصورة داخل الحاوية
              fit: BoxFit.contain,
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
        ),
      ),
    );
  }
}
