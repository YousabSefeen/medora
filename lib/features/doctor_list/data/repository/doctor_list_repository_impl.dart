import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/doctor_list/data/data_source/doctors_list_remote_data_source.dart'
    show DoctorsListRemoteDataSource;
import 'package:medora/features/doctor_list/domain/repository/doctor_list_repository_base.dart'
    show DoctorListRepositoryBase;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart';

class DoctorListRepositoryImpl extends DoctorListRepositoryBase {
  final DoctorsListRemoteDataSource dataSource;

  DoctorListRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<DoctorModel>>> getDoctorsList() async {
    try {
      final doctorList = await dataSource.getDoctorsList();
      return right(doctorList);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }
}
