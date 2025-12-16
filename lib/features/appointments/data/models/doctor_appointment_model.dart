import 'package:json_annotation/json_annotation.dart';
import 'package:medora/features/appointments/data/models/appointment_model.dart'
    show AppointmentModel;
import 'package:medora/features/appointments/domain/entities/doctor_appointment_entity.dart' show DoctorAppointmentEntity;

part 'doctor_appointment_model.g.dart';

@JsonSerializable()
class DoctorAppointmentModel {
  final String appointmentId;

  final AppointmentModel appointmentModel;

  DoctorAppointmentModel({
    required this.appointmentId,
    required this.appointmentModel,
  });

  factory DoctorAppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorAppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorAppointmentModelToJson(this);



  DoctorAppointmentEntity toEntity() {
    return DoctorAppointmentEntity(

      appointmentId: appointmentId,
      appointmentEntity: appointmentModel.toEntity(),
    );
  }

  factory DoctorAppointmentModel.fromEntity(DoctorAppointmentEntity entity) {
    return DoctorAppointmentModel(

      appointmentId: entity.appointmentId,

      appointmentModel: AppointmentModel.fromEntity(entity.appointmentEntity),

    );
  }
}
