import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FaIcon, FontAwesomeIcons;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medora/core/animations/custom_animated_expansion_tile.dart'
    show CustomAnimatedExpansionTile;
import 'package:medora/core/constants/app_alerts/app_alerts.dart';
import 'package:medora/core/constants/app_duration/app_duration.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart' show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart'
    show AppTextStyles;
import 'package:medora/core/extensions/theme_extension.dart';
import 'package:medora/features/doctor_profile/presentation/controller/cubit/doctor_profile_cubit.dart'
    show DoctorProfileCubit;
import 'package:medora/features/doctor_profile/presentation/controller/states/doctor_profile_state.dart'
    show DoctorProfileState;
import 'package:medora/features/doctor_profile/presentation/widgets/profile_photo_picker/profile_image_frame.dart';
import 'package:medora/generated/assets.dart';

/*class DoctorProfilePhotoPicker extends StatelessWidget {
  const DoctorProfilePhotoPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
      builder: (rootContext, state) {
        return _buildBody(rootContext, state);
      },
    );
  }

  Widget _buildBody(BuildContext context, DoctorProfileState state) {
    if (state.pickedImagePath.isNotEmpty) {
      return _buildImageCard(context, state);
    } else {
      return _buildUploaderCard(context);
    }
  }

  Widget _buildImageCard(BuildContext rootContext, DoctorProfileState state) {
    final cubit = rootContext.read<DoctorProfileCubit>();

    return GestureDetector(
      onTap: () {
        AppAlerts.showCustomBottomSheet(
          context: rootContext,
          appBarBackgroundColor: Colors.white,
          appBarTitle: 'Edit Photo',
          appBarTitleColor: Colors.black,
          body: BlocProvider.value(
            value: cubit,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  BlocSelector<DoctorProfileCubit, DoctorProfileState, bool>(
                    selector: (state) => state.isChangePhotoExpanded,
                    builder: (bottomSheetContext, isExpanded) =>
                        CustomAnimatedExpansionTile(
                          duration: AppDurations.milliseconds_300,
                          baseChild: _buildListTile(
                            context: bottomSheetContext,
                            isChange: true,
                            title: 'Change Photo',
                            leadingIcon: FontAwesomeIcons.arrowsRotate,
                            leadingIconColor: Colors.black54,
                            onTap: () {
                              bottomSheetContext
                                  .read<DoctorProfileCubit>()
                                  .toggleChangePhotoExpanded();
                            },
                          ),
                          isExpanded: isExpanded,
                          onTap: () {
                            bottomSheetContext
                                .read<DoctorProfileCubit>()
                                .toggleChangePhotoExpanded();
                          },
                          child: !isExpanded
                              ? const SizedBox()
                              : Column(
                                  children: [
                                    _buildListTile(
                                      context: bottomSheetContext,
                                      title: 'Camera',
                                      leadingIcon: FontAwesomeIcons.camera,
                                      leadingIconColor: AppColors.softBlue,
                                      onTap: () {
                                        Navigator.pop(bottomSheetContext);
                                        // تمرير الـ rootContext لحل المشكلة رقم 1
                                        _pickAndProcessImage(
                                          rootContext,
                                          ImageSource.camera,
                                        );
                                      },
                                    ),
                                    _buildListTile(
                                      context: bottomSheetContext,
                                      title: 'Gallery',
                                      leadingIcon: FontAwesomeIcons.image,
                                      leadingIconColor: AppColors.softBlue,
                                      onTap: () {
                                        Navigator.pop(bottomSheetContext);
                                        // تمرير الـ rootContext لحل المشكلة رقم 1
                                        _pickAndProcessImage(
                                          rootContext,
                                          ImageSource.gallery,
                                        );
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
                  ),
                  _buildListTile(
                    context: rootContext,
                    title: 'Edit Photo',
                    leadingIcon: FontAwesomeIcons.cropSimple,
                    leadingIconColor: AppColors.softBlue,
                    trailingIcon: FontAwesomeIcons.chevronRight,
                    onTap: () {
                      Navigator.pop(rootContext);
                      // لحل المشكلة رقم 2: نمرر الصورة الأصلية المخزنة للـ Cropper وليس المقصوصة
                      _cropImage(rootContext, state.originalImagePath);
                    },
                  ),
                  _buildListTile(
                    context: rootContext,
                    title: 'Remove Photo',
                    leadingIcon: FontAwesomeIcons.trashCan,
                    leadingIconColor: AppColors.red,
                    trailingIcon: FontAwesomeIcons.chevronRight,
                    onTap: () {
                      cubit.clearAllPhotos();
                      Navigator.pop(rootContext);
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ProfileImageFrame(
            child: Image.file(File(state.pickedImagePath), fit: BoxFit.cover),
          ),
          _buildEditPhotoIcon(),
        ],
      ),
    );
  }

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
    child: ProfileImageFrame(child: Assets.images.uploadProfileIcons.image()),
  );

  // دالة التقاط الصور المعدلة
  Future<void> _pickAndProcessImage(
    BuildContext context,
    ImageSource source,
  ) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null && context.mounted) {
      final cubit = context.read<DoctorProfileCubit>();
      // حفظ الصورة الأصلية الجديدة في الـ State فور التقاطها وقبل عملية القص
      cubit.updateOriginalImagePath(pickedFile.path);

      // توجيه الصورة للقص
      _cropImage(context, pickedFile.path);
    }
  }

  // دالة القص المحدثة
  Future<void> _cropImage(BuildContext context, String sourcePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: sourcePath,
      compressQuality: 100,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: AppColors.black,
          toolbarWidgetColor: AppColors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPresetCustom(),
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPresetCustom(),
          ],
        ),
        WebUiSettings(
          context: context,
          size: const CropperSize(width: 520, height: 520),
        ),
      ],
    );

    if (croppedFile != null && context.mounted) {
      // تحديث الصورة المقصوصة المعروضة فقط
      context.read<DoctorProfileCubit>().updatePickedImagePath(
        croppedFile.path,
      );
    }
  }

  ListTile _buildListTile({
    required BuildContext context,
    bool isChange = false,
    required String title,
    required IconData leadingIcon,
    required Color leadingIconColor,
    IconData? trailingIcon,
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
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}*/

