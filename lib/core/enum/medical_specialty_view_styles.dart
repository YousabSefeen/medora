import 'package:flutter/material.dart' show BuildContext, FontWeight;
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
import 'package:medora/core/enum/app_view_context.dart' show AppViewContext;
import 'package:medora/core/extensions/media_query_extension.dart'
    show MediaQueryExtension;

extension MedicalSpecialtyViewStyles on AppViewContext {
  bool get isSpecialtyView => this == AppViewContext.medicalSpecialties;

  double specialtyImageHeight(BuildContext context) {
    return isSpecialtyView
        ? context.screenHeight * 0.08
        : context.screenHeight * 0.07;
  }

  double get specialtyFontSize => isSpecialtyView ? 14.sp : 12.sp;

  FontWeight get specialtyFontWeight =>
      isSpecialtyView ? FontWeight.w700 : FontWeight.w600;
}
