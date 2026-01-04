import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/features/appointments/presentation/controller/cubit/patient_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/patient_state.dart' show PatientState;

import 'package:medora/features/appointments/presentation/controller/form_contollers/patient_fields_controllers.dart'
    show PatientFieldsControllers;
import 'package:medora/features/appointments/presentation/controller/form_contollers/patient_fields_validator.dart'
    show PatientFieldsValidator;

import 'package:medora/features/appointments/presentation/widgets/patient_widgets/proceed_to_pay_button.dart'
    show ProceedToPayButton;
import 'package:medora/features/doctor_profile/presentation/widgets/doctor_info_field.dart'
    show DoctorInfoField;

import '../widgets/patient_widgets/gender_dropdown_field.dart';

/// Screen for entering patient personal information before completing appointment booking
///
/// This screen represents the second step in the appointment booking process where the user enters:
/// - Full name
/// - Gender
/// - Age
/// - Medical problem description
///
/// After completing the data, the user proceeds to payment method selection
class PatientDetailsScreen extends StatefulWidget {
  const PatientDetailsScreen({super.key});

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  late final PatientFieldsControllers _formControllers;
  late final PatientFieldsValidator _formValidator;

  /// Initialize controllers and validators for form field management
  void _initializeControllers() {
    _formControllers = PatientFieldsControllers();
    _formValidator = PatientFieldsValidator();
  }

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  @override
  void dispose() {
    _formControllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.patientDetails)),
      body: _buildFormContent(),
    );
  }

  /// Build main form content with validation state management
  Widget _buildFormContent() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child:
          BlocSelector<
            PatientCubit,
              PatientState,
            AutovalidateMode
          >(
            selector: (state) => state.validateMode,
            builder: (context, validateMode) => Form(
              key: _formControllers.formKey,
              autovalidateMode: validateMode,
              child: SizedBox(
                child: Column(
                  spacing: 25,
                  children: [
                    _buildNameField(),
                    _buildGenderField(),
                    _buildAgeField(),
                    _buildProblemField(),

                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ProceedToPayButton(
                          formControllers: _formControllers,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildNameField() => DoctorInfoField(
    label: AppStrings.fullNameLabel,
    hintText: AppStrings.fullNameHint,
    controller: _formControllers.nameController,
    validator: _formValidator.validateName,
  );

  Widget _buildGenderField() =>
      GenderDropdownField(controller: _formControllers.genderController);

  Widget _buildAgeField() => DoctorInfoField(
    label: AppStrings.ageLabel,
    hintText: AppStrings.ageHint,
    controller: _formControllers.ageController,
    keyboardType: TextInputType.number,
    validator: _formValidator.validateAge,
  );

  Widget _buildProblemField() => DoctorInfoField(
    label: AppStrings.problemLabel,
    hintText: AppStrings.problemHint,
    controller: _formControllers.problemController,
    maxLines: 4,
    validator: _formValidator.validateProblem,
  );
}
