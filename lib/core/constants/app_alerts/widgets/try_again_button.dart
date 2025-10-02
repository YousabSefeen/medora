import 'package:flutter/material.dart';

import '../../app_routes/app_router.dart';
import '../../app_strings/app_strings.dart';

class TryAgainButton extends StatelessWidget {
  final Color backgroundColor;

  const TryAgainButton({super.key, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => AppRouter.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(AppStrings.tryAgain),
      ),
    );
  }
}
