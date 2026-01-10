import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/list_string_extension.dart';
import 'package:medora/core/extensions/string_extensions.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart';
import 'package:medora/features/appointments/presentation/widgets/appointment_widgets/underline_title_widget.dart';
import 'package:medora/features/appointments/presentation/widgets/icon_with_text.dart';
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;

import '../../../../generated/assets.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  static const double _horizontalPadding = 7.0;
  static const double _verticalPadding = 10.0;
  static const double _cardHorizontalMargin = 15.0;
  static const double _cardVerticalMargin = 10.0;
  static const double _sectionSpacing = 30.0;
  static const double _itemSpacing = 20.0;
  static const double _smallSpacing = 25.0;

  final ClientAppointmentsEntity appointment;

  const AppointmentDetailsScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final doctor = appointment.doctorEntity;

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildContent(context, doctor),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(title: const Text(AppStrings.appointmentDetailsTitle));
  }

  Widget _buildContent(BuildContext context, DoctorEntity doctor) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: _horizontalPadding,
        vertical: _verticalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDoctorCard(doctor),
          const SizedBox(height: _smallSpacing),
          _buildDoctorInformationSection(doctor),
          const SizedBox(height: _sectionSpacing),
          _buildPatientInformationSection(),
          const SizedBox(height: _sectionSpacing),
          _buildAppointmentScheduleSection(context),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(DoctorEntity doctor) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: _cardHorizontalMargin,
        vertical: _cardVerticalMargin,
      ),
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: const BorderSide(color: Colors.black26),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDoctorImage(doctor.imageUrl),
          Expanded(child: _buildDoctorInfoContent(doctor)),
        ],
      ),
    );
  }

  Widget _buildDoctorImage(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: CachedNetworkImage(
        width: 90,
        height: 100,
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            border: Border.all(color: Colors.black12, width: 2),
          ),
        ),
        placeholder: (context, _) =>
            _buildImagePlaceholder(Assets.imagesLoading),
        errorWidget: (context, s, _) =>
            _buildImagePlaceholder(Assets.imagesError),
      ),
    );
  }

  Widget _buildImagePlaceholder(String assetPath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black38, width: 2),
        image: DecorationImage(image: AssetImage(assetPath), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildDoctorInfoContent(DoctorEntity doctor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 5,
        children: [
          _buildDoctorName(doctor.name),
          const Divider(color: Colors.black12, thickness: 2),
          _buildDoctorSpecialties(doctor.specialties),
        ],
      ),
    );
  }

  Widget _buildDoctorName(String name) {
    return Builder(
      builder: (context) => Text(
        '${AppStrings.dR}${name.toCapitalizeFirstLetter()}',
        style: Theme.of(context).textTheme.mediumBlackBold.copyWith(
          fontSize: 17.sp,
          letterSpacing: 1,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildDoctorSpecialties(List<String> specialties) {
    return Builder(
      builder: (context) {
        return Text(
          specialties.buildJoin(),
          style: Theme.of(context).textTheme.hintFieldStyle.copyWith(
            fontSize: 15.sp,
            height: 0.9,
            letterSpacing: 1.2,
          ),
        );
      },
    );
  }

  Widget _buildDoctorInformationSection(DoctorEntity doctor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UnderlineTitleWidget(title: AppStrings.doctorInformationTitle),
        const SizedBox(height: _sectionSpacing),
        _buildInformationItem(label: AppStrings.bioLabel, value: doctor.bio),
        const SizedBox(height: _itemSpacing),
        _buildInformationItem(
          label: AppStrings.locationLabel,
          value: doctor.location,
        ),
        const SizedBox(height: _itemSpacing),
        _buildInformationItem(
          label: AppStrings.feeLable,
          value: '${doctor.fees} ${AppStrings.egyptianCurrency}',
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
            Text(label, style: Theme.of(context).textTheme.bodyMediumBold),
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

  const _AppointmentDateTimeCard({
    super.key,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = Colors.black54;
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
            iconColor: iconColor,
            icon: Icons.calendar_month,
            text: date,
            textStyle: textStyle,
          ),
          IconWithText(
            iconColor: iconColor,
            icon: Icons.alarm,
            text: time,
            textStyle: textStyle,
          ),
        ],
      ),
    );
  }
}
