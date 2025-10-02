
import 'package:medora/features/auth/presentation/controller/form_controllers/register_controllers.dart' show RegisterControllers;

class RegisterValidator {
  static final RegisterValidator _instance =
      RegisterValidator._internal();

  factory RegisterValidator() => _instance;

  RegisterValidator._internal();

  String? validateInputs(RegisterControllers c) {
    final userName = c.userNameController.text.trim();
    final phone = c.phoneController.text.trim();
    final email = c.emailController.text.trim();
    final password = c.passwordController.text;
    final confirmPassword = c.confirmPasswordController.text;

    if ([userName, phone, email, password, confirmPassword]
        .any((e) => e.isEmpty)) {
      return 'Please fill all fields';
    }
    if (userName.length < 3) {
      return 'Username must be at least 3 characters';
    }

    if (!RegExp(r'^[0-9]{10,15}$').hasMatch(phone)) {
      return 'Enter a valid phone number';
    }
    if (!email.contains('@') || !email.contains('.')) {
      return 'Enter a valid email';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (confirmPassword != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}
