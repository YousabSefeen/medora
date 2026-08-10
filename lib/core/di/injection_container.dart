import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medora/core/di/app_settings_injection.dart' show initAppSettingsDependencies;
import 'package:medora/core/di/auth_injection.dart' ;
import 'package:medora/core/di/payments_injection.dart' show initPaymentsDependencies;
import 'package:medora/features/appointments/di/appointments_injection.dart'
    show initAppointmentsDependencies;
import 'package:medora/features/auth/di/auth_injection.dart';
import 'package:medora/features/doctor_list/di/doctors_list_injection.dart' show initDoctorsListDependencies;
import 'package:medora/features/doctor_profile/di/doctor_profile_injection.dart' show initDoctorProfileDependencies;
import 'package:medora/features/favorites/di/favorites_injection.dart'
    show initFavoritesDependencies;
import 'package:medora/features/patient/di/patient_injection.dart' show initPatientDependencies;
import 'package:medora/features/search/di/search_injection.dart' show initSearchDependencies;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    // 1. تسجيل الخدمات الأساسية الخارجية
    await _initCore();
    await initAuthDependencies();
    // 3. تسجيل خدمات الـ Core (Auth, Payments, Settings)
    await initYousabDependencies();
    await initPaymentsDependencies();
    await initAppSettingsDependencies();
    // 2. تسجيل الـ Features (التي قمنا بإنشائها)
    await initDoctorsListDependencies();
    await initSearchDependencies();
    await initFavoritesDependencies();
    await initAppointmentsDependencies();
    await initPatientDependencies();
    await initDoctorProfileDependencies();

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
     sl.registerLazySingleton(() => FirebaseAuth.instance.currentUser?.uid ?? '');

  }
}
