import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavTab extends StatelessWidget {
  const BottomNavTab({
    super.key,
    required this.iconData,
    required this.title,
    required this.isActive,
  });

  final IconData iconData;
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 2,
        children: [
          !isActive
              ? CircleAvatar(
                  backgroundColor: Colors.black26,
                  radius: 15.r,
                  child: Icon(
                    iconData,
                    color: Colors.white,
                    size: 15.sp,
                  ))
              : Icon(
                  iconData,
                  color: Colors.white,
                  size: 18.sp,
                ),
          !isActive
              ? const SizedBox.shrink()
              : Expanded(
                  child: FittedBox(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
