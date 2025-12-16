import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:dartz/dartz.dart';
import 'package:medora/features/doctors_specialties/data/repository/specialty_doctors_repository_base.dart'
    show SpecialtyDoctorsRepositoryBase;
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart' show DoctorEntity;

import '../../../../core/error/failure.dart' show Failure, ServerFailure;

class SpecialtyDoctorsRepository extends SpecialtyDoctorsRepositoryBase {
  @override
  Future<Either<Failure, List<DoctorEntity>>> getDoctorsBySpecialty({
    required String specialtyName,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .where('specialties', arrayContains: specialtyName)
          .limit(10)
          .get();
      final List<DoctorModel> doctorList = snapshot.docs.map((doc) {
        final doctorData = doc.data();

        return DoctorModel.fromJson({
          'doctorId': doc.id,
          ...doctorData, // Spread Operator to integrate fields
        });
      }).toList();
      return right(doctorList.map((doctor) => doctor.toEntity()).toList());
    } catch (e) {
      print('DoctorListRepository.getAllDoctorsError $e');

      return left(ServerFailure(catchError: e));
    }
  }
}
