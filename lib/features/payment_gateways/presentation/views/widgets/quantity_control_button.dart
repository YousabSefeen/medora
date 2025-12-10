import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuantityControlButton extends StatelessWidget {
  final void Function() onPressed;
  final IconData icon;
  final bool? isDeleteButton;

  const QuantityControlButton({
    super.key,
    this.isDeleteButton = false,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDelete = isDeleteButton == true;
    return SizedBox(
      height: 30,
      width: 30,
      child: IconButton(
        onPressed: onPressed,
        icon: FaIcon(icon, size: isDeleteButton == true ? 22.sp : 18.sp),
        style: ButtonStyle(
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          alignment: Alignment.center,
          backgroundColor: WidgetStatePropertyAll(
            isDelete ? null : Colors.black,
          ),
          foregroundColor: WidgetStatePropertyAll(
            isDelete ? Colors.red : Colors.white,
          ),
          overlayColor: WidgetStatePropertyAll(
            isDelete ? Colors.redAccent : Colors.white,
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          ),
        ),
      ),
    );
  }
}
