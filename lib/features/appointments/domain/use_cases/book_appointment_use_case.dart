import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart' show Equatable;
import 'package:medora/core/base_use_case/base_use_case.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/appointments/domain/entities/book_appointment_entity.dart'
    show BookAppointmentEntity;
import 'package:medora/features/appointments/domain/repository/appointment_repository_base.dart'
    show AppointmentRepositoryBase;

class BookAppointmentUseCase extends BaseUseCase<void, BookAppointmentParams> {
  final AppointmentRepositoryBase appointmentRepositoryBase;

   BookAppointmentUseCase({required this.appointmentRepositoryBase});

  @override
  Future<Either<Failure, void>> call(BookAppointmentParams params) async {
    return await appointmentRepositoryBase.bookAppointment(
      doctorId: params.doctorId,
      bookAppointmentEntity: params.bookAppointmentEntity,
    );
  }
}

class BookAppointmentParams extends Equatable {
  final String doctorId;
  final BookAppointmentEntity bookAppointmentEntity;

  const BookAppointmentParams({
    required this.doctorId,
    required this.bookAppointmentEntity,
  });

  @override
  List<Object?> get props => [doctorId, bookAppointmentEntity];
}
