import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/app_routes/app_router.dart' show AppRouter;
import 'package:medora/core/constants/app_routes/app_router_names.dart' show AppRouterNames;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/features/auth/presentation/controller/cubit/login_cubit.dart' show LoginCubit;
import 'package:medora/features/home/presentation/constants/home_constants.dart' show HomeConstants;
import 'package:medora/features/home/presentation/widgets/home_screen_padding.dart'
    show HomeScreenPadding;





class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  HomeScreenPadding(

      child: Column(
        spacing: 20,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: AppColors.softBlue,
            child: Center(
              child: Text(
                'MediLink',
                style: GoogleFonts.poppins(
                  fontSize: 36.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading:
            Icon(Icons.manage_accounts, size: 16.sp, color: Colors.black),
            title: FittedBox(
                child: Text(
                  'Doctor Panel',
                  style: TextStyle(fontSize: 15.sp, color: Colors.black),
                )),
            trailing: Icon(Icons.arrow_forward_ios,
                size: 18.sp, color: Colors.black54),
            onTap: () => AppRouter.pushNamed(context, AppRouterNames.doctorProfile),
          ),
          ListTile(
            leading:
            Icon(Icons.manage_accounts, size: 16.sp, color: Colors.black),
            title: FittedBox(
                child: Text(
                  'My Appointment',
                  style: TextStyle(fontSize: 15.sp, color: Colors.black),
                )),
            trailing: Icon(Icons.arrow_forward_ios,
                size: 18.sp, color: Colors.black54),
            onTap: () => AppRouter.pushNamed(context, AppRouterNames.bookedAppointments),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                context.read<LoginCubit>().logout();
                AppRouter.pushNamedAndRemoveUntil(
                  context,
                  AppRouterNames.login,
                );
              },
              label: const Text('Logout'),
              icon: const Icon(
                Icons.login_rounded,
                color: Colors.black,
                size: 20,
              ),
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
