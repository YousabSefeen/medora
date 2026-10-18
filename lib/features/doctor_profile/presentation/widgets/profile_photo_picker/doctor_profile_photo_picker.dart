import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medora/core/animations/custom_animated_expansion_tile.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart';
import 'package:medora/core/constants/app_duration/app_duration.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/theme_extension.dart';
import 'package:medora/features/doctor_profile/presentation/controller/cubit/doctor_profile_cubit.dart';
import 'package:medora/features/doctor_profile/presentation/controller/states/doctor_profile_state.dart';
import 'package:medora/generated/assets.dart';

class DoctorProfilePhotoPicker extends StatelessWidget {
  const DoctorProfilePhotoPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DoctorProfileCubit, DoctorProfileState, String>(
      selector: (state) => state.pickedImagePath,
      builder: (context, pickedImagePath) {
        if (pickedImagePath.isNotEmpty) {
          return _buildImageCard(context, pickedImagePath);
        } else {
          return _buildUploaderCard(context);
        }
      },
    );
  }

  Widget _buildImageCard(BuildContext rootContext, String path) =>
      GestureDetector(
        onTap: () => _showPhotoOptionsBottomSheet(rootContext),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _ProfileImageFrame(
              child: Image.file(
                File(path),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            _buildEditPhotoIcon(),
          ],
        ),
      );

  Positioned _buildEditPhotoIcon() => Positioned(
    bottom: 10,
    right: 10,
    child: CircleAvatar(
      radius: 12.r,
      backgroundColor: AppColors.white,
      child: FaIcon(
        FontAwesomeIcons.solidPenToSquare,
        size: 13.sp,
        color: Colors.black87,
      ),
    ),
  );

  Widget _buildUploaderCard(BuildContext context) => GestureDetector(
    onTap: () => _pickAndProcessImage(context, ImageSource.gallery),
    child: _ProfileImageFrame(child: Assets.images.uploadProfileIcons.image()),
  );

  // ==================== Bottom Sheet Logic ====================

  void _showPhotoOptionsBottomSheet(BuildContext rootContext) {
    // Capture the Cubit from the main screen to scroll through later

    final cubit = rootContext.read<DoctorProfileCubit>();

    AppAlerts.showCustomBottomSheet(
      context: rootContext,
      appBarBackgroundColor: Colors.white,
      appBarTitle: AppStrings.profilePhotoOptionsTitle,
      appBarTitleColor: Colors.black,
      body: BlocProvider.value(
        value: cubit,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildExpansionChangePhoto(rootContext),
              _buildListTile(
                context: rootContext,
                title: AppStrings.editPhoto,
                leadingIcon: FontAwesomeIcons.cropSimple,
                leadingIconColor: AppColors.softBlue,
                trailingIcon: FontAwesomeIcons.chevronRight,
                onTap: () {
                  rootContext.pop();
                  _cropImage(rootContext, cubit.state.originalImagePath);
                },
              ),
              _buildListTile(
                context: rootContext,
                title: AppStrings.removePhoto,
                leadingIcon: FontAwesomeIcons.trashCan,
                leadingIconColor: AppColors.red,
                trailingIcon: FontAwesomeIcons.chevronRight,
                onTap: () {
                  cubit.clearAllPhotos();
                  rootContext.pop();
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpansionChangePhoto(
    BuildContext rootContext,
  ) => BlocSelector<DoctorProfileCubit, DoctorProfileState, bool>(
    selector: (state) => state.isChangePhotoExpanded,
    builder: (bottomSheetContext, isExpanded) => CustomAnimatedExpansionTile(
      duration: AppDurations.milliseconds_300,
      baseChild: _buildListTile(
        context: bottomSheetContext,
        isChange: true,
        title: AppStrings.changePhoto,
        leadingIcon: FontAwesomeIcons.arrowsRotate,
        leadingIconColor: Colors.black54,
        onTap: () => _toggleChangePhotoExpanded(bottomSheetContext),
      ),
      isExpanded: isExpanded,
      onTap: () => _toggleChangePhotoExpanded(bottomSheetContext),
      child: !isExpanded
          ? const SizedBox()
          : Column(
              children: [
                _buildListTile(
                  context: bottomSheetContext,
                  title: AppStrings.camera,
                  leadingIcon: FontAwesomeIcons.camera,
                  leadingIconColor: AppColors.softBlue,
                  onTap: () {
                    bottomSheetContext.pop();
                    _pickAndProcessImage(rootContext, ImageSource.camera);
                  },
                ),
                _buildListTile(
                  context: bottomSheetContext,
                  title: AppStrings.gallery,
                  leadingIcon: FontAwesomeIcons.image,
                  leadingIconColor: AppColors.softBlue,
                  onTap: () {
                    bottomSheetContext.pop();
                    _pickAndProcessImage(rootContext, ImageSource.gallery);
                  },
                ),
                const Divider(
                  color: Colors.black38,
                  indent: 10,
                  endIndent: 10,
                  thickness: 1,
                ),
              ],
            ),
    ),
  );

  void _toggleChangePhotoExpanded(BuildContext bottomSheetContext) =>
      bottomSheetContext.read<DoctorProfileCubit>().toggleChangePhotoExpanded();

  ListTile _buildListTile({
    required BuildContext context,
    bool isChange = false,
    required String title,
    required FaIconData leadingIcon,
    required Color leadingIconColor,
    FaIconData? trailingIcon,
    required VoidCallback onTap,
  }) => ListTile(
    contentPadding: isChange
        ? EdgeInsets.zero
        : const EdgeInsets.only(left: 5, right: 10),
    leading: FaIcon(leadingIcon, size: 18.sp, color: leadingIconColor),
    title: Text(title, style: context.textTheme.styleInputField),
    trailing: trailingIcon != null ? FaIcon(trailingIcon, size: 18.sp) : null,
    onTap: onTap,
  );

  // ==================== Core Logic (Picker & Cropper) ====================

  Future<void> _pickAndProcessImage(
    BuildContext context,
    ImageSource source,
  ) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 80,
    );
    if (pickedFile != null && context.mounted) {
      final cubit = context.read<DoctorProfileCubit>();

      cubit.updateOriginalImagePath(pickedFile.path);

      await _cropImage(context, pickedFile.path);
    }
  }

  Future<void> _cropImage(BuildContext context, String sourcePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: sourcePath,
      compressQuality: 80,
      aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 4),
      compressFormat: ImageCompressFormat.jpg,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Doctor Photo',
          toolbarColor: AppColors.black,
          toolbarWidgetColor: AppColors.white,
          initAspectRatio: CropAspectRatioPreset.ratio4x3,
          lockAspectRatio: true,
          hideBottomControls: true,
          aspectRatioPresets: [CropAspectRatioPreset.ratio4x3],
        ),
        IOSUiSettings(
          title: 'Crop Doctor Photo',
          aspectRatioPickerButtonHidden: true,
          resetAspectRatioEnabled: false,
          aspectRatioPresets: [CropAspectRatioPreset.ratio4x3],
        ),
        WebUiSettings(
          context: context,
          size: const CropperSize(width: 600, height: 800),
        ),
      ],
    );

    if (croppedFile != null && context.mounted) {
      context.read<DoctorProfileCubit>().updatePickedImagePath(
        croppedFile.path,
      );
    }
  }
}

// ==================== Custom Configurations ====================

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}

class _ProfileImageFrame extends StatelessWidget {
  final Widget child;
  final double size;
  final Color borderColor;

  const _ProfileImageFrame({
    super.key,
    required this.child,
    this.size = 110.0,
    this.borderColor = AppColors.black26,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: child,
        ),
      ),
    );
  }
}
