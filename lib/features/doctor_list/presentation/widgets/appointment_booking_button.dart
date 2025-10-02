// import 'package:flutter/material.dart';
// import 'package:flutter_task/core/constants/app_alerts/app_alerts.dart';
//
// import '../../../../core/constants/themes/app_colors.dart';
// import '../../../appointments/presentation/widgets/doctor_booking_availability_dialog.dart';
//
//
// class AppointmentBookingButton extends StatelessWidget {
//   final String doctorId;
//
//   const AppointmentBookingButton({super.key, required this.doctorId});
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.only(bottom: 5),
//       child: ElevatedButton(
//         style: ButtonStyle(
//           padding: const WidgetStatePropertyAll(
//             EdgeInsets.symmetric(vertical: 14),
//           ),
//           shape: WidgetStatePropertyAll(
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           ),
//           backgroundColor: WidgetStatePropertyAll(AppColors.green),
//           foregroundColor: WidgetStatePropertyAll(AppColors.white),
//           overlayColor: const WidgetStatePropertyAll(Colors.grey),
//         ),
//         onPressed: () => AppAlerts.customDialog(
//           context: context,
//           body: DoctorBookingAvailabilityDialog(doctorId: doctorId),
//         ),
//         child: const Text('view Availability & Book'),
//       ),
//     );
//   }
// }
//
//
