import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart' show Equatable;
import 'package:medora/core/base_use_case/base_use_case.dart' show BaseUseCase;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/appointments/domain/repository/appointment_repository_base.dart'
    show AppointmentRepositoryBase;

class CancelAppointmentUseCase extends BaseUseCase<void, CancelAppointmentsParams> {
  final AppointmentRepositoryBase appointmentRepositoryBase;

  CancelAppointmentUseCase({required this.appointmentRepositoryBase});

  @override
  Future<Either<Failure, void>> call(CancelAppointmentsParams params) async {
    return await appointmentRepositoryBase.cancelAppointment(
      doctorId: params.doctorId,
      appointmentId: params.appointmentId,
    );
  }
}

class CancelAppointmentsParams extends Equatable {
  final String doctorId;
  final String appointmentId;

  const CancelAppointmentsParams({
    required this.doctorId,
    required this.appointmentId,
  });

  @override

  List<Object?> get props => [doctorId, appointmentId];
}
