import 'package:flutter/material.dart';
import 'package:medora/core/enum/navigation_source.dart' show NavigationSource;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/favorites/presentation/widgets/toggle_favorite_button.dart'
    show ToggleFavoriteButton;
import 'package:medora/features/shared/value_objects/doctor_card_config.dart'
    show DoctorCardConfig;
import 'package:medora/features/shared/widgets/doctor_image.dart'
    show DoctorImage;
import 'package:medora/features/shared/widgets/doctor_info_footer.dart'
    show DoctorInfoFooter;
import 'package:medora/features/shared/widgets/doctor_name.dart'
    show DoctorName;
import 'package:medora/features/shared/widgets/doctor_rating.dart'
    show DoctorRating;
import 'package:medora/features/shared/widgets/doctor_specialties.dart'
    show DoctorSpecialties;

class DoctorBasicInfo extends StatelessWidget {
  final NavigationSource navigationSource;
  final DoctorModel doctor;
  final DoctorCardConfig config;

  const DoctorBasicInfo({
    super.key,
    this.navigationSource = NavigationSource.direct,
    required this.doctor,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DoctorImage(
            navigationSource: navigationSource,
            imageUrl: doctor.imageUrl,
            doctorId: doctor.doctorId!,
            size: config.imageSize,
            imageRadius: config.imageRadius,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DoctorName(
                          name: doctor.name,
                          fontSize: config.nameFontSize,
                        ),
                      ),

                      Visibility(
                        visible: config.showFavoriteButton,
                        child: ToggleFavoriteButton(doctorInfo: doctor),
                      ),
                    ],
                  ),
                  DoctorSpecialties(
                    specialties: doctor.specialties,
                    fontSize: config.specialtiesFontSize,
                  ),
                  const SizedBox(height: 8),
                  DoctorRating(
                    ratingValue: 3.4,
                    iconSize: config.ratingIconSize,
                    fontSize: config.ratingFontSize,
                  ),
                  const SizedBox(height: 8),
                  DoctorInfoFooter(fee: doctor.fees, location: doctor.location),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
