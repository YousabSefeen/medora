import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/string_extensions.dart';

class DoctorName extends StatelessWidget {
  final String name;
 final double? nameFontSize;


  const DoctorName({super.key, required this.name, this.nameFontSize });

  @override
  Widget build(BuildContext context) {
    // return Text(
    //   '${AppStrings.dR}${name.toCapitalizeFirstLetter()}',
    //
    //   style: Theme.of(context).textTheme.largeBlackBold.copyWith(
    //     fontSize: nameFontSize,
    //   ),
    //   maxLines: 1,
    //   overflow: TextOverflow.ellipsis,
    // );
   return AutoSizeText(
      'Dr. ${name.toCapitalizeFirstLetter()}',
      style: GoogleFonts.caladea(
        fontSize: nameFontSize,
        color: Colors.black,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,

      ),
      maxLines: 1,
    );
  }
}
