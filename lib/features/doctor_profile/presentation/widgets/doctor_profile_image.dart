import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;

import '../../../../core/constants/app_alerts/app_alerts.dart';
import '../../../../generated/assets.dart';
import 'developer_note_dialog.dart';

class DoctorProfileImage extends StatefulWidget {
  const DoctorProfileImage({super.key});

  @override
  State<DoctorProfileImage> createState() => _DoctorProfileImageState();
}

class _DoctorProfileImageState extends State<DoctorProfileImage> {
  File? _image;

  final _pickImage = ImagePicker();
  String? fakeImageUrl;

  void fetchImage(ImageSource src) async {
    final XFile? imageCapture = await _pickImage.pickImage(
      source: src,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (imageCapture != null) {
      AppAlerts.customDialog(
        context: context,
        body: const DeveloperNoteDialog(),
      );

      setState(() {
        _image = File(imageCapture.path);

        fakeImageUrl = AppStrings.images[0];
      });
    } else {
      if (kDebugMode) {
        print('');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return fakeImageUrl == null
        ? GestureDetector(
            onTap: () {
              fetchImage(ImageSource.gallery);
            },
            child: CircleAvatar(
              radius: 50.r,
              backgroundColor: Colors.grey.shade400,
              backgroundImage: fakeImageUrl == null
                  ? const AssetImage(Assets.imagesUploadProfileIcons)
                  : NetworkImage(fakeImageUrl!),
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: fakeImageUrl!,
              placeholder: (context, url) =>
                  const CircularProgressIndicator(color: Colors.white),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.scaleDown,
            ),
          );
  }
}
