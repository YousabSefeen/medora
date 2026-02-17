import 'package:flutter/material.dart';
import 'package:medora/core/enum/navigation_source.dart';
import 'package:medora/features/appointments/presentation/widgets/book_appointment_button.dart'
    show BookAppointmentButton;
import 'package:medora/features/appointments/presentation/widgets/create_appointment_app_bar.dart';
import 'package:medora/features/appointments/presentation/widgets/create_appointment_content.dart'
    show CreateAppointmentContent;
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
      backgroundColor: Colors.grey.shade50,
      bottomNavigationBar: BookAppointmentButton(doctor: doctor),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CreateAppointmentAppBar(
              doctorId:doctor.doctorId!,
              doctorName: doctor.name,
              imageUrl:  doctor.imageUrl,
              navigationSource: navigationSource,
            ),
            CreateAppointmentContent(doctor: doctor),
          ],
        ),
      ),
    );
  }
}
