import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/generated/assets.dart' show Assets;

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    final deviceHeight = deviceSize.height;

    return SliverAppBar(
      pinned: true,

      titleSpacing: 0,
      floating: true,

      expandedHeight: deviceHeight * 0.21 + kToolbarHeight,

      backgroundColor: AppColors.white,

      // bottom هنا يتم وضع الـ TextFormField ليكون مرئيا دائما
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Container(
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
            child: SizedBox(
              height: 50,
              child: TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: AppColors.customWhite,
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color:AppColors.softBlue,),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color:AppColors.softBlue,),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned(
              top: 5,
              left: 10,
              right: 10,
              child: GestureDetector(
                  onTap: () {
                    print('CustomHomeAppBar.buildxxxxxxxxx');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color:Colors.white70),
                        boxShadow: const [
                          BoxShadow(
                              color: AppColors.blue,
                              blurRadius: 2,
                              spreadRadius: 1,
                              offset: Offset(0, 1))
                        ]),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          Assets.imagesEmptyBack,
                          fit: BoxFit.fill,
                        )),
                  )),
            ),
            Positioned(
              top: 30,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ask AI Doctor',
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                            shadows: const [
                          Shadow(
                              offset: Offset(0, 1),
                              color: Colors.white,
                              blurRadius: 5),
                        ])),
                  ),
                  const SizedBox(height: 7),
                  _buildText('Find The Right Doctor'),
                  _buildText('Get Symptom Based Of\n The Guideline'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text _buildText(String text) => Text(
      text,
      style: TextStyle(
          fontSize: 11.sp,
          color: Colors.white70,
          fontWeight: FontWeight.w500,
          height: 1.5),
    );
}
