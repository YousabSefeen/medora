import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/enum/navigation_source.dart' show NavigationSource;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;
import 'package:medora/features/shared/presentation/widgets/doctor_basic_info.dart'
    show DoctorBasicInfo;
import 'package:medora/features/shared/value_objects/doctor_card_config.dart'
    show DoctorCardConfig;

class HomeSearchDoctorCard extends StatelessWidget {
  final DoctorEntity doctor;

  const HomeSearchDoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: DoctorBasicInfo(
        navigationSource: NavigationSource.search,
        doctor: doctor,
        config: DoctorCardConfig.homeSearchDoctorCardConfig(),
      ),
    );
  }
}
