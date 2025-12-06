import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart'
    show BaseUseCase, NoParameters;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/doctor_list/domain/repository/doctor_list_repository_base.dart'
    show DoctorListRepositoryBase;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;

class GetDoctorsListUseCase
    extends BaseUseCase<List<DoctorModel>, NoParameters> {
  final DoctorListRepositoryBase doctorListRepositoryBase;

  GetDoctorsListUseCase({required this.doctorListRepositoryBase});

  @override
  Future<Either<Failure, List<DoctorModel>>> call(
    NoParameters parameters,
  ) async {
    return await doctorListRepositoryBase.getDoctorsList();
  }
}
