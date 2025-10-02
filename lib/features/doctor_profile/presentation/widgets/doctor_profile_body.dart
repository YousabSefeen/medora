import 'package:flutter/material.dart';
import 'package:medora/features/doctor_profile/presentation/controller/form_controllers/doctor_fields_validator.dart' show DoctorFieldsValidator;
import 'package:medora/features/doctor_profile/presentation/widgets/medical_specialties_field.dart' show MedicalSpecialtiesField;
import 'package:medora/features/doctor_profile/presentation/widgets/save_button.dart' show SaveButton;
import 'package:medora/features/doctor_profile/presentation/widgets/weekly_schedule_card.dart' show WeeklyScheduleCard;


import '../../../../core/constants/app_strings/app_strings.dart';
import '../controller/form_controllers/doctor_fields_controllers.dart';
import 'doctor_info_field.dart';
import 'doctor_profile_image.dart';

class DoctorProfileBody extends StatelessWidget {
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
      {
        'label': AppStrings.medicalSpecialtiesLabel,

      },
      {
        'label': AppStrings.bioLabel,
        'hint': AppStrings.bioHint,
        'controller': doctorFieldsControllers.bioController,
        'validator': doctorFieldsValidator.validateBio,
        'maxLines': 3,
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
          child: DoctorProfileImage(),
        ),

        ...fields.map((field) => field['label'] == AppStrings.medicalSpecialtiesLabel ? const MedicalSpecialtiesField():  DoctorInfoField(
              label: field['label'],
              hintText: field['hint'],
              controller: field['controller'],
              validator: field['validator'],
              maxLines: field['maxLines'] ?? 1,
              keyboardType: field['keyboardType'] ?? TextInputType.text,
            ),
        ),
        const SizedBox(height: 5),
        const WeeklyScheduleCard(),

        SaveButton(controllers: doctorFieldsControllers),
      ],
    );
  }
}
