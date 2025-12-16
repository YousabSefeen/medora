import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart' show Equatable;
import 'package:medora/core/base_use_case/base_use_case.dart' show BaseUseCase;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/appointments/domain/repository/appointment_repository_base.dart'
    show AppointmentRepositoryBase;

class DeleteAppointmentUseCase extends BaseUseCase<void, DeleteAppointmentParams> {
  final AppointmentRepositoryBase appointmentRepositoryBase;

  DeleteAppointmentUseCase({required this.appointmentRepositoryBase});

  @override
  Future<Either<Failure, void>> call(DeleteAppointmentParams params) async {
    return await appointmentRepositoryBase.deleteAppointment(
      appointmentId: params.appointmentId,
      doctorId: params.doctorId,
    );
  }
}

class DeleteAppointmentParams extends Equatable {
  final String appointmentId;
  final String doctorId;

  const DeleteAppointmentParams({
    required this.appointmentId,
    required this.doctorId,
  });

  @override
  List<Object?> get props => [appointmentId, doctorId];
}
