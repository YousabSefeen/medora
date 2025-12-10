import 'package:flutter/material.dart';
import 'package:medora/features/auth/presentation/controller/form_controllers/login_controllers.dart'
    show LoginControllers;

import '../../../../core/constants/themes/app_colors.dart';
import '../widgets/auth_screen_background.dart';
import '../widgets/login_widgets/login_screen_body.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginControllers loginControllers;
  String? registeredUserEmail;

  void _initializeTextControllers() => loginControllers = LoginControllers();

  // Retrieves the user email passed from the Register screen
  // when registration fails due to email already being in use.
  void _setEmailFromRegisterRoute() => Future.microtask(() {
    if (!mounted) return;
    registeredUserEmail = ModalRoute.of(context)?.settings.arguments as String?;
    loginControllers.emailController.text = registeredUserEmail ?? '';
  });

  @override
  void initState() {
    super.initState();
    _initializeTextControllers();
    _setEmailFromRegisterRoute();
  }

  @override
  void dispose() {
    loginControllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            const AuthScreenBackground(),
            LoginScreenBody(loginControllers: loginControllers),
          ],
        ),
      ),
    );
  }
}
