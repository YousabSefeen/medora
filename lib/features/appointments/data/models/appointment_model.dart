import 'package:json_annotation/json_annotation.dart';

part 'appointment_model.g.dart';

@JsonSerializable()
class AppointmentModel {
  final String clientId;
  final String appointmentDate;
  final String appointmentTime;
  final String appointmentStatus;

  AppointmentModel({
    required this.clientId,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.appointmentStatus,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentModelToJson(this);
}
