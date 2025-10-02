// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_task/core/constants/app_routes/app_router.dart';
// import 'package:flutter_task/core/constants/app_routes/app_router_names.dart';
// import 'package:flutter_task/core/constants/themes/app_colors.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../Presentation/Views/screen/payment_gateways_screen.dart';
//
// class CustomBackButton extends StatelessWidget {
//   const CustomBackButton({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 40.h,
//       width: double.maxFinite,
//       margin: EdgeInsets.only(bottom: 15.h),
//       child: ElevatedButton(
//         style: ButtonStyle(
//           backgroundColor:
//                 const WidgetStatePropertyAll(AppColors.softBlue),
//           foregroundColor:
//               const WidgetStatePropertyAll(AppColors.white),
//           overlayColor: const WidgetStatePropertyAll(Colors.grey),
//           shape: WidgetStatePropertyAll(RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           )),
//         ),
//         onPressed: () => AppRouter.pushNamedAndRemoveUntil(context, AppRouterNames.doctorListView),
//         child: Text(
//           'Done',
//           style:TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.w700,
//               letterSpacing: .05),
//         ),
//       ),
//     );
//   }
// }
