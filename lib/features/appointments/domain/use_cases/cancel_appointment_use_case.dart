import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart' show BaseUseCase;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/appointments/domain/params/cancel_appointments_params.dart' show CancelAppointmentsParams;
import 'package:medora/features/appointments/domain/repository/appointment_repository_base.dart'
    show AppointmentRepositoryBase;

class CancelAppointmentUseCase extends BaseUseCase<void, CancelAppointmentsParams> {
  final AppointmentRepositoryBase appointmentRepositoryBase;

  CancelAppointmentUseCase({required this.appointmentRepositoryBase});

  @override
  Future<Either<Failure, void>> call(CancelAppointmentsParams params) async {
    return await appointmentRepositoryBase.cancelAppointment(
      queryParams: params.toMap(),
    );
  }
}


