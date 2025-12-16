import 'package:json_annotation/json_annotation.dart';
import 'package:medora/features/appointments/domain/entities/appointment_entity.dart'
    show AppointmentEntity;

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

  AppointmentEntity toEntity() => AppointmentEntity(
      clientId: clientId,
      appointmentDate: appointmentDate,
      appointmentTime: appointmentTime,
      appointmentStatus: appointmentStatus,
    );

  factory AppointmentModel.fromEntity(AppointmentEntity entity) => AppointmentModel(
      clientId: entity.clientId,
      appointmentDate: entity.appointmentDate,
      appointmentTime: entity.appointmentTime,
      appointmentStatus: entity.appointmentStatus,
    );
}
