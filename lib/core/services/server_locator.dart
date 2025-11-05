import 'package:get_it/get_it.dart';
import 'package:medora/core/payment_gateway_manager/paymob_payment/paymob_services.dart'
    show PaymobServices;
import 'package:medora/core/payment_gateway_manager/paypal_payment/paypal_services.dart'
    show PaypalServices;
import 'package:medora/core/payment_gateway_manager/stripe_payment/stripe_services.dart'
    show StripeServices;
import 'package:medora/core/services/api_services.dart' show ApiServices;
import 'package:medora/features/doctors_specialties/data/repository/specialty_doctors_repository.dart'
    show SpecialtyDoctorsRepository;
import 'package:medora/features/doctors_specialties/presentation/controller/cubit/specialty_doctors_cubit.dart'
    show SpecialtyDoctorsCubit;
import 'package:medora/features/favorites/data/data_source/favorites_remote_data_source.dart'
    show FavoritesRemoteDataSourceBase, FavoritesRemoteDataSource;
import 'package:medora/features/favorites/data/favorites_repository_impl/favorites_repository_impl.dart';
import 'package:medora/features/favorites/data/repository/favorites_repository.dart'
    show FavoritesRepository;
import 'package:medora/features/favorites/domain/favorites_repository_base/favorites_repository_base.dart'
    show FavoritesRepositoryBase;
import 'package:medora/features/favorites/domain/use_cases/is_doctor_favorite_use_case.dart'
    show IsDoctorFavoriteUseCase;
import 'package:medora/features/favorites/domain/use_cases/get_favorites_doctors_use_case.dart'
    show GetFavoritesDoctorsUseCase;
import 'package:medora/features/favorites/domain/use_cases/toggle_favorite_use_case.dart'
    show ToggleFavoriteUseCase;

import 'package:medora/features/favorites/presentation/controller/cubit/favorites_cubit.dart'
    show FavoritesCubit;
import 'package:medora/features/favorites/presentation/controller/cubit/favorites_cubit.dart';
import 'package:medora/features/home/presentation/controller/cubits/bottom_nav_cubit.dart'
    show BottomNavCubit;
import 'package:medora/features/payment_gateways/paymob/data/repository/paymob_repository.dart'
    show PaymobRepository;
import 'package:medora/features/payment_gateways/paymob/presentation/controller/cubit/paymob_payment_cubit.dart'
    show PaymobPaymentCubit;
import 'package:medora/features/payment_gateways/paypal/data/repository/paypal_repository.dart'
    show PaypalRepository;
import 'package:medora/features/payment_gateways/paypal/presentation/controller/cubit/paypal_payment_cubit.dart'
    show PaypalPaymentCubit;
import 'package:medora/features/payment_gateways/stripe/data/repository/stripe_repository.dart'
    show StripeRepository;
import 'package:medora/features/payment_gateways/stripe/presentation/controller/cubit/stripe_payment_cubit.dart'
    show StripePaymentCubit;
import 'package:medora/features/search/data/repository/search_repository.dart'
    show SearchRepository;
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart'
    show SearchCubit;

import '../../features/appointments/data/repository/appointment_repository.dart';
import '../../features/appointments/presentation/controller/cubit/appointment_cubit.dart';
import '../../features/auth/data/repository/auth_repository.dart';
import '../../features/auth/presentation/controller/cubit/login_cubit.dart';
import '../../features/auth/presentation/controller/cubit/register_cubit.dart';
import '../../features/doctor_list/data/repository/doctor_list_repository.dart';
import '../../features/doctor_list/presentation/controller/cubit/doctor_list_cubit.dart';
import '../../features/doctor_profile/data/repository/doctor_profile_repository.dart';
import '../../features/doctor_profile/presentation/controller/cubit/doctor_profile_cubit.dart';
import '../app_settings/controller/cubit/app_settings_cubit.dart';

final serviceLocator = GetIt.instance;

