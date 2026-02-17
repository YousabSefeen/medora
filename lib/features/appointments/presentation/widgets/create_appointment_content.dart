import 'package:flutter/material.dart';
import 'package:medora/core/enum/doctor_info_variant.dart'
    show DoctorInfoVariant;
import 'package:medora/features/appointments/presentation/widgets/doctor_appointment_booking_section.dart'
    show DoctorAppointmentBookingSection;
import 'package:medora/features/appointments/presentation/widgets/doctor_info_header.dart'
    show DoctorInfoHeader;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;
import 'package:medora/features/shared/models/doctor_schedule_model.dart'
    show DoctorScheduleModel;
import 'package:medora/features/shared/presentation/widgets/doctor_info_footer.dart'
    show DoctorInfoFooter;

class CreateAppointmentContent extends StatelessWidget {
  final DoctorEntity doctor;

  const CreateAppointmentContent({super.key, required this.doctor});

  static const _horizontalPadding = 8.0;
  static const _smallSpacing = 5.0;
  static const _mediumSpacing = 20.0;
  static const _dividerPadding = 10.0;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: _smallSpacing),
            DoctorInfoHeader(
              specialties: doctor.specialties,
              bio: doctor.bio,
              workingDays: doctor.doctorAvailability.workingDays,
            ),
            const SizedBox(height: _mediumSpacing),
            DoctorInfoFooter(
              variant: DoctorInfoVariant.details,
              fee: doctor.fees,
              location: doctor.location,
            ),
            _buildDivider(),
            DoctorAppointmentBookingSection(
              doctorSchedule: DoctorScheduleModel(
                doctorId: doctor.doctorId!,
                doctorAvailability: doctor.doctorAvailability,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() => const Padding(
    padding: EdgeInsets.symmetric(vertical: _dividerPadding),
    child: Divider(
      color: Colors.black12,
      thickness: 2,
      indent: _dividerPadding,
      endIndent: _dividerPadding,
    ),
  );
}
