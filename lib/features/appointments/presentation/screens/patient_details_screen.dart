import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/features/appointments/presentation/controller/cubit/patient_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/patient_state.dart'
    show PatientState;
import 'package:medora/features/appointments/presentation/controller/form_contollers/patient_fields_controllers.dart'
    show PatientFieldsControllers;
import 'package:medora/features/appointments/presentation/controller/form_contollers/patient_fields_validator.dart'
    show PatientFieldsValidator;
import 'package:medora/features/appointments/presentation/widgets/patient_widgets/gender_dropdown_field.dart'
    show GenderDropdownField;
import 'package:medora/features/appointments/presentation/widgets/patient_widgets/proceed_to_pay_button.dart'
    show ProceedToPayButton;
import 'package:medora/features/doctor_profile/presentation/widgets/doctor_info_field.dart'
    show DoctorInfoField;

/// Screen for entering patient personal information before completing appointment booking
///
/// This screen represents the second step in the appointment booking process where the user enters:
/// - Full name
/// - Gender
/// - Age
/// - Medical problem description
///
/// After completing the data, the user proceeds to payment method selection
///
///
///

class PatientDetailsScreen extends StatefulWidget {
  const PatientDetailsScreen({super.key});

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  late final PatientFieldsControllers _formControllers;
  final _formValidator =
      PatientFieldsValidator(); // لا داعي لـ late إذا كان سينشأ فوراً

  @override
  void initState() {
    super.initState();
    _formControllers = PatientFieldsControllers();

    // --- الربط السحري هنا ---
    // نقوم بإخبار الـ Cubit بالـ Controllers الجديدة
    // ثم نطلب منه تحميل البيانات المحفوظة إليها
    final cubit = context.read<PatientCubit>();
    cubit.setControllers(_formControllers);
    cubit.loadSavedPatientData();
  }

  @override
  void dispose() {
    // تدمير الـ Controllers عند خروج المستخدم من الشاشة لتحسين الأداء
    _formControllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(title: const Text(AppStrings.patientDetails)),
      body: _buildFormContent(),
    );
  }

  Widget _buildFormContent() => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
    child: BlocSelector<PatientCubit, PatientState, AutovalidateMode>(
      selector: (state) => state.validateMode,
      builder: (context, validateMode) => Form(
        key: _formControllers.formKey,
        autovalidateMode: validateMode,
        child: Column(
          spacing: 25,
          children: [
            _buildNameField(),

            _buildGenderField(),

            _buildAgeField(),

            _buildProblemField(),

            const SizedBox.shrink(),

            ProceedToPayButton(formControllers: _formControllers),
          ],
        ),
      ),
    ),
  );

  Widget _buildNameField() => DoctorInfoField(
    label: AppStrings.fullNameLabel,
    hintText: AppStrings.fullNameHint,
    controller: _formControllers.nameController,
    validator: _formValidator.validateName,
  );

  Widget _buildGenderField() => const GenderDropdownField();

  Widget _buildAgeField() => DoctorInfoField(
    label: AppStrings.yourAgeLabel,
    hintText: AppStrings.ageHint,
    controller: _formControllers.ageController,
    keyboardType: TextInputType.number,
    validator: _formValidator.validateAge,
  );

  Widget _buildProblemField() => DoctorInfoField(
    textHeight: 1.5,
    maxLines: 4,
    label: AppStrings.problemLabel,
    hintText: AppStrings.problemHint,
    controller: _formControllers.problemController,
    validator: _formValidator.validateProblem,
  );
}
