// import 'package:dartz/dartz.dart';
// import 'package:medora/core/base_use_case/base_use_case.dart'
//     show BaseUseCase, NoParams;
// import 'package:medora/core/error/failure.dart';
// import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
//     show ClientAppointmentsEntity;
// import 'package:medora/features/appointments/domain/repository/appointment_repository_base.dart'
//     show AppointmentRepositoryBase;
//
// class FetchClientAppointmentsUseCase
//     extends BaseUseCase<List<ClientAppointmentsEntity>?, NoParams> {
//   final AppointmentRepositoryBase appointmentRepositoryBase;
//
//   FetchClientAppointmentsUseCase({
//     required this.appointmentRepositoryBase,
//   });
//
//   @override
//   Future<Either<Failure, List<ClientAppointmentsEntity>?>> call(
//     NoParams params,
//   ) async {
//     return await appointmentRepositoryBase
//         .fetchClientAppointments();
//   }
// }
