// import 'package:dartz/dartz.dart';
// import 'package:medora/core/base_use_case/base_use_case.dart';
// import 'package:medora/core/error/failure.dart';
// import 'package:medora/features/user/domain/entities/user_entity.dart';
//
// import '../../../shared/domain/entities/doctor_entity.dart';
// import '../repositories/doctors_list_repository.dart';
// import '../repositories/user_repository.dart';
//
// class FetchDoctorData extends BaseUseCase<UserEntity, String> {
//   final DoctorsListRepository doctorsListRepository;
//
//   FetchDoctorData({required this.doctorsListRepository});
//
//   @override
//   Future<Either<Failure, DoctorEntity>> call(String id) async {
//     return await doctorsListRepository.fetchDoctorData(id: id);
//   }
// }
