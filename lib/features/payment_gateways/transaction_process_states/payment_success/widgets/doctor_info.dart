import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart' show AppStrings;
import 'package:medora/core/constants/themes/app_text_styles.dart';


class DoctorInfo extends StatelessWidget {
  final String doctorImage;
  final String doctorName;

  const DoctorInfo({super.key,  required this.doctorImage, required this.doctorName});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 25,
      children: [
        SizedBox(
          child: CircleAvatar(
            radius: 30,
            child: CachedNetworkImage(
              imageUrl: doctorImage,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        Expanded(
          child: Text(
            '${AppStrings.dR} $doctorName',
            style: Theme.of(context)
                .textTheme
                .largeBlackBold
                .copyWith(color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
