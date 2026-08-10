import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/app_routes/app_router_names.dart';
import 'package:medora/core/enum/navigation_source.dart';
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;
import 'package:medora/features/shared/presentation/widgets/doctor_basic_info.dart'
    show DoctorBasicInfo;
import 'package:medora/features/shared/value_objects/doctor_card_config.dart'
    show DoctorCardConfig;

class DoctorCard extends StatelessWidget {
  final DoctorEntity doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: ValueKey(doctor.doctorId),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
        child: InkWell(
          highlightColor: Colors.grey,
          splashColor: Colors.grey,
          borderRadius: BorderRadius.circular(12.r),
          onTap: () => _navigatorToCreateAppointment(context),

          child: DoctorBasicInfo(
            doctor: doctor,
            config: DoctorCardConfig.defaultConfig(),
          ),
        ),
      ),
    );
  }

  void _navigatorToCreateAppointment(BuildContext context) {
    final Map<String, dynamic> extra = {
      'doctor': doctor,
      'navigationSource': NavigationSource.direct,
    };
    context.push(AppRouterNames.createAppointment, extra: extra);
  }
}
