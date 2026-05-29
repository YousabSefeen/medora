import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart' show BaseUseCase;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/appointments/domain/params/delete_appointment_params.dart'
    show DeleteAppointmentParams;
import 'package:medora/features/appointments/domain/repository/appointment_repository.dart'
    show AppointmentRepository;

class DeleteAppointmentUseCase
    extends BaseUseCase<void, DeleteAppointmentParams> {
  final AppointmentRepository appointmentRepositoryBase;

  DeleteAppointmentUseCase({required this.appointmentRepositoryBase});

  @override
  Future<Either<Failure, void>> call(DeleteAppointmentParams params) async {
    return await appointmentRepositoryBase.deleteAppointment(
      queryParams: params.toMap(),
    );
  }
}
