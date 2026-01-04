// import 'package:easy_stepper/easy_stepper.dart';
// import 'package:flutter/material.dart';
// import 'package:medora/core/constants/themes/app_colors.dart';
// import 'package:medora/features/appointments/presentation/screens/patient_details_screen.dart'
//     show PatientDetailsScreen;
// import 'package:medora/features/appointments/presentation/widgets/doctor_appointment_booking_section.dart'
//     show DoctorAppointmentBookingSection;
// import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
//     show DoctorEntity;
// import 'package:medora/features/shared/models/doctor_schedule_model.dart'
//     show DoctorScheduleModel;
//
// class BookingStepperScreen extends StatefulWidget {
//   final DoctorEntity doctor;
//
//   const BookingStepperScreen({super.key, required this.doctor});
//
//   @override
//   State<BookingStepperScreen> createState() => _BookingStepperScreenState();
// }
//
// class _BookingStepperScreenState extends State<BookingStepperScreen> {
//   // المتغير المسؤول عن تحديد الخطوة الحالية
//   int activeStep = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // --- حزمة EasyStepper ---
//         Container(
//           child: EasyStepper(
//             direction: Axis.horizontal,
//             activeStep: activeStep,
//             lineStyle: const LineStyle(
//               lineLength: 100,
//               lineType: LineType.normal,
//               defaultLineColor: Colors.grey,
//               finishedLineColor: Colors.green,
//             ),
//             activeStepTextColor: Colors.black87,
//             finishedStepTextColor: Colors.green,
//             internalPadding: 0,
//             showLoadingAnimation: false,
//             activeStepBackgroundColor: Colors.deepOrange,
//             activeStepBorderColor: Colors.deepOrange,
//
//             stepRadius: 20,
//             showStepBorder: true,
//             steps: [
//               EasyStep(
//                 customStep: _buildStepIcon(Icons.calendar_today, 0),
//                 title: 'Appointment',
//               ),
//               EasyStep(
//                 customStep: _buildStepIcon(Icons.person_pin_outlined, 1),
//                 title: 'Patient data',
//               ),
//               EasyStep(
//                 customStep: _buildStepIcon(Icons.payment_outlined, 2),
//                 title: 'Payment',
//               ),
//             ],
//             onStepReached: (index) => setState(() => activeStep = index),
//           ),
//         ),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 0.0),
//             child: _buildCurrentPage(),
//           ),
//         ),
//
//         // --- عرض الـ Widgets الوهمية بناءً على الخطوة ---
//
//         // --- أزرار التحكم (التالي والسابق) ---
//         _buildControlButtons(),
//       ],
//     );
//   }
//
//   // ودج أيقونة الخطوة
//   Widget _buildStepIcon(IconData icon, int step) {
//     bool isFinished = activeStep > step;
//     bool isActive = activeStep == step;
//     return Icon(
//       icon,
//       color: isFinished || isActive ? Colors.white : Colors.grey,
//       size: 18,
//     );
//   }
//
//   // دالة اختيار الصفحة الوهمية
//   Widget _buildCurrentPage() {
//     switch (activeStep) {
//       case 0:
//         return Padding(
//           padding: EdgeInsets.symmetric(horizontal: 0.0),
//           child: DoctorAppointmentBookingSection(
//             doctorSchedule: DoctorScheduleModel(
//               doctorId: widget.doctor.doctorId!,
//               doctorAvailability: widget.doctor.doctorAvailability,
//             ),
//           ),
//         );
//       case 1:
//         return PatientDetailsScreen(doctor: widget.doctor, appointmentId: '');
//       case 2:
//         return DummyPage(
//           title: 'طريقة الدفع',
//           color: Colors.greenAccent,
//           description:
//               'هنا يختار المستخدم الدفع عبر الفيزا أو المحافظ الإلكترونية.',
//           icon: Icons.account_balance_wallet,
//         );
//       default:
//         return const SizedBox.shrink();
//     }
//   }
//
//   // أزرار التنقل
//   Widget _buildControlButtons() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           if (activeStep > 0)
//             ElevatedButton(
//               onPressed: () => setState(() => activeStep--),
//               child: const Text('Previous'),
//             )
//           else
//             const SizedBox.shrink(),
//           ElevatedButton(
//             onPressed: activeStep < 2
//                 ? () => setState(() => activeStep++)
//                 : () {
//                     /* إنهاء */
//                   },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.softBlue,
//             ),
//             child: Text(activeStep < 2 ? 'Next' : 'تأكيد نهائي'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ودج بسيط لعرض الصفحات الوهمية
// class DummyPage extends StatelessWidget {
//   final String title;
//   final String description;
//   final Color color;
//   final IconData icon;
//
//   const DummyPage({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.color,
//     required this.icon,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: color, width: 2),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 80, color: color),
//           const SizedBox(height: 20),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//               color: color,
//             ),
//           ),
//           const SizedBox(height: 10),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Text(
//               description,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // إضافة بسيطة للألوان لتسهيل الكود
// extension ColorsExt on Colors {
//   static const orangeOpacity = Colors.orange;
//   static const blueOpacity = Colors.blue;
//   static const greenOpacity = Colors.green;
// }
