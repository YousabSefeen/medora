import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medora/core/constants/firestore_constants/firestore_constants.dart'
    show FirestoreConstants;
import 'package:medora/features/favorites/data/data_source/favorites_remote_data_source_base.dart'
    show FavoritesRemoteDataSourceBase;
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;

class FavoritesRemoteDataSource extends FavoritesRemoteDataSourceBase {
  final FirebaseFirestore _firestore;
  final String _userId;

  FavoritesRemoteDataSource({
    required FirebaseFirestore firestore,
    required String userId,
  }) : _firestore = firestore,
       _userId = userId;

  @override
  Future<List<DoctorEntity>> getFavoritesDoctors() async {
    try {
      final favoritesSnapshot = await _getFavoritesSnapshot();
      if (favoritesSnapshot.docs.isEmpty) return [];

      final orderedIds = favoritesSnapshot.docs.map((doc) => doc.id).toList();

      // تقسيم الأي دي إلى دفعات (30 لكل دفعة) لتفادي حدود Firestore
      final chunks = _chunkList(orderedIds, 30);
      final List<DoctorModel> allDoctors = [];

      for (var chunk in chunks) {
        final querySnapshot = await _firestore
            .collection(FirestoreConstants.doctorsCollection)
            .where(FieldPath.documentId, whereIn: chunk)
            .get();

        allDoctors.addAll(
          querySnapshot.docs.map(
            (doc) => DoctorModel.fromJson({'doctorId': doc.id, ...doc.data()}),
          ),
        );
      }

      return _mapToOrderedEntities(allDoctors, orderedIds);
    } catch (e) {
      _logError('getFavoritesDoctors', e);
      rethrow;
    }
  }

  // دالة مساعدة لترتيب البيانات بناءً على الترتيب الأصلي في المفضلة
  List<DoctorEntity> _mapToOrderedEntities(
    List<DoctorModel> doctors,
    List<String> orderedIds,
  ) {
    final doctorsMap = {for (var doc in doctors) doc.doctorId: doc};

    return orderedIds
        .where((id) => doctorsMap.containsKey(id))
        .map((id) => doctorsMap[id]!.toEntity())
        .toList();
  }

  // دالة تقسيم القوائم (Chunks) لتفادي حد الـ 30 عنصر
  List<List<T>> _chunkList<T>(List<T> list, int size) {
    List<List<T>> chunks = [];
    for (int i = 0; i < list.length; i += size) {
      chunks.add(
        list.sublist(i, i + size > list.length ? list.length : i + size),
      );
    }
    return chunks;
  }

  @override
  Future<void> addDoctorToFavorites(String doctorId) async {
    try {
      await _favoritesCollection().doc(doctorId).set({
        FirestoreConstants.fieldCreatedAt: FieldValue.serverTimestamp(),
      });
    } catch (e) {
      _logError('addDoctorToFavorites', e);
      rethrow;
    }
  }

  @override
  Future<void> removeDoctorFromFavorites(String doctorId) async {
    try {
      await _favoritesCollection().doc(doctorId).delete();
    } catch (e) {
      _logError('removeDoctorFromFavorites', e);
      rethrow;
    }
  }

  @override
  Future<List<String>> getFavoriteIds() async {
    try {
      final snapshot = await _favoritesCollection().get();
      return snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      _logError('getFavoriteIds', e);
      rethrow;
    }
  }

  // دوال مساعدة لتقليل التكرار
  CollectionReference<Map<String, dynamic>> _favoritesCollection() => _firestore
      .collection(FirestoreConstants.usersCollection)
      .doc(_userId)
      .collection(FirestoreConstants.favoritesCollection);

  Future<QuerySnapshot<Map<String, dynamic>>> _getFavoritesSnapshot() async =>
      await _favoritesCollection()
          .orderBy(FirestoreConstants.fieldCreatedAt, descending: true)
          .get();

  void _logError(String methodName, dynamic error) {
    print('FavoritesRemoteDataSource.$methodName ERROR: $error');
  }
}
