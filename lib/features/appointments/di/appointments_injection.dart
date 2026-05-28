import 'package:get_it/get_it.dart';
import 'package:medora/features/appointments/data/data_source/appointment_remote_data_source.dart'
    show AppointmentRemoteDataSource;
import 'package:medora/features/appointments/data/data_source/appointment_remote_data_source_base.dart'
    show AppointmentRemoteDataSourceBase;
import 'package:medora/features/appointments/data/data_source/patient_local_data_source.dart' show PatientLocalDataSource, PatientLocalDataSourceImpl;
import 'package:medora/features/appointments/data/repository/appointment_repository_impl.dart'
    show AppointmentRepositoryImpl;
import 'package:medora/features/appointments/domain/repository/appointment_repository_base.dart'
    show AppointmentRepositoryBase;
import 'package:medora/features/appointments/domain/use_cases/book_appointment_use_case.dart'
    show BookAppointmentUseCase;
import 'package:medora/features/appointments/domain/use_cases/cancel_appointment_use_case.dart'
    show CancelAppointmentUseCase;
import 'package:medora/features/appointments/domain/use_cases/confirm_appointment_use_case.dart'
    show ConfirmAppointmentUseCase;
import 'package:medora/features/appointments/domain/use_cases/delete_appointment_use_case.dart'
    show DeleteAppointmentUseCase;
import 'package:medora/features/appointments/domain/use_cases/fetch_booked_time_slots_use_case.dart'
    show FetchBookedTimeSlotsUseCase;
import 'package:medora/features/appointments/domain/use_cases/fetch_cancelled_appointment_uc.dart'
    show FetchCancelledAppointmentUC;
import 'package:medora/features/appointments/domain/use_cases/fetch_completed_appointment_uc.dart'
    show FetchCompletedAppointmentUC;
import 'package:medora/features/appointments/domain/use_cases/fetch_doctor_appointments_use_case.dart'
    show FetchDoctorAppointmentsUseCase;
import 'package:medora/features/appointments/domain/use_cases/fetch_upcoming_appointment_uc.dart'
    show FetchUpcomingAppointmentUC;
import 'package:medora/features/appointments/domain/use_cases/get_cached_patient_data_use_case.dart'
    show GetCachedPatientDataUseCase;
import 'package:medora/features/appointments/domain/use_cases/reschedule_appointment_use_case.dart'
    show RescheduleAppointmentUseCase;
import 'package:medora/features/appointments/domain/use_cases/save_patient_data_use_case.dart'
    show SavePatientDataUseCase;
import 'package:medora/features/appointments/presentation/controller/cubit/book_appointment_cubit.dart'
    show BookAppointmentCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/cancel_appointment_cubit.dart'
    show CancelAppointmentCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/cancelled_appointments_cubit.dart'
    show CancelledAppointmentsCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/completed_appointments_cubit.dart'
    show CompletedAppointmentsCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/confirm_pending_appointment_cubit.dart'
    show ConfirmPendingAppointmentCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/doctor_appointments_cubit.dart'
    show DoctorAppointmentsCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/patient_cubit.dart' show PatientCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/reschedule_appointment_cubit.dart'
    show RescheduleAppointmentCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/time_slot_cubit.dart'
    show TimeSlotCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/upcoming_appointments_cubit.dart'
    show UpcomingAppointmentsCubit;

import '../../../core/di/injection_container.dart' show sl;





Future<void> initAppointmentsDependencies() async {
  // 1. Data Source
  sl.registerLazySingleton<AppointmentRemoteDataSourceBase>(
    () => AppointmentRemoteDataSource(),
  );
  sl.registerLazySingleton<PatientLocalDataSource>(
        () => PatientLocalDataSourceImpl( sl()), // sl() سيجلب الـ SharedPreferences المسجل مسبقاً
  );
  // 2. Repository
  sl.registerLazySingleton<AppointmentRepositoryBase>(
    () => AppointmentRepositoryImpl(remoteDataSource: sl(), patientLocalDataSource:  sl()),
  );

  // 3. Use Cases (مجموعة المواعيد)
  sl.registerLazySingleton(() => SavePatientDataUseCase(appointmentRepositoryBase: sl()));
  sl.registerLazySingleton(() => GetCachedPatientDataUseCase(appointmentRepositoryBase: sl()));

  sl.registerLazySingleton(
    () => CancelAppointmentUseCase(appointmentRepositoryBase: sl()),
  );
  sl.registerLazySingleton(
    () => DeleteAppointmentUseCase(appointmentRepositoryBase: sl()),
  );
  sl.registerLazySingleton(
    () => FetchDoctorAppointmentsUseCase(appointmentRepositoryBase: sl()),
  );
  sl.registerLazySingleton(
    () => FetchBookedTimeSlotsUseCase(appointmentRepositoryBase: sl()),
  );
  sl.registerLazySingleton(
    () => BookAppointmentUseCase(appointmentRepositoryBase: sl()),
  );
  sl.registerLazySingleton(
    () => ConfirmAppointmentUseCase(appointmentRepositoryBase: sl()),
  );
  sl.registerLazySingleton(
    () => RescheduleAppointmentUseCase(appointmentRepositoryBase: sl()),
  );
  sl.registerLazySingleton(() => FetchUpcomingAppointmentUC(repository: sl()));
  sl.registerLazySingleton(
    () => FetchCompletedAppointmentUC(appointmentRepositoryBase: sl()),
  );
  sl.registerLazySingleton(() => FetchCancelledAppointmentUC(repository: sl()));

  // 4. Cubits
  sl.registerFactory(
    () => DoctorAppointmentsCubit(fetchDoctorAppointmentsUS: sl()),
  );
  sl.registerFactory(
    () => ConfirmPendingAppointmentCubit(
      appSettingsCubit: sl(),
      confirmPendingAppointmentUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => BookAppointmentCubit(
      appSettingsCubit: sl(),
      bookAppointmentUseCase: sl(),
    ),
  );
  sl.registerFactory(() => UpcomingAppointmentsCubit(useCase: sl()));
  sl.registerFactory(() => CompletedAppointmentsCubit(useCase: sl()));
  sl.registerFactory(() => CancelledAppointmentsCubit(useCase: sl()));
  sl.registerFactory(() => TimeSlotCubit(fetchBookedTimeSlotsUseCase: sl()));
  sl.registerFactory(
    () => CancelAppointmentCubit(
      appSettingsCubit: sl(),
      cancelAppointmentUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => RescheduleAppointmentCubit(
      appSettingsCubit: sl(),
      rescheduleAppointmentUseCase: sl(),
    ),
  );

  /// يحتاج الي تعديل



  sl.registerFactory<PatientCubit>(
        () => PatientCubit(  savePatientDataUseCase: sl(), getCachedPatientDataUseCase: sl()),
  );
}
