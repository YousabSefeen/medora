// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) => DoctorModel(
      doctorId: json['doctorId'] as String?,
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,

      specialties: (json['specialties'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      bio: json['bio'] as String,
      location: json['location'] as String,
      doctorAvailability: DoctorAvailabilityModel.fromJson(
          json['doctorAvailability'] as Map<String, dynamic>),
      fees: (json['fees'] as num).toInt(),
    );

Map<String, dynamic> _$DoctorModelToJson(DoctorModel instance) =>
    <String, dynamic>{
      'doctorId': instance.doctorId,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'specialties': instance.specialties,
      'bio': instance.bio,
      'location': instance.location,
          'doctorAvailability': instance.doctorAvailability.toJson(),
      'fees': instance.fees,
    };
