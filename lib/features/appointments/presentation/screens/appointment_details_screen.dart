import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/list_string_extension.dart';
import 'package:medora/features/appointments/presentation/widgets/appointment_widgets/underline_title_widget.dart' show UnderlineTitleWidget;
import 'package:medora/features/appointments/presentation/widgets/icon_with_text.dart' show IconWithText;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart' show DoctorModel;

import '../../../../generated/assets.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final DoctorModel doctorModel;
  final String appointmentDate;
  final String appointmentTime;
  final String patientName;
  final String patientGender;
  final String patientAge;
  final String patientProblem;

  const AppointmentDetailsScreen({
    super.key,
    required this.doctorModel,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.patientName,
    required this.patientGender,
    required this.patientAge,
    required this.patientProblem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              color: Colors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
                side: const BorderSide(
                  color: Colors.black26,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: CachedNetworkImage(
                      width: 90,
                      height: 100,
                      imageUrl: doctorModel.imageUrl,
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                          border: Border.all(
                            color: Colors.black12,
                            width: 2,
                          ),
                        ),
                      ),
                      placeholder: (context, _) =>
                          _buildContainer(Assets.imagesLoading),
                      errorWidget: (context, s, _) =>
                          _buildContainer(Assets.imagesError),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 5,
                        children: [
                          Text(
                            'Dr.${doctorModel.name}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600, letterSpacing: 1,
                              fontSize: 17.sp,
                              color: AppColors.black,
                            ),
                          ),
                          const Divider(color: Colors.black12, thickness: 2),
                          Text(
                            doctorModel.specialties.buildJoin(),
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade500,
                                    letterSpacing: 1)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const UnderlineTitleWidget(title: 'Doctor Information'),
            const SizedBox(height: 30),
            _customRichText(title: 'Bio', des: ' : ${doctorModel.bio}'),
            const SizedBox(height: 20),
            _customRichText(
                title: 'Location', des: ' : ${doctorModel.location}'),
            const SizedBox(height: 20),
            _customRichText(title: 'Fee', des: ' : ${doctorModel.fees} EGP'),
            const SizedBox(height: 30),
            const UnderlineTitleWidget(title: 'Patient Information'),
            const SizedBox(height: 20),
            _customRichText(title: 'Full Name', des: ' : $patientName'),
            const SizedBox(height: 20),
            _customRichText(title: 'Gender: ', des: ' : $patientGender'),
            const SizedBox(height: 20),
            _customRichText(title: 'Age', des: ' : $patientAge'),
            const SizedBox(height: 30),
            const UnderlineTitleWidget(title: 'Scheduled appointment'),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _buildAppointmentCard(
                date: appointmentDate,
                time: appointmentTime,
                style: Theme.of(context)
                    .textTheme
                    .dateTimeBlackStyle
                    .copyWith(color: Colors.white, fontSize: 15.sp),
                backgroundColor: AppColors.green,
                borderColor: AppColors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildAppointmentCard({
    required String date,
    required String time,
    required TextStyle style,
    required Color backgroundColor,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 1.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconWithText(
            icon: Icons.calendar_month,
            text: date,
            textStyle: style,
          ),
          IconWithText(
            icon: Icons.alarm,
            text: time,
            textStyle: style,
          ),
        ],
      ),
    );
  }

  Container _buildContainer(String image) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black38, width: 2),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _customRichText({required String title, required String des}) {
    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: constraints.maxWidth * 0.25,
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade900,
                    letterSpacing: 1),
              ),
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.6,
                  child: Text(des, style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,

                      color: Colors.grey.shade700,
                      letterSpacing: 1),),
                ),
                /*  RichText(
              text: TextSpan(
                  text: title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800, letterSpacing: 1,
                    fontSize: 14.sp,
                    // color: const Color(0xff3674B5),
                    color: AppColors.black,
                  ),
                  children: [
                    TextSpan(
                        text: des,
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade700,
                            letterSpacing: 1),
                    )
                  ]),
            ),*/
              ],
            ),
          ),
    );
  }
}
/*
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/appointment_widgets/underline_title_widget.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/icon_with_text.dart';
import 'package:flutter_task/features/doctor_profile/data/models/doctor_model.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/common_widgets/consultation_fee_and_wait_row.dart';
import '../../../../generated/assets.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final DoctorModel doctorModel;
  final String appointmentDate;
  final String appointmentTime;

  const AppointmentDetailsScreen(
      {super.key,
      required this.doctorModel,
      required this.appointmentDate,
      required this.appointmentTime});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              color: Colors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
                side: const BorderSide(
                  color: Colors.black26,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: CachedNetworkImage(
                      width: 90,
                      height: 100,
                      imageUrl: doctorModel.imageUrl,
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                          border: Border.all(
                            color: Colors.black12,
                            width: 2,
                          ),
                        ),
                      ),
                      placeholder: (context, _) =>
                          _buildContainer(Assets.imagesLoading),
                      errorWidget: (context, s, _) =>
                          _buildContainer(Assets.imagesError),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 5,
                        children: [
                          Text(
                            'Dr.${doctorModel.name}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600, letterSpacing: 1,
                              fontSize: 17.sp,
                              // color: const Color(0xff3674B5),
                              color: AppColors.black,
                            ),
                          ),
                          const Divider(color: Colors.black12, thickness: 2),
                          Text(
                            doctorModel.specialties,
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade500,
                                    letterSpacing: 1)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const UnderlineTitleWidget(title: 'Doctor Information'),
            const SizedBox(height: 30),
            _customRichText(title: 'Bio: ', des: doctorModel.bio),
            const SizedBox(height: 20),
            _customRichText(title: 'Location: ', des: doctorModel.location),
            const SizedBox(height: 20),
            _customRichText(title: 'Consultation Fee: ', des: '${doctorModel.fees} EGP'),


            const SizedBox(height: 30),
            const UnderlineTitleWidget(title: 'Patient Information'),
            const SizedBox(height: 20),
            _customRichText(title: 'Full Name: ', des: 'Yousab sefeen'),
            const SizedBox(height: 20),
            _customRichText(title: 'Gender: ', des: 'Male'),


            const SizedBox(height: 20),
            _customRichText(title: 'Age: ', des: '27'),

            const SizedBox(height: 30),
            const UnderlineTitleWidget(title: 'Scheduled appointment'),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _buildAppointmentCard(
                date: appointmentDate,
                time: appointmentTime,
                style: Theme.of(context)
                    .textTheme
                    .dateTimeBlackStyle
                    .copyWith(color: Colors.white, fontSize: 15.sp),
                backgroundColor: AppColors.green,
                borderColor: AppColors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildAppointmentCard({
    required String date,
    required String time,
    required TextStyle style,
    required Color backgroundColor,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 1.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconWithText(
            icon: Icons.calendar_month,
            text: date,
            textStyle: style,
          ),
          IconWithText(
            icon: Icons.alarm,
            text: time,
            textStyle: style,
          ),
        ],
      ),
    );
  }

  Container _buildContainer(String image) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black38, width: 2),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _customRichText({required String title, required String des}) {
    return RichText(
      text: TextSpan(
          text: title,
          style: TextStyle(
            fontWeight: FontWeight.w800, letterSpacing: 1,
            fontSize: 14.sp,
            // color: const Color(0xff3674B5),
            color: AppColors.black,
          ),
          children: [
            TextSpan(
                text: des,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade700,
                    letterSpacing: 1))
          ]),
    );
  }
}

 */