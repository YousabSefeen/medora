


import 'package:medora/core/app_settings/controller/cubit/app_settings_cubit.dart' show AppSettingsCubit;
import 'package:medora/core/di/injection_container.dart';

Future<void> initAppSettingsDependencies() async {

  // تسجيل الـ AppSettingsCubit
  // قمنا بنقل منطق "التهيئة" (Initialization) إلى داخل الـ Factory أو الـ Cubit نفسه
  // لضمان بقاء ملف الحقن نظيفاً ومخصصاً للتسجيل فقط.

  sl.registerLazySingleton<AppSettingsCubit>(() {
    final cubit = AppSettingsCubit();

    // تنفيذ عمليات التهيئة فور تسجيل الـ Cubit
    cubit.checkInitialInternetConnection();
    cubit.startMonitoring();

    return cubit;
  });
}