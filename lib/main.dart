import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:medora/core/app_settings/controller/cubit/app_settings_cubit.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/di/injection_container.dart';
import 'package:medora/core/enum/internet_state.dart';
import 'package:medora/core/extensions/lottie_string_asset_ext.dart';
import 'package:medora/core/services/overlay_notification_service.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/book_appointment_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/cancel_appointment_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/cancelled_appointments_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/completed_appointments_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/doctor_appointments_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/time_slot_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/upcoming_appointments_cubit.dart';
import 'package:medora/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:medora/features/favorites/presentation/controller/cubit/favorites_cubit.dart';
import 'package:medora/features/home/presentation/controller/cubits/bottom_nav_cubit.dart';
import 'package:medora/features/patient/presentation/controllers/cubit/patient_cubit.dart';
import 'package:medora/features/search/presentation/controller/cubit/home_doctor_search_cubit.dart';
import 'package:medora/generated/assets.dart';
import 'package:path_provider/path_provider.dart';

import 'Core/payment_gateway_manager/stripe_payment/stripe_keys.dart';
import 'core/app_settings/controller/states/app_settings_states.dart';
import 'core/base/my_bloc_observer.dart';
import 'core/constants/app_routes/app_router.dart';
import 'core/constants/themes/app_light_theme.dart';
import 'features/doctor_list/presentation/controller/cubit/doctor_list_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Bloc.observer = MyBlocObserver();

  final serviceLocator = ServiceLocator();
  await serviceLocator.init();

  if (!kIsWeb) {
    final tempDir = await getTemporaryDirectory();

    // يمكنك مسح الملفات القديمة عند بدء التشغيل
    try {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    } catch (e) {
      print('Error clearing temp: $e');
    }
  }

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Future.wait([
    initializeDateFormatting('en_US'),

    dotenv.load(fileName: '.env'),
  ]);
  Stripe.publishableKey = StripeKeys.publishableKey;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<HomeDoctorSearchCubit>()),

        BlocProvider(create: (_) => sl<FavoritesCubit>()..fetchFavoriteIds()),

        BlocProvider(create: (_) => sl<BottomNavCubit>()),
        BlocProvider(create: (_) => sl<AuthCubit>()),


        BlocProvider(create: (_) => sl<DoctorListCubit>()),

        BlocProvider(create: (_) => sl<AppSettingsCubit>()),

        BlocProvider<DoctorAppointmentsCubit>(
          create: (context) => sl<DoctorAppointmentsCubit>(),
        ),
        BlocProvider<TimeSlotCubit>(create: (context) => sl<TimeSlotCubit>()),

        BlocProvider<BookAppointmentCubit>(
          create: (context) => sl<BookAppointmentCubit>(),
        ),

        BlocProvider<PatientCubit>(create: (context) => sl<PatientCubit>()),

        BlocProvider<CancelAppointmentCubit>(
          create: (context) => sl<CancelAppointmentCubit>(),
        ),

        BlocProvider<UpcomingAppointmentsCubit>(
          create: (context) => sl<UpcomingAppointmentsCubit>(),
        ),
        BlocProvider<CompletedAppointmentsCubit>(
          create: (context) => sl<CompletedAppointmentsCubit>(),
        ),
        BlocProvider<CancelledAppointmentsCubit>(
          create: (context) => sl<CancelledAppointmentsCubit>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) =>
          MaterialApp.router(
            routerConfig: AppRouter.router,
            // 🔥 تمرير الـ GoRouter
            title: 'Medora App',
        debugShowCheckedModeBanner: false,
        theme: AppLightTheme.theme,
        themeMode: ThemeMode.light,

        builder: (context, child) {
          return BlocListener<AppSettingsCubit, AppSettingsStates>(
            listenWhen: (previous, current) =>
                previous.internetState != current.internetState,
            listener: (context, state) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _handleInternetStateChange(
                  AppRouter.router.routerDelegate.navigatorKey.currentContext!,
                  state.internetState,
                );
              });
            },
            child: child,
          );
        },
      ),
    );
  }

  void _handleInternetStateChange(
    BuildContext context,
    InternetState internetState,
  ) {
    if (internetState == InternetState.disconnected) {
      OverlayNotificationService.show(
        context: context,

        message: AppStrings.noInternetConnection,
        type: SnackBarType.error,
      );
    } else if (internetState == InternetState.connected) {
      OverlayNotificationService.show(
        context: context,

        message: AppStrings.internetConnected,
        type: SnackBarType.success,
      );
    }
  }
}


class TestScreen extends StatelessWidget {

  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Screen'),),
      body: Center(
        child: Column(
          spacing: 20,
          children: [
            Assets.lottie.successIconLottie.lottie(
              fit: BoxFit.fill,
              height: 100.h,
            ),
          ],
        ),
      ),
    );
  }
}
