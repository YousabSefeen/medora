import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:medora/features/auth/presentation/widgets/register_widgets/register_button.dart'
    show RegisterButton;
import 'package:medora/features/auth/presentation/widgets/register_widgets/register_form_fields.dart'
    show RegisterFormFields;
import 'package:medora/features/auth/presentation/widgets/register_widgets/register_header_section.dart'
    show RegisterHeaderSection;
import 'package:medora/features/auth/presentation/widgets/register_widgets/register_role_selector.dart'
    show RegisterRoleSelector;

import '../../controller/form_controllers/register_controllers.dart';
import '../auth_styled_container.dart';

class RegisterScreenBody extends StatelessWidget {
  final RegisterControllers registerControllers;

  const RegisterScreenBody({super.key, required this.registerControllers});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FadeInUp(
        child: Column(
          children: [
            const RegisterHeaderSection(),
            AuthStyledContainer(
              body: Column(
                children: [
                  RegisterFormFields(
                    userNameController: registerControllers.userNameController,
                    phoneController: registerControllers.phoneController,
                    emailController: registerControllers.emailController,
                    passwordController: registerControllers.passwordController,
                    confirmPasswordController:
                        registerControllers.confirmPasswordController,
                  ),
                  const RegisterRoleSelector(),
                  RegisterButton(registerControllers: registerControllers),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
