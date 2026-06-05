import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart'
    show HydratedBloc, HydratedStorage, HydratedStorageDirectory;
import 'package:intl/date_symbol_data_local.dart';
import 'package:medora/core/app_settings/controller/cubit/app_settings_cubit.dart'
    show AppSettingsCubit;
import 'package:medora/core/constants/app_alerts/app_alerts.dart';
import 'package:medora/core/di/injection_container.dart'
    show sl, ServiceLocator;
import 'package:medora/core/enum/internet_state.dart' show InternetState;
import 'package:medora/features/appointments/presentation/controller/cubit/book_appointment_cubit.dart'
    show BookAppointmentCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/cancel_appointment_cubit.dart'
    show CancelAppointmentCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/cancelled_appointments_cubit.dart'
    show CancelledAppointmentsCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/completed_appointments_cubit.dart'
    show CompletedAppointmentsCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/doctor_appointments_cubit.dart'
    show DoctorAppointmentsCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/time_slot_cubit.dart'
    show TimeSlotCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/upcoming_appointments_cubit.dart'
    show UpcomingAppointmentsCubit;
import 'package:medora/features/auth/presentation/controller/cubit/login_cubit.dart'
    show LoginCubit;
import 'package:medora/features/auth/presentation/screens/login_screen.dart'
    show LoginScreen;
import 'package:medora/features/favorites/presentation/controller/cubit/favorites_cubit.dart'
    show FavoritesCubit;
import 'package:medora/features/favorites/presentation/controller/cubit/favorites_cubit.dart';
import 'package:medora/features/home/presentation/controller/cubits/bottom_nav_cubit.dart'
    show BottomNavCubit;
import 'package:medora/features/home/presentation/screens/bottom_nav_screen.dart'
    show BottomNavScreen;
import 'package:medora/features/patient/presentation/controllers/cubit/patient_cubit.dart'
    show PatientCubit;
import 'package:medora/features/search/presentation/controller/cubit/home_doctor_search_cubit.dart' show HomeDoctorSearchCubit;
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;

import 'Core/payment_gateway_manager/stripe_payment/stripe_keys.dart';
import 'core/app_settings/controller/states/app_settings_states.dart';
import 'core/base/my_bloc_observer.dart';
import 'core/constants/app_routes/app_router.dart';
import 'core/constants/themes/app_light_theme.dart';
import 'features/auth/presentation/controller/cubit/register_cubit.dart';
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
  await Future.wait([
    initializeDateFormatting('en_US'),
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    dotenv.load(fileName: '.env'),
  ]);
  Stripe.publishableKey = StripeKeys.publishableKey;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<HomeDoctorSearchCubit>()),

        BlocProvider(create: (_) => sl<FavoritesCubit>()..fetchFavoriteIds()),

        BlocProvider(create: (_) => sl<BottomNavCubit>()),
        BlocProvider(create: (_) => sl<LoginCubit>()),
        BlocProvider(create: (_) => sl<RegisterCubit>()),

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

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        // useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        navigatorKey: navigatorKey,
        title: 'Flutter Task',
        debugShowCheckedModeBanner: false,
        theme: AppLightTheme.theme,
        themeMode: ThemeMode.light,
        onGenerateRoute: AppRouter.generateRoute,
        builder: (context, child) {
          return BlocListener<AppSettingsCubit, AppSettingsStates>(
            listenWhen: (previous, current) =>
                previous.internetState != current.internetState,
            listener: (context, state) =>
                _handleInternetStateChange(context, state.internetState),
            child: child,
          );
        },
        home: FirebaseAuth.instance.currentUser?.uid != null
            ? const BottomNavScreen()
            : const LoginScreen(),
      ),
    );
  }

  void _handleInternetStateChange(
    BuildContext context,
    InternetState internetState,
  ) {
    if (internetState == InternetState.disconnected) {
      AppAlerts.showInternetAlert(context, false);
    } else if (internetState == InternetState.connected) {
      AppAlerts.showInternetAlert(context, true);
    }
  }
}
