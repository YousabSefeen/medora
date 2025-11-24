import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FaIcon, FontAwesomeIcons;
import 'package:medora/core/constants/app_routes/app_router.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/common_widgets/custom_error_widget.dart'
    show CustomErrorWidget;
import 'package:medora/core/constants/common_widgets/custom_shimmer.dart'
    show CustomShimmer;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/enum/navigation_source.dart' show NavigationSource;
import 'package:medora/core/extensions/string_extensions.dart';
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;

class CustomSliverAppBar extends StatelessWidget {
  final DoctorModel doctor;
  final NavigationSource navigationSource;

  const CustomSliverAppBar({
    super.key,
    required this.doctor,
    required this.navigationSource,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final deviceSize = MediaQuery.sizeOf(context);
    final deviceHeight = deviceSize.height;
    final deviceWidth = deviceSize.width;

    return SliverAppBar(
      pinned: true,
      expandedHeight: deviceHeight * 0.35,
      leading: IconButton(
        icon: CircleAvatar(
          radius: 15.r,
          backgroundColor: AppColors.customWhite,
          child: FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: AppColors.softBlue,
            size: 16.sp,
          ),
        ),
        onPressed: () => AppRouter.popWithKeyboardDismiss(context),
      ),
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final isCollapsed =
              constraints.maxHeight <=
              kToolbarHeight + MediaQuery.of(context).padding.top;

          return FlexibleSpaceBar(
            title: isCollapsed
                ? Text(
                    doctor.name,
                    style: textTheme.extraLargeWhiteBold.copyWith(
                      fontSize: 19.sp,
                      color: AppColors.darkBlue,
                    ),
                  )
                : null,
            background: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                _buildDoctorImage(deviceHeight),
                _buildDoctorName(deviceWidth, textTheme),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDoctorImage(double deviceHeight) {
    switch (navigationSource) {
      case NavigationSource.search:
        return _buildImage(deviceHeight);
      case NavigationSource.direct:
        return Hero(tag: doctor.doctorId!, child: _buildImage(deviceHeight));
    }
  }

  CachedNetworkImage _buildImage(double deviceHeight) => CachedNetworkImage(
    imageUrl: doctor.imageUrl,
    fit: BoxFit.cover,
    width: double.infinity,
    placeholder: (context, _) => _buildImagePlaceholder(deviceHeight),
    errorWidget: (context, _, __) => _buildImageError(),
  );

  CustomShimmer _buildImagePlaceholder(double deviceHeight) =>
      CustomShimmer(height: deviceHeight * 0.25, width: double.infinity);

  CustomErrorWidget _buildImageError() =>
      const CustomErrorWidget(errorMessage: AppStrings.imageNotFound);

  Container _buildDoctorName(double deviceWidth, TextTheme textTheme) =>
      Container(
        margin: const EdgeInsets.only(left: 16, bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.black54,

          borderRadius: BorderRadius.circular(8),
        ),
        constraints: BoxConstraints(maxWidth: deviceWidth * 0.52),
        child: Text(
          doctor.name.capitalizeFirstLetter(),
          style: textTheme.extraLargeWhiteBold,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      );
}
