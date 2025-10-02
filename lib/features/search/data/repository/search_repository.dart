import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:dartz/dartz.dart';
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart' show DoctorModel;
import 'package:medora/features/search/data/repository/search_repository_base.dart' show SearchRepositoryBase;

import '../../../../core/error/failure.dart' show Failure,ServerFailure;

class SearchRepository extends SearchRepositoryBase {
  @override
  Future<Either<Failure, List<DoctorModel>>> searchDoctorsByName(
      {required String doctorName}) async {


    try { final String startAt = doctorName;final String endAt = '$doctorName\uf8ff';

      final snapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .where('name', isGreaterThanOrEqualTo: startAt)
          .where('name', isLessThanOrEqualTo: endAt)
          .limit(10)
          .get();

      final List<DoctorModel> doctorList = snapshot.docs.map((doc) {
        final doctorData = doc.data();

        return DoctorModel.fromJson({
          'doctorId': doc.id,
          ...doctorData,
        });
      }).toList();
      return right(doctorList);
    } catch (e) {
      print('SearchRepository.searchDoctorsByName $e');

      return left(ServerFailure(catchError: e));
    }
  }
}
