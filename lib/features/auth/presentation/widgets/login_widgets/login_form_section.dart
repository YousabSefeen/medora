import 'package:flutter/material.dart';

import '../../controller/form_controllers/login_controllers.dart';
import '../auth_styled_container.dart';
import 'login_button.dart';
import 'login_form_fields.dart';
import 'new_user_register_prompt.dart';

class LoginFormSection extends StatelessWidget {
  final LoginControllers loginControllers;

  const LoginFormSection({super.key, required this.loginControllers});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AuthStyledContainer(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LoginFormFields(loginControllers: loginControllers),
            LoginButton(loginControllers: loginControllers),
            const NewUserRegisterPrompt(),
          ],
        ),
      ),
    );
  }
}
