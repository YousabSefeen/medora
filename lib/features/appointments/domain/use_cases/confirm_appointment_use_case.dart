import 'package:dartz/dartz.dart' show Either;
import 'package:medora/core/base_use_case/base_use_case.dart' show BaseUseCase;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/appointments/domain/params/confirm_appointment_params.dart'
    show ConfirmAppointmentParams;
import 'package:medora/features/appointments/domain/repository/appointment_repository_base.dart'
    show AppointmentRepositoryBase;

class ConfirmAppointmentUseCase
    extends BaseUseCase<void, ConfirmAppointmentParams> {
  final AppointmentRepositoryBase appointmentRepositoryBase;

  ConfirmAppointmentUseCase({required this.appointmentRepositoryBase});

  @override
  Future<Either<Failure, void>> call(ConfirmAppointmentParams params) {
    return appointmentRepositoryBase.confirmAppointment(
      queryParams: params.toMap(),
    );
  }
}
