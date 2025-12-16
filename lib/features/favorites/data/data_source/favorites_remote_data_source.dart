import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:medora/features/favorites/data/data_source/favorites_remote_data_source_base.dart'
    show FavoritesRemoteDataSourceBase;
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;

class FavoritesRemoteDataSource extends FavoritesRemoteDataSourceBase {
  final FirebaseFirestore _firestore;
  final String _userId;

  FavoritesRemoteDataSource({String? userId, FirebaseFirestore? firestore})
    : _userId = userId ?? FirebaseAuth.instance.currentUser!.uid,
      _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> addDoctorToFavorites(String doctorId) async {
    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .doc(doctorId)
          .set({'addedAt': FieldValue.serverTimestamp()});
    } catch (e) {
      _logError('addDoctorToFavorites', e);
      rethrow;
    }
  }

  @override
  Future<List<DoctorEntity>> getFavoritesDoctors() async {
    try {
      final favoritesSnapshot = await _getFavoritesSnapshot();

      if (favoritesSnapshot.docs.isEmpty) {
        return [];
      }

      // Get the sorted list of IDs
      final orderedDoctorIds = favoritesSnapshot.docs
          .map((doc) => doc.id)
          .toList();

      final favoriteDoctors = await _getFavoriteDoctors(orderedDoctorIds);

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
      return doctorList.map((doctor) => doctor.toEntity()).toList();
    } catch (e) {
      _logError('getFavoritesDoctors', e);
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> _getFavoriteDoctors(
    List<String> orderedDoctorIds,
  ) async => await _firestore
      .collection('doctors')
      .where(FieldPath.documentId, whereIn: orderedDoctorIds)
      .get();

  Future<QuerySnapshot<Map<String, dynamic>>> _getFavoritesSnapshot() async =>
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .orderBy('addedAt', descending: true)
          .get();

  @override
  Future<bool> isDoctorFavorite(String doctorId) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .doc(doctorId)
          .get();

      return doc.exists;
    } catch (e) {
      _logError('isDoctorFavorite', e);
      rethrow;
    }
  }

  @override
  Future<void> removeDoctorFromFavorites(String doctorId) async {
    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .doc(doctorId)
          .delete();
    } catch (e) {
      _logError('removeDoctorFromFavorites', e);
      rethrow;
    }
  }

  void _logError(String methodName, dynamic error) {
    print('FavoritesRemoteDataSource.$methodName ERROR: $error');
  }
}
