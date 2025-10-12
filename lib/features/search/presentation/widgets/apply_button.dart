import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart';

class ApplyButton extends StatelessWidget {
  const ApplyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: _buildShapeDecoration(),
      child: ElevatedButton(
        style: _buildButtonStyle(context),
        onPressed: () {
          context.read<SearchCubit>(). searchDoctorsByFilters();
        },
        child: const Text('Apply'),
      ),
    );
  }

  ButtonStyle _buildButtonStyle(BuildContext context) {
    return Theme.of(context).elevatedButtonTheme.style!.copyWith(
        backgroundColor: WidgetStateProperty.all(AppColors.softBlue),
textStyle: WidgetStateProperty.all(
GoogleFonts.poppins(
  fontSize: 18.sp,
  fontWeight: FontWeight.w700,

),
      ));
  }

  ShapeDecoration _buildShapeDecoration() {
    return ShapeDecoration(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      shadows: const [
        BoxShadow(
          color: Colors.black,
          blurRadius: 10,
          spreadRadius: 0.5,
          offset: Offset(0, 2),
        ),
      ],
    );
  }
}