class ServiceLocator {
  void init() {
    initPayments();
    _registerRepositories();
    _registerCubits();
    _registerAppSettings();
    favoritesInit();
    print('ServiceLocator.initxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
  }

  void favoritesInit() {
    /// RemoteDataSource/BaseHomeRepository/Use Case/ Bloc

    // Todo RemoteDataSource

    serviceLocator.registerLazySingleton<FavoritesRemoteDataSourceBase>(
      () => FavoritesRemoteDataSource(),
    );

    //Todo BaseHomeRepository

    serviceLocator.registerLazySingleton<FavoritesRepositoryBase>(
      () => FavoritesRepositoryImpl(
        favoritesRemoteDataSourceBase: serviceLocator(),
      ),
    );

    //Todo Use Case

    ///favorites
    serviceLocator.registerLazySingleton(
      () => IsDoctorFavoriteUseCase(
        favoritesRepositoryBase: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton(
      () => GetFavoritesDoctorsUseCase(favoritesRepositoryBase: serviceLocator()),
    );
    serviceLocator.registerLazySingleton(
      () => ToggleFavoriteUseCase(favoritesRepositoryBase: serviceLocator()),
    );

    //Todo Bloc

    serviceLocator.registerFactory(
      () => FavoritesCubit(
        isDoctorFavoriteUseCase: serviceLocator(),
        getFavoritesDoctorsUseCase: serviceLocator(),
        toggleFavoriteUseCase: serviceLocator(),
      ),
    );

  }

  void _registerRepositories() {
    serviceLocator.registerLazySingleton<AuthRepository>(
      () => AuthRepository(),
    );
    serviceLocator.registerLazySingleton<DoctorProfileRepository>(
      () => DoctorProfileRepository(),
    );
    serviceLocator.registerLazySingleton<DoctorListRepository>(
      () => DoctorListRepository(),
    );
    serviceLocator.registerLazySingleton<AppointmentRepository>(
      () => AppointmentRepository(),
    );
    serviceLocator.registerLazySingleton<SpecialtyDoctorsRepository>(
      () => SpecialtyDoctorsRepository(),
    );
    serviceLocator.registerLazySingleton<SearchRepository>(
      () => SearchRepository(),
    );
    serviceLocator.registerLazySingleton<FavoritesRepository>(
      () => FavoritesRepository(),
    );
  }

  void _registerCubits() {
    serviceLocator.registerFactory<BottomNavCubit>(() => BottomNavCubit());

    serviceLocator.registerFactory<LoginCubit>(
      () => LoginCubit(authRepository: serviceLocator()),
    );

    serviceLocator.registerFactory<RegisterCubit>(
      () => RegisterCubit(authRepository: serviceLocator()),
    );

    serviceLocator.registerFactory<DoctorProfileCubit>(
      () => DoctorProfileCubit(doctorRepository: serviceLocator()),
    );

    serviceLocator.registerFactory<DoctorListCubit>(
      () => DoctorListCubit(doctorListRepository: serviceLocator()),
    );

    serviceLocator.registerFactory<AppointmentCubit>(
      () => AppointmentCubit(
        appSettingsCubit: serviceLocator(),
        appointmentRepository: serviceLocator(),
      ),
    );
    serviceLocator.registerFactory<SpecialtyDoctorsCubit>(
      () => SpecialtyDoctorsCubit(specialtyDoctorsRepository: serviceLocator()),
    );

    serviceLocator.registerFactory<SearchCubit>(
      () => SearchCubit(searchRepository: serviceLocator()),
    );


  }

  void _registerAppSettings() {
    serviceLocator.registerLazySingleton<AppSettingsCubit>(() {
      final cubit = AppSettingsCubit();
      cubit.checkInitialInternetConnection();
      cubit.startMonitoring();
      return cubit;
    });
  }

  void initPayments() {
    /// تسجيل الخدمات الأساسية
    serviceLocator.registerLazySingleton<ApiServices>(() => ApiServices());

    /// خدمات الدفع paymob
    serviceLocator.registerLazySingleton<PaymobServices>(
      () => PaymobServices(apiServices: serviceLocator()),
    );
    serviceLocator.registerLazySingleton<PaymobRepository>(
      () => PaymobRepository(paymobServices: serviceLocator()),
    );

    /// مزود الحالة paymob
    serviceLocator.registerFactory(
      () => PaymobPaymentCubit(paymobRepository: serviceLocator()),
    );

    /// ✅ أضف هذا:

    /// خدمات الدفع stripe
    serviceLocator.registerLazySingleton<StripeServices>(
      () => StripeServices(apiServices: serviceLocator()),
    );
    serviceLocator.registerLazySingleton<StripeRepository>(
      () => StripeRepository(stripeServices: serviceLocator()),
    );
    serviceLocator.registerFactory(
      () => StripePaymentCubit(stripeRepo: serviceLocator()),
    );
    //TODO Paypal
    serviceLocator.registerLazySingleton<PaypalServices>(
      () => PaypalServices(apiServices: serviceLocator()),
    );
    serviceLocator.registerLazySingleton<PaypalRepository>(
      () => PaypalRepository(paypalServices: serviceLocator()),
    );

    serviceLocator.registerFactory(
      () => PaypalPaymentCubit(paypalRepository: serviceLocator()),
    );
    // إذا أردت مستقبلاً:
    // serviceLocator.registerFactory(() => StripePaymentProvider(stripeRepo: serviceLocator()));
  }
}
