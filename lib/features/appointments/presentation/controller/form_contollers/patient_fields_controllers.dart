import 'package:animated_drop_down_form_field/animated_drop_down_form_field.dart';
import 'package:flutter/material.dart';

import '../../../../../core/base/disposable.dart';

class PatientFieldsControllers implements Disposable {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final genderController = AnimatedDropDownFormFieldController();
  final ageController = TextEditingController();
  final problemController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    genderController.dispose();
    ageController.dispose();
    problemController.dispose();
    phoneNumberController.dispose();
  }
}
