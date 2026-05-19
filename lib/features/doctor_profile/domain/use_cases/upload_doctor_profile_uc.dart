import 'package:dartz/dartz.dart' show Either;
import 'package:medora/core/base_use_case/base_use_case.dart' show BaseUseCase;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/doctor_profile/domain/repository/doctor_profile_repository.dart'
    show DoctorProfileRepository;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;

class UploadDoctorProfileUC extends BaseUseCase<void, DoctorEntity> {
  final DoctorProfileRepository doctorProfileRepositoryBase;

  UploadDoctorProfileUC({required this.doctorProfileRepositoryBase});

  @override
  Future<Either<Failure, void>> call(DoctorEntity params) {
    return doctorProfileRepositoryBase.uploadDoctorProfile(params);
  }
}
