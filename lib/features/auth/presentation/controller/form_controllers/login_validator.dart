import 'login_controllers.dart';

class LoginValidator {
  static final LoginValidator _instance = LoginValidator._internal();

  factory LoginValidator() => _instance;

  LoginValidator._internal();

  String? validateInputs(LoginControllers c) {
    final email = c.emailController.text.trim();
    final password = c.passwordController.text;

    if ([email, password].any((e) => e.isEmpty)) {
      return 'Please fill all fields';
    }

    if (!email.contains('@') || !email.contains('.')) {
      return 'Enter a valid email';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }
}
