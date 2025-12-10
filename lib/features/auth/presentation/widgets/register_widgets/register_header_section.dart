import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_routes/app_router.dart';
import '../auth_header.dart';

class RegisterHeaderSection extends StatelessWidget {
  const RegisterHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.3,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_RegisterBackButton(), AuthHeader(isLogin: false)],
      ),
    );
  }
}

class _RegisterBackButton extends StatelessWidget {
  const _RegisterBackButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppRouter.pop(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        margin: const EdgeInsets.only(top: 15, bottom: 2, left: 10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 1.5),
        ),
        child: Icon(Icons.arrow_back_ios_new, size: 15.sp, color: Colors.white),
      ),
    );
  }
}
