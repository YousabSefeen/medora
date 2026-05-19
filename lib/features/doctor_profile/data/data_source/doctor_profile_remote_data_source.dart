import 'package:medora/features/shared/domain/entities/doctor_entity.dart';

abstract class DoctorProfileRemoteDataSource {
  Future<void> uploadDoctorProfile({required DoctorEntity doctorProfile});
}
