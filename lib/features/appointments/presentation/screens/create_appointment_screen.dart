import 'package:flutter/material.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/enum/navigation_source.dart';
import 'package:medora/features/appointments/presentation/widgets/create_appointment_app_bar.dart';
import 'package:medora/features/appointments/presentation/widgets/create_appointment_content.dart';
import 'package:medora/features/appointments/presentation/widgets/create_appointment_footer_actions.dart';
import 'package:medora/features/shared/domain/entities/doctor_entity.dart';

class CreateAppointmentScreen extends StatelessWidget {
  final DoctorEntity doctor;
  final NavigationSource navigationSource;

  const CreateAppointmentScreen({
    super.key,
    required this.doctor,
    this.navigationSource = NavigationSource.direct,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      persistentFooterButtons: [CreateAppointmentFooterActions(doctor: doctor)],
      persistentFooterDecoration: _buildBoxDecoration(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CreateAppointmentAppBar(
              doctorId: doctor.doctorId!,
              doctorName: doctor.name,
              imageUrl: doctor.imageUrl,
              navigationSource: navigationSource,
            ),

            CreateAppointmentContent(doctor: doctor),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: AppColors.black12,
        spreadRadius: 2,
        blurRadius: 4,
        offset: Offset(0, 3),
      ),
    ],
  );
}
