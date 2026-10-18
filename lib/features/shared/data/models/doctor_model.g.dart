// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) => DoctorModel(
  doctorId: json['doctorId'] as String?,
  //xx imageUrl: _getFormattedCloudinaryUrl(json['imageUrl'] as String),
  imageUrl: json['imageUrl'] as String,
  name: json['name'] as String,
  specialties: (json['specialties'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  bio: json['bio'] as String,
  location: json['location'] as String,
  doctorAvailability: DoctorAvailabilityModel.fromJson(
    json['doctorAvailability'] as Map<String, dynamic>,
  ),
  fees: (json['fees'] as num).toInt(),
  patientsCount: (json['patientsCount'] as num).toInt(),
  rating: (json['rating'] as num).toDouble(),
  ratingCount: (json['ratingCount'] as num).toInt(),
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
      'patientsCount': instance.patientsCount,
      'rating': instance.rating,
      'ratingCount': instance.ratingCount,
    };

String _getFormattedCloudinaryUrl(String originalUrl) {
  if (!originalUrl.contains('/upload/')) {
    return originalUrl;
  }

  // استخدام f_png بدلاً من f_auto لضمان الشفافية (Alpha Channel)
  const transformations =
      'c_fill,g_face,w_600,h_800,e_background_removal,q_auto,f_png';

  String formattedUrl = originalUrl.replaceAll(
    '/upload/',
    '/upload/$transformations/',
  );

  // تحويل امتداد الملف دائماً إلى png
  if (formattedUrl.contains('.jpg')) {
    formattedUrl = formattedUrl.replaceAll('.jpg', '.png');
  } else if (formattedUrl.contains('.jpeg')) {
    formattedUrl = formattedUrl.replaceAll('.jpeg', '.png');
  }

  return formattedUrl;
}
