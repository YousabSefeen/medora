import 'package:flutter/material.dart';
import 'package:medora/features/doctor_profile/presentation/controller/form_controllers/doctor_fields_validator.dart'
    show DoctorFieldsValidator;
import 'package:medora/features/doctor_profile/presentation/widgets/medical_specialties_section.dart'
    show MedicalSpecialtiesSection;
import 'package:medora/features/doctor_profile/presentation/widgets/models/profile_field_config.dart'
    show ProfileFieldConfig;
import 'package:medora/features/doctor_profile/presentation/widgets/profile_photo_picker/doctor_profile_photo_picker.dart'
    show DoctorProfilePhotoPicker;
import 'package:medora/features/doctor_profile/presentation/widgets/submit_profile_button.dart'
    show SubmitProfileButton;
import 'package:medora/features/doctor_profile/presentation/widgets/weekly_schedule_card.dart'
    show WeeklyScheduleCard;

import '../../../../core/constants/app_strings/app_strings.dart';
import '../controller/form_controllers/doctor_fields_controllers.dart';
import 'doctor_info_field.dart';

class DoctorProfileBody extends StatelessWidget {
  final DoctorFieldsControllers controllers;
  final DoctorFieldsValidator validator;

  const DoctorProfileBody({
    super.key,
    required this.controllers,
    required this.validator,
  });

  static SizedBox _buildSizedBox() => const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    final List<ProfileFieldConfig> fieldConfigs = [
      ProfileFieldConfig(
        label: AppStrings.nameLabel,
        hint: AppStrings.nameHint,
        controller: controllers.nameController,
        validator: validator.validateName,
      ),
      const ProfileFieldConfig(
        label: AppStrings.medicalSpecialtiesLabel,
        isSpecialty: true,
      ),
      ProfileFieldConfig(
        label: AppStrings.bioLabel,
        hint: AppStrings.bioHint,
        controller: controllers.bioController,
        validator: validator.validateBio,
        maxLines: 3,
        textHeight: 1.5,
      ),
    ];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      physics: const BouncingScrollPhysics(),
      children: [
        _buildSizedBox(),
        const Align(
          alignment: Alignment.topCenter,
          child: DoctorProfilePhotoPicker(),
        ),
        _buildSizedBox(),

        ...fieldConfigs.map((config) => _buildField(config)),

        const WeeklyScheduleCard(),
        _buildSizedBox(),
        SubmitProfileButton(controllers: controllers),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget _buildField(ProfileFieldConfig config) {
    if (config.isSpecialty) return const MedicalSpecialtiesSection();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DoctorInfoField(
        label: config.label,
        hintText: config.hint,
        controller: config.controller,
        validator: config.validator,
        maxLines: config.maxLines,
        textHeight: config.textHeight,
        keyboardType: config.keyboardType,
      ),
    );
  }
}
