import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../doctor_profile/data/models/doctor_model.dart';
import 'doctor_list_repository_base.dart';

class DoctorListRepository extends DoctorListRepositoryBase {
  @override
  Future<Either<Failure, List<DoctorModel>>> getDoctorList() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('doctors').get();

      // final List<DoctorModel> doctorList =
      //     snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
      //   final combinedData = {
      //     'doctorId': doc.id,
      //     'doctorModel': doc.data(),
      //   };
      //
      //   return DoctorModel.fromJson(combinedData);
      //
      //     }).toList();
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
