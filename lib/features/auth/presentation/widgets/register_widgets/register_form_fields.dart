import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/features/auth/presentation/controller/cubit/register_cubit.dart' show RegisterCubit;

import '../../../../../core/constants/themes/app_colors.dart';
import '../../controller/states/register_state.dart';
import '../custom_form_field.dart';

class RegisterFormFields extends StatelessWidget {
  final TextEditingController userNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const RegisterFormFields({
    super.key,
    required this.userNameController,
    required this.phoneController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.coolBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _buildTextField('User Name', FontAwesomeIcons.user,
              userNameController, TextInputType.name),
          _buildTextField('Phone Number', FontAwesomeIcons.phone,
              phoneController, TextInputType.number),
          _buildTextField('Email', FontAwesomeIcons.envelope, emailController,
              TextInputType.emailAddress),
          _buildPasswordField(context),
          _buildConfirmPasswordField(context),
        ],
      ),
    );
  }

  Widget _buildTextField(String title, IconData icon,
      TextEditingController controller, TextInputType type) {
    return CustomFormField(
      title: title,
      icon: icon,
      controller: controller,
      keyboardType: type,
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return BlocSelector<RegisterCubit, RegisterState, bool>(
      selector: (state) => state.isPasswordVisible,
      builder: (context, isPasswordVisible) => CustomFormField(
        title: 'Password',
        icon: FontAwesomeIcons.lock,
        controller: passwordController,
        keyboardType: TextInputType.text,
        obscureText: isPasswordVisible,
        suffixIcon: IconButton(
          onPressed: () =>
              context.read<RegisterCubit>().togglePasswordVisibility(),
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordField(BuildContext context) {
    return BlocSelector<RegisterCubit, RegisterState, bool>(
      selector: (state) => state.isConfirmPasswordVisible,
      builder: (context, isConfirmPasswordVisible) => CustomFormField(
        title: 'Confirm Password',
        icon: FontAwesomeIcons.lock,
        controller: confirmPasswordController,
        keyboardType: TextInputType.text,
        obscureText: isConfirmPasswordVisible,
        suffixIcon: IconButton(
          onPressed: () =>
              context.read<RegisterCubit>().toggleConfirmPasswordVisibility(),
          icon: Icon(
            isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
