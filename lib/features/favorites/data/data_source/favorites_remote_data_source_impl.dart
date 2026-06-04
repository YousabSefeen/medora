import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medora/core/constants/firestore_constants/firestore_constants.dart'
    show FirestoreConstants;
import 'package:medora/features/favorites/data/data_source/favorites_remote_data_source_base.dart'
    show FavoritesRemoteDataSourceBase;
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart'
    show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;

class FavoritesRemoteDataSource extends FavoritesRemoteDataSourceBase {
  final FirebaseFirestore _firestore;
  final String _userId;

  FavoritesRemoteDataSource({
    required FirebaseFirestore firestore,
    required String userId,
  }) : _firestore = firestore,
       _userId = userId;

  /// Fetches a paginated list of favorite doctors.
  ///
  /// Strategy:
  /// 1. Query the user's favorites sub-collection to get a page of doctor IDs.
  /// 2. Fetch the full doctor details from the global 'doctors' collection using [whereIn].
  /// 3. Sort the results manually to match the user's saved preference order.
  @override
  Future<PaginatedDataResponse<DoctorEntity>> getFavoritesDoctors(
    PaginationParameters parameters,
  ) async {
    // Paginate the reference collection first to minimize data transfer.
    Query<Map<String, dynamic>> query = _favoritesCollection()
        .orderBy(FirestoreConstants.fieldCreatedAt, descending: true)
        .limit(parameters.limit);

    if (parameters.lastDocument != null) {
      query = query.startAfterDocument(
        parameters.lastDocument as DocumentSnapshot<Map<String, dynamic>>,
      );
    }

    final snapshot = await query.get();

    if (snapshot.docs.isEmpty) {
      return PaginatedDataResponse(list: [], hasMore: false);
    }

    // Use 'whereIn' to batch-fetch doctor profiles.
    // Note: Firestore 'whereIn' is limited to 30 items per query.
    final doctorIds = snapshot.docs.map((doc) => doc.id).toList();

    final doctorsSnapshot = await _firestore
        .collection(FirestoreConstants.doctorsCollection)
        .where(FieldPath.documentId, whereIn: doctorIds)
        .get();

    final doctorsList = doctorsSnapshot.docs.map((doc) {
      return DoctorModel.fromJson({
        'doctorId': doc.id,
        ...doc.data(),
      }).toEntity();
    }).toList();

    // Firestore 'whereIn' does not guarantee order.
    // Manual sorting is required to maintain the user's original favoriting sequence.
    doctorsList.sort(
      (a, b) => doctorIds
          .indexOf(a.doctorId!)
          .compareTo(doctorIds.indexOf(b.doctorId!)),
    );

    return PaginatedDataResponse(
      list: doctorsList,
      lastDocument: snapshot.docs.last,
      hasMore: snapshot.docs.length == parameters.limit,
    );
  }

  /// Toggles favorite status: deletes if currently saved, adds if not.
  /// Using this consolidated method reduces code duplication in the Repository/UseCase.
  @override
  Future<void> toggleFavorite({
    required String doctorId,
    required bool isCurrentlyFavorite,
  }) async {
    if (isCurrentlyFavorite) {
      await _favoritesCollection().doc(doctorId).delete();
    } else {
      await _favoritesCollection().doc(doctorId).set({
        FirestoreConstants.fieldCreatedAt: FieldValue.serverTimestamp(),
      });
    }
  }

  /// Fetches all favorite IDs.
  /// This is essential for syncing the "Heart Icon" state globally across the app.
  @override
  Future<List<String>> getFavoriteIds() async {
    final snapshot = await _favoritesCollection().get();
    return snapshot.docs.map((doc) => doc.id).toList();
  }

  /// Helper to get the specific sub-collection path for the current user.
  CollectionReference<Map<String, dynamic>> _favoritesCollection() => _firestore
      .collection(FirestoreConstants.usersCollection)
      .doc(_userId)
      .collection(FirestoreConstants.favoritesCollection);

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

  void _logError(String methodName, dynamic error) {
    print('FavoritesRemoteDataSource.$methodName ERROR: $error');
  }
}
