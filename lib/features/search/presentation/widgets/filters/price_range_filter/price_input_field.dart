import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';

class PriceInputField extends StatefulWidget {
  final String label;
  final double value;
  final ValueChanged<double> onValueChanged;
  final bool isMinPrice;

  const PriceInputField({
    super.key,
    required this.label,
    required this.value,
    required this.onValueChanged,
    required this.isMinPrice,
  });

  @override
  State<PriceInputField> createState() => _PriceInputFieldState();
}

class _PriceInputFieldState extends State<PriceInputField> {
  late TextEditingController _controller;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(PriceInputField oldWidget) {
    super.didUpdateWidget(oldWidget);

    //👇 Update the controller when the value changes externally
    if (oldWidget.value != widget.value && !_focusNode.hasFocus) {
      _controller.text = widget.value.round().toString();
    }
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus) {
      _submitValue();
    }
  }

  void _submitValue() {
    final value = double.tryParse(_controller.text);
    if (value != null && value != widget.value) {
      widget.onValueChanged(value);
    } else {
      // Reset to current value
      _controller.text = widget.value.round().toString();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      style: textTheme.styleInputField.copyWith(color: AppColors.black),
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      onEditingComplete: _submitValue,
      onFieldSubmitted: (_) => _submitValue(),
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: _displayEgyptianCurrencySymbol(),
        hintText: widget.label,
        hintStyle: _buildHintStyle(),
        hintMaxLines: 1,
        fillColor: AppColors.fieldFillColor,
        filled: true,
        border: _buildBorder(AppColors.fieldBorderColor),
        enabledBorder: _buildBorder(AppColors.fieldBorderColor),
        focusedBorder: _buildBorder(AppColors.fieldBorderColor),
      ),
    );
  }

  TextStyle _buildHintStyle() => TextStyle(
    fontSize: 10.sp,
    color: Colors.grey.shade600,
    fontWeight: FontWeight.w500,
  );

  Container _displayEgyptianCurrencySymbol() => Container(
    width: 30,
    height: 40,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.r),
        bottomLeft: Radius.circular(8.r),
      ),
      border: Border.all(color: AppColors.black12, width: 1.5),
    ),
    alignment: Alignment.center,
    child: const Text('EGP', style: TextStyle(color: Colors.white)),
  );

  OutlineInputBorder _buildBorder(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: BorderSide(color: color, width: 1.2),
  );
}