class DoctorProfilePhotoPicker extends StatelessWidget {
  const DoctorProfilePhotoPicker({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. استخدام BlocSelector لتحسين الأداء (يستمع فقط لتغير مسار الصورة)
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

  // ==================== UI Builder Methods ====================

  Widget _buildImageCard(BuildContext rootContext, String path) =>
      GestureDetector(
        onTap: () => _showPhotoOptionsBottomSheet(rootContext),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            ProfileImageFrame(child: Image.file(File(path), fit: BoxFit.cover)),
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
    child: ProfileImageFrame(child: Assets.images.uploadProfileIcons.image()),
  );

  // ==================== Bottom Sheet Logic ====================

  void _showPhotoOptionsBottomSheet(BuildContext rootContext) {
    // التقاط الـ Cubit من الشاشة الرئيسية لتمريره لاحقاً
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
                title:  AppStrings.editPhoto,
                leadingIcon: FontAwesomeIcons.cropSimple,
                leadingIconColor: AppColors.softBlue,
                trailingIcon: FontAwesomeIcons.chevronRight,
                onTap: () {
                  Navigator.pop(rootContext);
                  _cropImage(rootContext, cubit.state.originalImagePath);
                },
              ),
              _buildListTile(
                context: rootContext,
                title:AppStrings.removePhoto ,
                leadingIcon: FontAwesomeIcons.trashCan,
                leadingIconColor: AppColors.red,
                trailingIcon: FontAwesomeIcons.chevronRight,
                onTap: () {
                  cubit.clearAllPhotos();
                  Navigator.pop(rootContext);
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
                  title:  AppStrings.camera,
                  leadingIcon: FontAwesomeIcons.camera,
                  leadingIconColor: AppColors.softBlue,
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                    _pickAndProcessImage(rootContext, ImageSource.camera);
                  },
                ),
                _buildListTile(
                  context: bottomSheetContext,
                  title: AppStrings.gallery,
                  leadingIcon: FontAwesomeIcons.image,
                  leadingIconColor: AppColors.softBlue,
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
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

  // ==================== Helper Methods & Shared UI ====================

  ListTile _buildListTile({
    required BuildContext context,
    bool isChange = false,
    required String title,
    required IconData leadingIcon,
    required Color leadingIconColor,
    IconData? trailingIcon,
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
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null && context.mounted) {
      final cubit = context.read<DoctorProfileCubit>();

      cubit.updateOriginalImagePath(pickedFile.path);

      await _cropImage(context, pickedFile.path);
    }
  }

  Future<void> _cropImage(BuildContext context, String sourcePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: sourcePath,
      compressQuality: 100,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: AppColors.black,
          toolbarWidgetColor: AppColors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPresetCustom(),
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPresetCustom(),
          ],
        ),
        WebUiSettings(
          context: context,
          size: const CropperSize(width: 520, height: 520),
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
