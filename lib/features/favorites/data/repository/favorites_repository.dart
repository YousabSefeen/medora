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
      } else {
        final favoriteDoctorIds = favoritesSnapshot.docs
            .map((d) => d.id)
            .toList();

        ///

        final favoriteDoctors = await _firestore
            .collection('doctors')
            .where(FieldPath.documentId, whereIn: favoriteDoctorIds)
            .get();

        final List<DoctorModel> doctorList = favoriteDoctors.docs.map((doc) {
          final doctorData = doc.data();

          return DoctorModel.fromJson({
            'doctorId': doc.id,
            ...doctorData, // Spread Operator to integrate fields
          });
        }).toList();

        return right(doctorList);
      }
    } catch (e) {
      print('Error removeDoctorFromFavorites:  ${e.toString()}');
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
          .orderBy('addedAt', descending: true)
          .get();

      final favoriteDoctorIds = favoritesSnapshot.docs.map((d) => d.id).toSet();

      return right(favoriteDoctorIds);
    } catch (e) {
      print('Error isDoctorFavorite:  ${e.toString()}');
      return Left(ServerFailure(catchError: e));
    }
  }
}
