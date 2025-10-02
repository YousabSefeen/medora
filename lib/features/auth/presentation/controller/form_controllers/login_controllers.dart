import 'package:flutter/cupertino.dart';

import '../../../../../core/base/disposable.dart' show Disposable;

class LoginControllers implements Disposable {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
