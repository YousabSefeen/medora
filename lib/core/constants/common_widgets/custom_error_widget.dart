import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_text_styles.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;

  final Color headerColor;
  final Color iconColor;
  final EdgeInsetsGeometry margin;

  const CustomErrorWidget({
    super.key,
    required this.errorMessage,
    this.headerColor = Colors.red,
    this.iconColor = Colors.white,
    this.margin = const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
  });

  final _radiusValue = 8.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: margin.horizontal.w,
          vertical: margin.vertical.h,
        ),
        decoration: _buildErrorBoxDecoration(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildErrorHeader(context),
            _buildErrorMessageContent(context),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildErrorBoxDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(_radiusValue.r),
      color: Theme.of(context).cardColor,
      border: Border.all(color: headerColor),
    );
  }

  Widget _buildErrorHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_radiusValue.r),
          topRight: Radius.circular(_radiusValue.r),
        ),
        color: headerColor,
      ),
      child: Row(
        spacing: 3,
        children: [
          Icon(Icons.error, size: 25.sp, color: iconColor),
          _buildErrorTitle(context),
        ],
      ),
    );
  }

  Widget _buildErrorTitle(BuildContext context) {
    return Expanded(
      child: FittedBox(
        child: Text(
          AppStrings.errorDisplayTitle,
          style: Theme.of(
            context,
          ).textTheme.mediumBlack.copyWith(color: iconColor),
        ),
      ),
    );
  }

  Widget _buildErrorMessageContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: RichText(
        text: TextSpan(
          children: [
            _buildErrorLabelTextSpan(context),
            _buildErrorMessageTextSpan(context),
          ],
        ),
      ),
    );
  }

  TextSpan _buildErrorLabelTextSpan(BuildContext context) {
    return TextSpan(
      text: AppStrings.errorMessageLabel,
      style: Theme.of(context).textTheme.mediumBlack.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  TextSpan _buildErrorMessageTextSpan(BuildContext context) {
    return TextSpan(
      text: errorMessage,
      style: Theme.of(
        context,
      ).textTheme.hintFieldStyle.copyWith(fontSize: 16.sp, letterSpacing: 1.5),
    );
  }
}
