import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:medora/generated/assets.dart' show Assets;

class LoadingDialogBody extends StatelessWidget {
  const LoadingDialogBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(5),
          child: Lottie.asset(
            Assets.imagesIosStyleLoading,
            fit: BoxFit.fill,
            height: 160,
            width: 150,
          ),
        ),
        DefaultTextStyle(
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 22.sp,
              height: 0,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          child: AnimatedTextKit(
            animatedTexts: [WavyAnimatedText('Loading...')],
            repeatForever: true,
          ),
        ),
      ],
    );
  }
}
