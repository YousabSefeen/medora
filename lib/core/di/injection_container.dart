import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medora/core/di/app_settings_injection.dart';
import 'package:medora/core/di/payments_injection.dart';
import 'package:medora/features/appointments/di/appointments_injection.dart';
import 'package:medora/features/auth/di/auth_injection.dart';
import 'package:medora/features/doctor_list/di/doctors_list_injection.dart';
import 'package:medora/features/doctor_profile/di/doctor_profile_injection.dart';
import 'package:medora/features/favorites/di/favorites_injection.dart';
import 'package:medora/features/patient/di/patient_injection.dart';
import 'package:medora/features/search/di/search_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/specialties/di/specialties_injection.dart';
import '../../features/gemini/di/gemini_injection.dart';
import '../../features/home/presentation/controller/cubits/bottom_nav_cubit.dart';
import '../../features/reviews/di/reviews_injection.dart';
import '../../features/user/di/user_injection.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    // 1. Registering external core services
    await _initCore();
    await initAuthDependencies();
    await initUserDependencies();
    // 2. Registering core services (Auth, Payments, Settings)
    await initPaymentsDependencies();
    await initAppSettingsDependencies();
    // 3. Registering the features (that we created)
    await initDoctorsListDependencies();
    await initSpecialtiesDependencies();
    await initSearchDependencies();
    await initFavoritesDependencies();
    await initAppointmentsDependencies();
    await initPatientDependencies();
    await initDoctorProfileDependencies();
    await initReviewsDependencies();
    await initGeminiDependencies();
  }

  Future<void> _initCore() async {
    // تسجيل Dio
    sl.registerLazySingleton(() => Dio());

    // تسجيل Firestore
    sl.registerLazySingleton(() => FirebaseFirestore.instance);
    sl.registerLazySingleton(() => FirebaseAuth.instance);
    sl.registerLazySingleton(() => GoogleSignIn.instance);
    sl.registerLazySingleton(() => FacebookAuth.instance);

    // تسجيل SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => prefs);

    // تسجيل الـ UserID (يتم جلبه وقت التشغيل)
    sl.registerLazySingleton(
      () => FirebaseAuth.instance.currentUser?.uid ?? '',
    );
    sl.registerFactory(() => BottomNavCubit());
  }
}
