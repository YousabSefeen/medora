/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:medora/features/auth/presentation/screens/new_password_screen.dart';
import 'package:medora/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:medora/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:medora/features/home/presentation/screens/bottom_nav_screen.dart';
import 'package:medora/main.dart';

class AppRouterNames {

  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String bottomNav = '/home';
  static const String resetPassword = '/__/auth/action'; // 🎯 مسار الفايربيز المسبب للأزمة!
}

class AppRouterNew {
  static final GoRouter router = GoRouter(
    initialLocation: FirebaseAuth.instance.currentUser?.uid != null
        ? AppRouterNames.bottomNav
        : AppRouterNames.signIn,


    routes: [

      GoRoute(
        path: AppRouterNames.screenOne,
        builder: (context, state) => const ScreenOne(),
      ),
      GoRoute(
        path:  AppRouterNames.screenTwo,

        builder: (context, state) => const ScreenTwo(),
      ),
      GoRoute(
        path: AppRouterNames.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRouterNames.signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRouterNames.bottomNav,
        builder: (context, state) => const BottomNavScreen(),
      ),

      // 🎯 حل المشكلة السحري: التقاط الرابط القادم من الجيميل تلقائياً وفك شفرته
      GoRoute(

        path: AppRouterNames.resetPassword,
        builder: (context, state) {
          // استخراج الـ oobCode من الرابط بسطر واحد وبأمان تام!
          final oobCode = state.uri.queryParameters['oobCode'];

          return NewPasswordScreen(
            oobCode: oobCode ?? '',
            email: "jesusyousab@gmail.com", // يمكنك تمريره أو استقباله
          );
        },
      ),
    ],

    // صفحة خطأ احترافية بديلة للشاشة البيضاء
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('No route defined for ${state.uri}')),
    ),
  );
}*/
