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
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      style: textTheme.styleInputField.copyWith(
        color: AppColors.white,
      ),
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      onEditingComplete: _submitValue,
      onFieldSubmitted: (_) => _submitValue(),
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: Container(
          width: 30,
          height: 40,
          decoration: BoxDecoration(
            color:AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.r),
              bottomLeft: Radius.circular(8.r),

            ),
            border: Border.all(color: AppColors.black12, width: 1.5),
          ),
          alignment: Alignment.center,
          child: const Text('EGP', style: TextStyle(color: Colors.black)),
        ),
        hintText: widget.label,
        hintStyle: TextStyle(
          fontSize: 9.sp,
         // color: Colors.black54,
          color: AppColors.customWhite,
          fontWeight: FontWeight.w500,
        ),
        hintMaxLines: 1,
        fillColor: AppColors.black,
        filled: true,
        border: _buildBorder(AppColors.black12),
        enabledBorder: _buildBorder(AppColors.black12),
        focusedBorder: _buildBorder(Colors.black),
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: color, width: 1.2),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

/*
class PriceInputField extends StatefulWidget {
  final String label;
  final double initialValue;

  final ValueChanged<double> onValueChanged;

  const PriceInputField({
    super.key,

    required this.label,

    required this.initialValue,
    required this.onValueChanged,
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
    _controller = TextEditingController(
      text: widget.initialValue.round().toString(),
    );

    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus) {
      _submitValue();
    }
  }

  void _submitValue() {
    final value = double.tryParse(_controller.text);
    if (value != null && value != widget.initialValue) {
      widget.onValueChanged(value);
    } else {
      // إعادة تعيين القيمة الأصلية إذا كانت غير صالحة
      _controller.text = widget.initialValue.round().toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,

      style: textTheme.styleInputField,
      keyboardType: TextInputType.number,

      textAlign: TextAlign.center,
      onEditingComplete: _submitValue,
      onFieldSubmitted: (_) => _submitValue(),
      textInputAction: TextInputAction.send,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        isDense: true,

        prefixIcon: Container(
          width: 30,
          height: 40,

          decoration: BoxDecoration(
            color: AppColors.softBlue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.r),
              bottomLeft: Radius.circular(8.r),
            ),
          ),
          alignment: Alignment.center,

          child: const Text('EGP', style: TextStyle(color: Colors.white)),
        ),
        hintText: widget.label,

        hintStyle: TextStyle(
          fontSize: 9.sp,
          color: Colors.black54,
          fontWeight: FontWeight.w500,
        ),

        hintMaxLines: 1,

        fillColor: AppColors.fieldFillColor,
        filled: true,
        border: _buildBorder(AppColors.fieldBorderColor),
        enabledBorder: _buildBorder(AppColors.fieldBorderColor),
        focusedBorder: _buildBorder(Colors.black26),
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: color, width: 1.2),
    );
  }
}
*/
