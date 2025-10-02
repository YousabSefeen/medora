class PatientFieldsValidator {
  const PatientFieldsValidator._internal();

  static final PatientFieldsValidator _instance =
      const PatientFieldsValidator._internal();

  factory PatientFieldsValidator() => _instance;

  // Name - required and at least 5 characters
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }
    if (value.trim().length < 5) {
      return 'Name must be at least 5 characters long';
    }
    return null;
  }

  // Age - required and must be a positive number
  String? validateAge(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your age';
    }
    final parsed = int.tryParse(value.trim());
    if (parsed == null || parsed <= 0) {
      return 'Age must be a valid positive number';
    }
    return null;
  }

  // Problem - required and at least 10 characters
  String? validateProblem(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please describe your health concern';
    }
    if (value.trim().length < 10) {
      return 'Description must be at least 10 characters';
    }
    return null;
  }
}
