import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medora/core/animations/custom_animation_route.dart'
    show CustomAnimationRoute;
import 'package:medora/features/doctors_specialties/presentation/screens/medical_specialties_screen.dart'
    show MedicalSpecialtiesScreen;
import 'package:medora/features/home/presentation/screens/bottom_nav_screen.dart'
    show BottomNavScreen;
import 'package:medora/features/notifications/presentation/screens/notifications_screen.dart'
    show NotificationsScreen;
import 'package:medora/features/payment_gateways/paypal/presentation/views/screens/paypal_payment_screen.dart'
    show PaypalPaymentScreen;

import '../../../features/appointments/presentation/screens/booked_appointments_screen.dart';
import '../../../features/auth/presentation/screens/login_screen.dart';
import '../../../features/auth/presentation/screens/register_screen.dart';
import '../../../features/doctor_profile/presentation/screens/doctor_profile_screen.dart';
import '../../animations/animation_route.dart';
import 'app_router_names.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterNames.login:
        return _animatedRoute(settings, const LoginScreen());

      case AppRouterNames.register:
        return _animatedRoute(settings, const RegisterScreen());
      case AppRouterNames.bottomNavScreen:
        return _animatedRoute(settings, const BottomNavScreen());
      case AppRouterNames.notifications:
        return _animatedRoute(settings, const NotificationsScreen());
      case AppRouterNames.doctorProfile:
        return _animatedRoute(settings, const DoctorProfileScreen());

      case AppRouterNames.bookedAppointments:
        return _animatedRoute(settings, const BookedAppointmentsScreen());

      case AppRouterNames.paypalPayment:
        return _animatedRoute(settings, const PaypalPaymentScreen());
      case AppRouterNames.medicalSpecialties:
        return _animatedRoute(
          settings,
          const MedicalSpecialtiesScreen(),
          isFadeRoute: false,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  static AnimatedRoute _animatedRoute(
    RouteSettings settings,
    Widget screen, {
    bool isFadeRoute = true,
  }) {
    return AnimatedRoute(
      builder: (_) => screen,
      arguments: settings.arguments,
      isFadeRoute: isFadeRoute,
    );
  }

  static Future<Null> pushNamed(
    BuildContext context,
    String screenName, {
    Object? arguments,
    FutureOr<dynamic> Function(Object?)? onResult,
  }) => Navigator.of(context).pushNamed(screenName, arguments: arguments).then((
    value,
  ) {
    if (onResult != null) {
      onResult(value);
    }
  });

  static void push(
    BuildContext context,
    Widget screen, {
    Object? arguments,
    FutureOr<dynamic> Function(Object?)? onResult,
  }) {
    // Standard Material navigation (Slide from side on iOS, Fade/Scale on Android)
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => screen,
            settings: RouteSettings(arguments: arguments),
          ),
        )
        .then((value) {
          if (onResult != null) {
            onResult(value);
          }
        });
    /* * [ NOTE: Custom Animated Transition ]
     * Use the commented block below to replace MaterialPageRoute with our custom AnimatedRoute.
     * * - AnimatedRoute: Provides custom transitions (Slide-up or Scale-in).
     * - isFadeRoute (true): Performs a Bottom-to-Top Slide transition.
     * - isFadeRoute (false): Performs a Center-out Scale transition.
     * * This ensures consistent custom animations across the app instead of platform-default ones.
     */
    // Navigator.of(context)
    //     .push(
    //   AnimatedRoute(
    //     builder: (context) => screen,
    //     arguments: arguments,
    //     isFadeRoute: false,
    //   ),
    // )
    //     .then((value) {
    //   if (onResult != null) {
    //     onResult(value);
    //   }
    // });
  }

  static Future<Object?> pushNamedAndRemoveUntil(
    BuildContext context,
    String screenName, {
    Object? arguments,
    bool isReplacement = false,
  }) =>
      //pushNamedAndRemoveUntil//pushAndRemoveUntil//pushReplacementNamed
      Navigator.of(context).pushNamedAndRemoveUntil(
        screenName,
        (Route<dynamic> route) => isReplacement,
        arguments: arguments,
      );

  static Future pushAndRemoveUntil(
    BuildContext context,
    Widget screen, {
    Object? arguments,
  }) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
      settings: RouteSettings(arguments: arguments),
    ),
    (Route<dynamic> route) => false,
  );

  static void pop(BuildContext context, {dynamic returnValue}) =>
      Navigator.pop(context, returnValue);

  static void dismissKeyboard() =>
      FocusManager.instance.primaryFocus?.unfocus();

  static void popWithKeyboardDismiss(BuildContext context) {
    pop(context);
    dismissKeyboard();
  }

  //xxxxxxxxxxxxxxxxxxxx
  static redirectToPaymentGateways(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      CustomAnimationRoute(screen: const BottomNavScreen()),
      (_) => false,
    );
  }
}
