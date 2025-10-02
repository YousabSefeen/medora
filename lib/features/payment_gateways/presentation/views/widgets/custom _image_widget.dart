import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomImageWidget extends StatelessWidget {
  final String image;

  const CustomImageWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: ShapeDecoration(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          color: Colors.white,
          image: DecorationImage(fit: BoxFit.fill, image: AssetImage(image)),
          shadows: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 2,
              spreadRadius: 4,
            )
          ]),
      width: MediaQuery.sizeOf(context).width * 0.15,
    );
  }
}
