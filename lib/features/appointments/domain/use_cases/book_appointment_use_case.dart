import 'package:dartz/dartz.dart' show Either;
import 'package:medora/core/base_use_case/base_use_case.dart' show BaseUseCase;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/appointments/domain/params/book_appointment_params.dart'
    show BookAppointmentParams;
import 'package:medora/features/appointments/domain/repository/appointment_repository_base.dart'
    show AppointmentRepositoryBase;

class BookAppointmentUseCase
    extends BaseUseCase<String, BookAppointmentParams> {
  final AppointmentRepositoryBase appointmentRepositoryBase;

  BookAppointmentUseCase({required this.appointmentRepositoryBase});

  @override
  Future<Either<Failure, String>> call(BookAppointmentParams params) {
    return appointmentRepositoryBase.bookAppointment(
      queryParams: params.toMap(),
    );
  }
}
