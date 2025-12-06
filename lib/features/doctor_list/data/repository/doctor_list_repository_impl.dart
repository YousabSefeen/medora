/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:medora/features/doctor_list/domain/repository/doctor_list_repository_base.dart'
    show DoctorListRepositoryBase;

import '../../../../core/error/failure.dart';
import '../../../doctor_profile/data/models/doctor_model.dart';

class DoctorListRepositoryImpl extends DoctorListRepositoryBase {
  @override
  Future<Either<Failure, List<DoctorModel>>> getDoctorsList() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('doctors').get();

      final List<DoctorModel> doctorList = snapshot.docs.map((doc) {
        try {
          final doctorData = doc.data();

          return DoctorModel.fromJson({
            'doctorId': doc.id,
            ...doctorData, // Spread Operator to integrate fields
          });
        } catch (e) {
          // معالجة الأخطاء بشكل مناسب
          print('Error deserializing doctor document ${doc.id}: $e');
          throw Exception('Failed to deserialize doctor data: ${e.toString()}');
        }
      }).toList();
      return right(doctorList);
    } catch (e) {
      print('DoctorListRepository.getAllDoctorsError $e');

      return left(ServerFailure(catchError: e));
    }
  }
}
*/

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
