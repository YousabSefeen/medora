import 'package:cloud_firestore/cloud_firestore.dart'
    show FirebaseFirestore, FieldValue, FieldPath;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;

abstract class FavoritesRemoteDataSourceBase {
  Future<bool> isDoctorFavorite(String doctorId);

  Future<List<DoctorModel>> getFavoritesDoctors();

  Future<void> addDoctorToFavorites(String doctorId);

  Future<void> removeDoctorFromFavorites(String doctorId);
}

class FavoritesRemoteDataSource extends FavoritesRemoteDataSourceBase {
  final FirebaseFirestore _firestore;
  final String _userId;

  FavoritesRemoteDataSource({String? userId, FirebaseFirestore? firestore})
    : _userId = userId ?? FirebaseAuth.instance.currentUser!.uid,
      _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> addDoctorToFavorites(String doctorId) async {
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('favorites')
        .doc(doctorId)
        .set({'addedAt': FieldValue.serverTimestamp()});
  }

  @override
  Future<List<DoctorModel>> getFavoritesDoctors() async {
    final favoritesSnapshot = await _firestore
        .collection('users')
        .doc(_userId)
        .collection('favorites')
        .orderBy('addedAt', descending: true)
        .get();

    if (favoritesSnapshot.docs.isEmpty) {
      return [];
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
    return doctorList;
  }

  @override
  Future<bool> isDoctorFavorite(String doctorId) async {
    final doc = await _firestore
        .collection('users')
        .doc(_userId)
        .collection('favorites')
        .doc(doctorId)
        .get();

    return doc.exists;
  }

  @override
  Future<void> removeDoctorFromFavorites(String doctorId) async =>
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .doc(doctorId)
          .delete();
}
