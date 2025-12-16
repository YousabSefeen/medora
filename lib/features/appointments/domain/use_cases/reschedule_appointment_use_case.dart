import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:medora/core/base_use_case/base_use_case.dart' show BaseUseCase;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/appointments/domain/repository/appointment_repository_base.dart'
    show AppointmentRepositoryBase;

class RescheduleAppointmentUseCase
    extends BaseUseCase<void, RescheduleAppointmentParams> {
  final AppointmentRepositoryBase appointmentRepositoryBase;

  RescheduleAppointmentUseCase({required this.appointmentRepositoryBase});

  @override
  Future<Either<Failure, void>> call(RescheduleAppointmentParams params) async {
    return await appointmentRepositoryBase.rescheduleAppointment(
      queryParams: params.toMap(),
    );
  }
}

class RescheduleAppointmentParams extends Equatable {
  final String doctorId;
  final String appointmentId;
  final String appointmentDate;
  final String appointmentTime;

  const RescheduleAppointmentParams({
    required this.doctorId,
    required this.appointmentId,
    required this.appointmentDate,
    required this.appointmentTime,
  });

  Map<String, dynamic> toMap() => {
      'doctorId': doctorId,
      'appointmentId': appointmentId,
      'appointmentDate': appointmentDate,
      'appointmentTime': appointmentTime,
    };

  @override
  List<Object?> get props => [
    doctorId,
    appointmentId,
    appointmentDate,
    appointmentTime,
  ];
}
