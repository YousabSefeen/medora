import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_routes/app_router.dart' show AppRouter;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/features/appointments/presentation/screens/create_appointment_screen.dart' show CreateAppointmentScreen;
import 'package:medora/features/appointments/presentation/widgets/custom_action_button.dart' show CustomActionButton;


import '../../../../core/constants/common_widgets/consultation_fee_and_wait_row.dart';
import '../../../doctor_profile/data/models/doctor_model.dart';
import 'doctor_location_display.dart';
import 'doctor_profile_header.dart';

class DoctorListView extends StatelessWidget {
  final List<DoctorModel> doctorList;

  const DoctorListView({super.key, required this.doctorList});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      sliver:   SliverList.builder(
              itemCount: doctorList.length,
        itemBuilder: (context, index) {
          final DoctorModel doctor = doctorList[index];
          return Card(
            color: AppColors.white,
            elevation: 1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: Colors.black12)),
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                DoctorProfileHeader(doctorInfo: doctor),
                DoctorLocationDisplay(location: doctor.location),
                const SizedBox(height: 5), // Added SizedBox here
                ConsultationFeeAndWaitRow(
                  fee: doctor.fees.toString(),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: CustomActionButton(
                    text: 'view Availability & Book',
                    onPressed: () => AppRouter.push(
                      context,
                      CreateAppointmentScreen(doctor: doctor),
                    ),
                    backgroundColor: AppColors.green,
                    textColor: AppColors.white,
                    borderColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}