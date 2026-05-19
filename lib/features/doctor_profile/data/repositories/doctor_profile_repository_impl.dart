import 'package:dartz/dartz.dart';
import 'package:medora/features/doctor_profile/data/data_source/doctor_profile_remote_data_source.dart'
    show DoctorProfileRemoteDataSource;
import 'package:medora/features/doctor_profile/domain/repository/doctor_profile_repository.dart'
    show DoctorProfileRepository;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart';

import '../../../../core/error/failure.dart' show Failure, ServerFailure;

class DoctorProfileRepositoryImpl extends DoctorProfileRepository {
  final DoctorProfileRemoteDataSource profileRemoteDataSource;

  DoctorProfileRepositoryImpl({required this.profileRemoteDataSource});

  @override
  Future<Either<Failure, void>> uploadDoctorProfile(
    DoctorEntity doctorProfile,
  ) async {
    try {
      await profileRemoteDataSource.uploadDoctorProfile(
        doctorProfile: doctorProfile,
      );
      return right(null);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }
}
