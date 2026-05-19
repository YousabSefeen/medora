import 'package:flutter/material.dart';
import 'package:medora/features/doctor_profile/presentation/controller/form_controllers/doctor_fields_validator.dart'
    show DoctorFieldsValidator;
import 'package:medora/features/doctor_profile/presentation/widgets/medical_specialties_field.dart'
    show MedicalSpecialtiesField;
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

/*class DoctorProfileBody extends StatelessWidget {
  final DoctorFieldsControllers doctorFieldsControllers;
  final DoctorFieldsValidator doctorFieldsValidator;

  const DoctorProfileBody({
    super.key,
    required this.doctorFieldsControllers,
    required this.doctorFieldsValidator,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> fields = [
      {
        'label': AppStrings.nameLabel,
        'hint': AppStrings.nameHint,
        'controller': doctorFieldsControllers.nameController,
        'validator': doctorFieldsValidator.validateName,
      },
      {'label': AppStrings.medicalSpecialtiesLabel},
      {
        'label': AppStrings.bioLabel,
        'hint': AppStrings.bioHint,
        'controller': doctorFieldsControllers.bioController,
        'validator': doctorFieldsValidator.validateBio,
        'maxLines': 3,
        'textHeight': 1.5,
      },
      {
        'label': AppStrings.locationLabel,
        'hint': AppStrings.locationHint,
        'controller': doctorFieldsControllers.locationController,
        'validator': doctorFieldsValidator.validateLocation,
      },
      {
        'label': AppStrings.feesLabel,
        'hint': AppStrings.feesHint,
        'controller': doctorFieldsControllers.feesController,
        'validator': doctorFieldsValidator.validateFees,
        'keyboardType': TextInputType.number,
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        const Align(
          alignment: Alignment.topCenter,
          child: DoctorProfilePhotoPicker(),
        ),

        ...fields.map(
          (field) => field['label'] == AppStrings.medicalSpecialtiesLabel
              ? const MedicalSpecialtiesField()
              : DoctorInfoField(
                  label: field['label'],
                  hintText: field['hint'],
                  controller: field['controller'],
                  validator: field['validator'],
                  maxLines: field['maxLines'] ?? 1,
                  textHeight: field['textHeight'] ?? 0,
                  keyboardType: field['keyboardType'] ?? TextInputType.text,
                ),
        ),
        const SizedBox(height: 5),
        const WeeklyScheduleCard(),
        const SizedBox(),
        SubmitProfileButton(controllers: doctorFieldsControllers),
        const SizedBox(height: 50),
      ],
    );
  }
}*/

class DoctorProfileBody extends StatelessWidget {
  final DoctorFieldsControllers controllers;
  final DoctorFieldsValidator validator;

  const DoctorProfileBody({
    super.key,
    required this.controllers,
    required this.validator,
  });

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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.topCenter,
          child: DoctorProfilePhotoPicker(),
        ),
        const SizedBox(height: 20),

        ...fieldConfigs.map((config) => _buildField(config)),

        const WeeklyScheduleCard(),
        const SizedBox(height: 20),
        SubmitProfileButton(controllers: controllers),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget _buildField(ProfileFieldConfig config) {
    if (config.isSpecialty) return const MedicalSpecialtiesField();

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
