import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failure.dart' show Failure, ServerFailure;
import '../models/doctor_model.dart';
import 'doctor_profile_repository_base.dart';

class DoctorProfileRepository extends DoctorProfileRepositoryBase {
  @override
  Future<Either<Failure, void>> uploadDoctorProfile(
      DoctorModel doctorProfile) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(uid)
          .set(doctorProfile.toJson());
      return right(null);
    } catch (e) {
      print('_saveUserDataToFirestore $e');

      return left(ServerFailure(catchError: e));
    }
  }

  Future<void> getDoctors() async {
    final doctors =
        await FirebaseFirestore.instance.collection('doctors').get() as List;
  }


}
