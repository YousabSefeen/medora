import 'package:equatable/equatable.dart' show Equatable;

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
