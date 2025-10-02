import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart' show AppStrings;
import 'package:medora/core/constants/common_widgets/custom_error_widget.dart' show CustomErrorWidget;
import 'package:medora/core/constants/common_widgets/custom_shimmer.dart' show CustomShimmer;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/list_string_extension.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String doctorName;
  final List<String> specialties;
  final String doctorImage;

  const CustomSliverAppBar(
      {super.key,
      required this.doctorName,
      required this.doctorImage,
      required this.specialties});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final deviceSize = MediaQuery.sizeOf(context);
    final deviceHeight = deviceSize.height;
    final deviceWidth = deviceSize.height;
    return SliverAppBar(
      pinned: true,
      expandedHeight: deviceHeight * 0.3,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final isCollapsed = constraints.maxHeight <=
              kToolbarHeight + MediaQuery.of(context).padding.top;

          return FlexibleSpaceBar(
            title: isCollapsed
                ? Text(
                    doctorName,
                    style: textTheme.extraLargeWhiteBold.copyWith(
                      fontSize: 19.sp,
                      color: AppColors.darkBlue
                    ),
                  )
                : null,
            background: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                CachedNetworkImage(
                  imageUrl: doctorImage,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  placeholder: (context, _) => CustomShimmer(
                      height: deviceHeight * 0.25, width: double.infinity),
                  errorWidget: (context, _, __) =>
                      const CustomErrorWidget(errorMessage: AppStrings.imageNotFound),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, bottom: 15),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: BoxConstraints(
                    maxWidth: deviceWidth * 0.52,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(doctorName, style: textTheme.extraLargeWhiteBold),
                      Text(specialties.buildJoin(), style: textTheme.largeWhiteSemiBold.copyWith(
                        fontSize: 15.sp,

                      )),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }


}
