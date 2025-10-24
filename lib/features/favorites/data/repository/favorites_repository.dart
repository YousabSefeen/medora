import 'package:cloud_firestore/cloud_firestore.dart'
    show FirebaseFirestore, FieldPath, FieldValue;
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medora/core/error/failure.dart';

import 'favorites_repository_base.dart';

class FavoritesRepository extends FavoritesRepositoryBase {
  final FirebaseFirestore _firestore;

  FavoritesRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<Either<Failure, void>> addDoctorToFavorites(String doctorId) async {
    try {
      final _userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
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
      final _userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
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
  Future<Either<Failure, List<String>>> getFavorites() async {
    try {
      final _userId = FirebaseAuth.instance.currentUser!.uid;
      final doctorId = 'E4Avs8iXKmMxNM7OaIhkHjmebvi1';
      final favoritesSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .orderBy('addedAt', descending: true)
          .get();


      final favoriteDoctorIds = favoritesSnapshot.docs
          .map((d) => d.id)
          .toList();


       bool isDoctorFavorite = favoriteDoctorIds.contains(doctorId);

      ///

      final favoriteDoctors = await FirebaseFirestore.instance
          .collection('doctors')
          .where(FieldPath.documentId, whereIn: favoriteDoctorIds)
          .get();
      print('Success ${favoriteDoctors.docs.length}');

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .doc(doctorId)
          .get();

      final isFavorite = doc.exists;
      print('isFavorite $isFavorite');
      print('Success ${favoriteDoctors.docs.length}');
      return right([]);
    } catch (e) {
      print('Error removeDoctorFromFavorites:  ${e.toString()}');
      return Left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, Set<String> >> isDoctorFavorite(String doctorId) async{
    try{
      final _userId = FirebaseAuth.instance.currentUser!.uid;
      final favoritesSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .orderBy('addedAt', descending: true)
          .get();


      final favoriteDoctorIds = favoritesSnapshot.docs
          .map((d) => d.id)
          .toSet();

      return right(favoriteDoctorIds);
    }catch(e){
      print('Error isDoctorFavorite:  ${e.toString()}');
      return Left(ServerFailure(catchError: e));
    }
  }
}
