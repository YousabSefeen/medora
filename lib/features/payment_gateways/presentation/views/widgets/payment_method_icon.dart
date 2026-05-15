import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
import 'package:medora/core/extensions/media_query_extension.dart' show MediaQueryExtension;

class PaymentMethodIcon extends StatelessWidget {
  final ImageProvider imageProvider;

  const PaymentMethodIcon({super.key, required this.imageProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: context.screenWidth * 0.15,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        color: Colors.white,
        image: DecorationImage(fit: BoxFit.fill, image: imageProvider),
        shadows: const [
          BoxShadow(color: Colors.white, blurRadius: 2, spreadRadius: 4),
        ],
      ),
    );
  }
}
