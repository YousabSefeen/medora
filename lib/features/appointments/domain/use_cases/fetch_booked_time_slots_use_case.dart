import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart' show Equatable;
import 'package:medora/core/base_use_case/base_use_case.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/appointments/domain/repository/appointment_repository_base.dart'
    show AppointmentRepositoryBase;

class FetchBookedTimeSlotsUseCase
    extends BaseUseCase<List<String>, FetchBookedTimeSlotsParams> {
  final AppointmentRepositoryBase appointmentRepositoryBase;

  FetchBookedTimeSlotsUseCase({required this.appointmentRepositoryBase});

  @override
  Future<Either<Failure, List<String>>> call(
    FetchBookedTimeSlotsParams params,
  ) async {
    return await appointmentRepositoryBase
        .fetchBookedTimeSlots(queryParams: params.toMap());
  }
}

class FetchBookedTimeSlotsParams extends Equatable {
  final String doctorId;
  final String date;

  const FetchBookedTimeSlotsParams({
    required this.doctorId,
    required this.date,
  });

  Map<String, dynamic> toMap() => {'doctorId': doctorId, 'date': date};

  @override
  List<Object?> get props => [doctorId, date];
}
