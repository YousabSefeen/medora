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
import 'package:medora/core/extensions/media_query_extension.dart';
import 'package:medora/core/extensions/string_extensions.dart';

class CreateAppointmentAppBar extends StatelessWidget {
  final String doctorId;
  final String imageUrl;
  final String doctorName;
  final NavigationSource navigationSource;

  const CreateAppointmentAppBar({
    super.key,
    required this.doctorId,
    required this.imageUrl,
    required this.doctorName,
    required this.navigationSource,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: context.screenHeight * 0.35,
      leading: _buildBackIcon(context),
      flexibleSpace: _FlexibleAppBarContent(
        doctorId: doctorId,
        doctorName: doctorName,

        imageUrl: imageUrl,
        navigationSource: navigationSource,
      ),
    );
  }

  IconButton _buildBackIcon(BuildContext context) => IconButton(
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
  );
}

class _FlexibleAppBarContent extends StatelessWidget {
  final String doctorId;
  final String imageUrl;
  final String doctorName;
  final NavigationSource navigationSource;

  const _FlexibleAppBarContent({
    required this.doctorId,
    required this.imageUrl,
    required this.doctorName,
    required this.navigationSource,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isCollapsed =
            constraints.maxHeight <=
            kToolbarHeight + MediaQuery.of(context).padding.top;

        return FlexibleSpaceBar(
          title: isCollapsed
              ? Text(
                  doctorName,
                  style: Theme.of(context).textTheme.extraLargeWhiteBold
                      .copyWith(fontSize: 19.sp, color: AppColors.darkBlue),
                )
              : null,
          background: Container(
            decoration: BoxDecoration(
              color: AppColors.customWhite,

              border: Border.all(color: Colors.black12, width: 0.5),
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                _buildDoctorImage(doctorId: doctorId, imageUrl: imageUrl),
                Positioned(
                  bottom: 0,
                  left: 5,
                  child: _buildDoctorName(doctorName),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDoctorImage({
    required String doctorId,
    required String imageUrl,
  }) {
    switch (navigationSource) {
      case NavigationSource.search:
        return _buildImage(imageUrl);
      case NavigationSource.direct:
        return Hero(tag: doctorId, child: _buildImage(imageUrl));
    }
  }

  CachedNetworkImage _buildImage(String imageUrl) => CachedNetworkImage(
    imageUrl: imageUrl,
    fit: BoxFit.cover,
    width: double.infinity,
    placeholder: (context, _) => _buildImagePlaceholder(),
    errorWidget: (context, _, __) => _buildImageError(),
  );

  CustomShimmer _buildImagePlaceholder() =>
      const CustomShimmer(height: 100, width: double.infinity);

  CustomErrorWidget _buildImageError() =>
      const CustomErrorWidget(errorMessage: AppStrings.imageNotFound);

  Builder _buildDoctorName(String doctorName) => Builder(
    builder: (context) => Container(
      margin: const EdgeInsets.only(left: 16, bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.black54,

        borderRadius: BorderRadius.circular(8),
      ),
      constraints: BoxConstraints(maxWidth: context.screenWidth * 0.52),
      child: Text(
        doctorName.toCapitalizeFirstLetter(),
        style: Theme.of(context).textTheme.extraLargeWhiteBold,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}
