import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FaIcon, FontAwesomeIcons;
import 'package:medora/core/constants/app_routes/app_router.dart';
import 'package:medora/core/constants/common_widgets/app_network_image.dart'
    show AppNetworkImage;
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
                _buildImage(heroTag: doctorId, imageUrl: imageUrl),
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

  AppNetworkImage _buildImage({
    required String heroTag,
    required String imageUrl,
  }) => AppNetworkImage(
    heroTag: heroTag,
    imageUrl: imageUrl,
    width: double.infinity,
  );

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
