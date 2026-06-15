import 'package:flutter/material.dart';

import '../../../../../core/base/disposable.dart';

class RegisterControllers implements Disposable {
  final formKey = GlobalKey<FormState>();
  final autoValidateMode = AutovalidateMode.disabled;
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final roleController = TextEditingController(
    text: 'client',
  );

  @override
  void dispose() {

    userNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    roleController.dispose();
  }
}
