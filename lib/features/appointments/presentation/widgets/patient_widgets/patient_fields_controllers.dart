import 'package:flutter/material.dart';
import 'package:medora/core/enum/gender_type.dart' show GenderType;

import '../../../../../core/base/disposable.dart' show Disposable;

class PatientFieldsControllers implements Disposable {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  final ageController = TextEditingController();
  final problemController = TextEditingController();
  late final GenderType? genderType;

  @override
  void dispose() {
    nameController.dispose();

    ageController.dispose();
    problemController.dispose();
  }
}
