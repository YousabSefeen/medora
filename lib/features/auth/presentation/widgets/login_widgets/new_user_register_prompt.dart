import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_routes/app_router.dart';
import '../../../../../core/constants/app_routes/app_router_names.dart';

class NewUserRegisterPrompt extends StatelessWidget {
  const NewUserRegisterPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        children: [
          Text(
            'Don\'t have account?',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              AppRouter.pushNamed(context, AppRouterNames.register);
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
