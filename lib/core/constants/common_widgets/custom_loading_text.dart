import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

class CustomLoadingText extends StatelessWidget {
  const CustomLoadingText({super.key});

  @override
  Widget build(BuildContext context) {

  return  Padding(


    padding: const EdgeInsets.only(bottom: 30),

    child: DefaultTextStyle(
        style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 22.sp,
              height: 0,
              letterSpacing: 1,
              fontWeight: FontWeight.w700,
              color: Colors.blue,

            ),

        ),
        child: AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText('Loading...'),
          ],

          repeatForever: true,
        ),
      ),
  );
  }
}
