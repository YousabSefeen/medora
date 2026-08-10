import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/generated/assets.dart';

class SocialAuthButton extends StatelessWidget {
  final SvgGenImage svgGenImage;

  final VoidCallback onPressed;
  final double size;

  const SocialAuthButton({
    super.key,
    required this.svgGenImage,

    required this.onPressed,
    this.size = 22,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: IconButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: const CircleBorder(),
        ),
        child: Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: Colors.transparent,

            shape: BoxShape.circle,

            border: Border.all(color: Colors.white30, width: 1.5),
          ),
          child: svgGenImage.svg(
            width: size.r,
            height: size.r,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
