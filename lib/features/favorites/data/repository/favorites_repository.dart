import 'package:cloud_firestore/cloud_firestore.dart'
    show FirebaseFirestore, FieldPath, FieldValue;
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;

import 'favorites_repository_base.dart';

class FavoritesRepository extends FavoritesRepositoryBase {
  final FirebaseFirestore _firestore;
  final String _userId;

  FavoritesRepository({String? userId, FirebaseFirestore? firestore})
    : _userId = userId ?? FirebaseAuth.instance.currentUser!.uid,
      _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<Either<Failure, void>> removeDoctorFromFavorites(
    String doctorId,
  ) async {
    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .doc(doctorId)
          .delete();
      return right(null);
    } catch (e) {
      print('Error removeDoctorFromFavorites:  ${e.toString()}');
      return Left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, void>> addDoctorToFavorites(String doctorId) async {
    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .doc(doctorId)
          .set({'addedAt': FieldValue.serverTimestamp()});

      return right(null);
    } catch (e) {
      print('Error addDoctorToFavorites:  ${e.toString()}');
      return Left(ServerFailure(catchError: e));
    }
  }

  // @override
  // Future<Either<Failure, List<DoctorModel>>> getAllFavorites() async {
  //   try {
  //     final favoritesSnapshot = await _firestore
  //         .collection('users')
  //         .doc(_userId)
  //         .collection('favorites')
  //         .orderBy('addedAt', descending: true)
  //         .get();
  //
  //     if (favoritesSnapshot.docs.isEmpty) {
  //       return right([]);
  //     } else {
  //       // حفظ الترتيب الصحيح في Map
  //       final orderedDoctorIds = favoritesSnapshot.docs
  //           .asMap() // إضافة index للحفاظ على الترتيب
  //           .entries
  //           .map((entry) => MapEntry(entry.value.id, entry.key))
  //           .toList();
  //
  //       final favoriteDoctorIds = orderedDoctorIds.map((e) => e.key).toList();
  //
  //
  //
  //       final favoriteDoctors = await _firestore
  //           .collection('doctors')
  //           .where(FieldPath.documentId, whereIn: favoriteDoctorIds)
  //           .get();
  //
  //       // إنشاء Map للبحث السريع
  //       final doctorsMap = <String, DoctorModel>{};
  //       for (var doc in favoriteDoctors.docs) {
  //         doctorsMap[doc.id] = DoctorModel.fromJson({
  //           'doctorId': doc.id,
  //           ...doc.data(),
  //         });
  //       }
  //
  //       // إعادة الترتيب حسب الترتيب الأصلي
  //       final List<DoctorModel> doctorList = [];
  //       for (var doctorId in favoriteDoctorIds) {
  //         final doctor = doctorsMap[doctorId];
  //         if (doctor != null) {
  //           doctorList.add(doctor);
  //         }
  //       }
  //
  //       print('doctorList[0].doctorId (after reordering): \n\n\n ${doctorList[0].doctorId} ');
  //       return right(doctorList);
  //     }
  //   } catch (e) {
  //     print('Error removeDoctorFromFavorites:  ${e.toString()}');
  //     return Left(ServerFailure(catchError: e));
  //   }
  // }
  @override
  Future<Either<Failure, List<DoctorModel>>> getAllFavorites() async {
    try {
      final favoritesSnapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .orderBy('addedAt', descending: true)
          .get();

      if (favoritesSnapshot.docs.isEmpty) {
        return right([]);
      }

      // Get the sorted list of IDs
      final orderedDoctorIds = favoritesSnapshot.docs
          .map((doc) => doc.id)
          .toList();

      final favoriteDoctors = await _firestore
          .collection('doctors')
          .where(FieldPath.documentId, whereIn: orderedDoctorIds)
          .get();

      // Create a map for quick search
      final doctorsMap = <String, DoctorModel>{};
      for (var doc in favoriteDoctors.docs) {
        doctorsMap[doc.id] = DoctorModel.fromJson({
          'doctorId': doc.id,
          ...doc.data(),
        });
      }

      // Rebuild the list in the original order
      final List<DoctorModel> doctorList = [];
      for (var doctorId in orderedDoctorIds) {
        if (doctorsMap.containsKey(doctorId)) {
          doctorList.add(doctorsMap[doctorId]!);
        }
      }

      return right(doctorList);
    } catch (e) {
      return Left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, Set<String>>> isDoctorFavorite(String doctorId) async {
    try {
      final favoritesSnapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .get();

      final favoriteDoctorIds = favoritesSnapshot.docs.map((d) => d.id).toSet();

      return right(favoriteDoctorIds);
    } catch (e) {
      print('Error isDoctorFavorite:  ${e.toString()}');
      return Left(ServerFailure(catchError: e));
    }
  }
}
