



import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart' show BaseUseCase;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart' show DoctorModel;
import 'package:medora/features/search/domain/search_repository_base/search_repository_base.dart' show SearchRepositoryBase;

class SearchDoctorsByNameUseCase extends BaseUseCase<List<DoctorModel>, String> {

  final SearchRepositoryBase searchRepositoryBase;

  SearchDoctorsByNameUseCase({required this.searchRepositoryBase});

  @override
  Future<Either<Failure, List<DoctorModel>>> call(String parameters)  async{
    print('SearchDoctorsByNameUseCase.callxxxxxxxxxxxxxxxxxxxxxxxxx');
    return await   searchRepositoryBase.searchDoctorsByName(doctorName: parameters);

  }
}