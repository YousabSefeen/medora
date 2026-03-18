import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/common_widgets/app_network_image.dart'
    show AppNetworkImage;
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart';
import 'package:medora/features/appointments/presentation/widgets/appointment_widgets/underline_title_widget.dart';
import 'package:medora/features/appointments/presentation/widgets/icon_with_text.dart';
import 'package:medora/features/shared/presentation/widgets/doctor_name.dart';
import 'package:medora/features/shared/presentation/widgets/doctor_specialties.dart'
    show DoctorSpecialties;

class AppointmentDetailsScreen extends StatelessWidget {
  final ClientAppointmentsEntity appointment;

  const AppointmentDetailsScreen({super.key, required this.appointment});

  static const double _horizontalPadding = 7.0;

  static const double _cardHorizontalMargin = 15.0;

  static const double _sectionSpacing = 30.0;
  static const double _itemSpacing = 20.0;
  static const double _smallSpacing = 25.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildContent(context));
  }

  AppBar _buildAppBar() {
    return AppBar(title: const Text(AppStrings.appointmentDetailsTitle));
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: _horizontalPadding,
        right: _horizontalPadding,
        bottom: 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: _smallSpacing,
        children: [
          _buildDoctorCard(),

          _buildDoctorInformationSection(),

          _buildPatientInformationSection(),

          _buildAppointmentScheduleSection(context),
        ],
      ),
    );
  }

  Widget _buildDoctorCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: _cardHorizontalMargin),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: const BorderSide(color: Colors.black26),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDoctorImage(),
          Expanded(child: _buildDoctorInfoContent()),
        ],
      ),
    );
  }

  Padding _buildDoctorImage() => Padding(
    padding: const EdgeInsets.all(5),
    child: AppNetworkImage(
      heroTag: appointment.appointmentId,
      imageUrl: appointment.doctorEntity.imageUrl,
      width: 90,
      height: 100,
      imageRadius: 12,
    ),
  );

  Widget _buildDoctorInfoContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 5,
        children: [
          DoctorName(name: appointment.doctorEntity.name),
          const Divider(color: Colors.black12, thickness: 3),

          DoctorSpecialties(specialties: appointment.doctorEntity.specialties),
        ],
      ),
    );
  }

  Widget _buildDoctorInformationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UnderlineTitleWidget(title: AppStrings.doctorInformationTitle),
        const SizedBox(height: _sectionSpacing),
        _buildInformationItem(
          label: AppStrings.bioLabel,
          value: appointment.doctorEntity.bio,
        ),
        const SizedBox(height: _itemSpacing),
        _buildInformationItem(
          label: AppStrings.locationLabel,
          value: appointment.doctorEntity.location,
        ),
        const SizedBox(height: _itemSpacing),
        _buildInformationItem(
          label: AppStrings.feeLable,
          value:
              '${appointment.doctorEntity.fees} ${AppStrings.egyptianCurrency}',
        ),
      ],
    );
  }

  Widget _buildPatientInformationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UnderlineTitleWidget(title: AppStrings.patientInformationLabel),
        const SizedBox(height: _itemSpacing),
        _buildInformationItem(
          label: AppStrings.nameLabel,
          value: appointment.patientName,
        ),
        const SizedBox(height: _itemSpacing),
        _buildInformationItem(
          label: AppStrings.genderLabel,
          value: appointment.patientGender,
        ),
        const SizedBox(height: _itemSpacing),
        _buildInformationItem(
          label: AppStrings.ageLabel,
          value: appointment.patientAge,
        ),
      ],
    );
  }

  Widget _buildAppointmentScheduleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UnderlineTitleWidget(title: AppStrings.scheduledAppointmentLabel),
        const SizedBox(height: _itemSpacing),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: _buildAppointmentDateTimeCard(context),
        ),
      ],
    );
  }

  Widget _buildAppointmentDateTimeCard(BuildContext context) {
    return _AppointmentDateTimeCard(
      date: appointment.appointmentDate,
      time: appointment.appointmentTime,
    );
  }

  Widget _buildInformationItem({required String label, required String value}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabelText(label, constraints),
              _buildValueText(': $value', constraints),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLabelText(String label, BoxConstraints constraints) {
    return SizedBox(
      width: constraints.maxWidth * 0.25,
      child: Builder(
        builder: (context) =>
            Text(label, style: Theme.of(context).textTheme.poppinsSemiBoldDark),
      ),
    );
  }

  Widget _buildValueText(String value, BoxConstraints constraints) {
    return SizedBox(
      width: constraints.maxWidth * 0.6,
      child: Builder(
        builder: (context) =>
            Text(value, style: Theme.of(context).textTheme.bodyRegular),
      ),
    );
  }
}

class _AppointmentDateTimeCard extends StatelessWidget {
  final String date;
  final String time;

  const _AppointmentDateTimeCard({required this.date, required this.time});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.dateTimeBlackStyle.copyWith(
      color: Colors.black,
      fontSize: 15.sp,
    );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.customWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconWithText(
            iconColor: AppColors.black,
            icon: Icons.calendar_month,
            text: date,
            textStyle: textStyle,
          ),
          IconWithText(
            iconColor: AppColors.black,
            icon: Icons.alarm,
            text: time,
            textStyle: textStyle,
          ),
        ],
      ),
    );
  }
}
