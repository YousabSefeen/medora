import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medora/features/doctor_profile/data/data_source/cloudinary_remote_data_source.dart'
    show CloudinaryRemoteDataSource;
import 'package:medora/features/doctor_profile/data/data_source/doctor_profile_remote_data_source.dart'
    show DoctorProfileRemoteDataSource;
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;

class DoctorProfileRemoteDataSourceImpl extends DoctorProfileRemoteDataSource {
  final CloudinaryRemoteDataSource _cloudinaryDataSource;
  final FirebaseFirestore _firestore;

  DoctorProfileRemoteDataSourceImpl(
    this._cloudinaryDataSource,
    this._firestore,
  );

  @override
  Future<void> uploadDoctorProfile({
    required DoctorEntity doctorProfile,
  }) async {
    try {
      final uploadedImageUrl = await _cloudinaryDataSource.uploadImage(
        doctorId: doctorProfile.doctorId!,
        filePath: doctorProfile.imageUrl,
      );

      final doctorModel = DoctorModel.fromEntity(doctorProfile);
      await _firestore.collection('doctors').doc(doctorProfile.doctorId).set({
        ...doctorModel.toJson(),
        'imageUrl': uploadedImageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      rethrow;
    }
  }
}
