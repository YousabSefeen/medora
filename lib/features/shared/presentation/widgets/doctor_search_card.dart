import 'package:flutter/material.dart';
import 'package:medora/core/enum/navigation_source.dart' show NavigationSource;
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart' show DoctorEntity;
import 'package:medora/features/shared/presentation/widgets/doctor_basic_info.dart'
    show DoctorBasicInfo;
import 'package:medora/features/shared/value_objects/doctor_card_config.dart'
    show DoctorCardConfig;

class DoctorSearchCard extends StatelessWidget {
  final DoctorEntity doctor;

  const DoctorSearchCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: DoctorBasicInfo(
        navigationSource: NavigationSource.search,
        doctor: doctor,
        config: const DoctorCardConfig(
          imageSize: 50,
          imageRadius: 360,
          showFavoriteButton: false,
          nameFontSize: 14,
          specialtiesFontSize: 10,
          ratingIconSize: 14,
          ratingFontSize: 10,
        ),
      ),
    );
  }
}
