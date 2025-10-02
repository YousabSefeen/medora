
import 'package:json_annotation/json_annotation.dart';

part 'book_appointment_model.g.dart';

@JsonSerializable()


class BookAppointmentModel {


  final String patientName;
  final String patientGender;
  final String patientAge;
  final String patientProblem;

  final String appointmentStatus;
  final String appointmentDate;
  final String appointmentTime;

  BookAppointmentModel({

    required this.patientName,
    required this.patientGender,
    required this.patientAge,
    required this.patientProblem,
    required this.appointmentStatus,
    required this.appointmentDate,
    required this.appointmentTime,
  });

  factory BookAppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$BookAppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookAppointmentModelToJson(this);
}
