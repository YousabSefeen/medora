import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/services/server_locator.dart' show serviceLocator;
import 'package:medora/features/doctor_profile/presentation/controller/cubit/doctor_profile_cubit.dart'
    show DoctorProfileCubit;
import 'package:medora/features/doctor_profile/presentation/controller/states/doctor_profile_state.dart'
    show DoctorProfileState;

import '../../../../core/constants/app_strings/app_strings.dart';
import '../controller/form_controllers/doctor_fields_controllers.dart';
import '../controller/form_controllers/doctor_fields_validator.dart';
import '../widgets/doctor_profile_body.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  late final DoctorFieldsControllers doctorFieldsControllers;

  late final DoctorFieldsValidator doctorFieldsValidator;

  @override
  void initState() {
    super.initState();
    doctorFieldsControllers = DoctorFieldsControllers();
    doctorFieldsValidator = DoctorFieldsValidator();
  }

  @override
  void dispose() {
    doctorFieldsControllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text(AppStrings.doctorProfileTitle)),
      body: BlocProvider<DoctorProfileCubit>(
        create: (context) => serviceLocator<DoctorProfileCubit>(),
        child: BlocSelector<DoctorProfileCubit, DoctorProfileState, bool>(
          selector: (state) => state.hasValidatedBefore,

          builder: (context, hasValidatedBefore) => Form(
            key: doctorFieldsControllers.formKey,
            autovalidateMode: hasValidatedBefore
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: DoctorProfileBody(
              controllers: doctorFieldsControllers,
              validator: doctorFieldsValidator,
            ),
          ),
        ),
      ),
    );
  }
}
