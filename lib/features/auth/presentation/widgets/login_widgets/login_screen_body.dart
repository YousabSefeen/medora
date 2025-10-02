import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../controller/form_controllers/login_controllers.dart';
import '../auth_header.dart';
import 'login_form_section.dart';

class LoginScreenBody extends StatelessWidget {
  final LoginControllers loginControllers;

  const LoginScreenBody({super.key, required this.loginControllers});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: isKeyboardVisible
                      ? MediaQuery.of(context).viewInsets.bottom
                      : 0,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        SizedBox(
                          height: constraints.maxHeight * 0.4,
                          child: const Center(
                            child: AuthHeader(isLogin: true),
                          ),
                        ),
                        LoginFormSection(loginControllers: loginControllers),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
