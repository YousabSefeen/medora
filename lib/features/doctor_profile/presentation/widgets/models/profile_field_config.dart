import 'package:flutter/material.dart' show TextEditingController, TextInputType;

class ProfileFieldConfig {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int maxLines;
  final double textHeight;
  final TextInputType keyboardType;
  final bool isSpecialty;

  const ProfileFieldConfig({
    required this.label,
    this.hint,
    this.controller,
    this.validator,
    this.maxLines = 1,
    this.textHeight = 0,
    this.keyboardType = TextInputType.text,
    this.isSpecialty = false,
  });
}
