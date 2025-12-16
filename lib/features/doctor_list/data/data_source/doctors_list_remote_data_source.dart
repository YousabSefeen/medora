import 'package:cloud_firestore/cloud_firestore.dart'
    show FirebaseFirestore, Query, DocumentSnapshot, QuerySnapshot;
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart'
    show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;

abstract class DoctorsListRemoteDataSourceBase {
  Future<PaginatedDataResponse> getDoctorsList(PaginationParameters parameters);
}

class DoctorsListRemoteDataSource extends DoctorsListRemoteDataSourceBase {
  final FirebaseFirestore _firestore;

  DoctorsListRemoteDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<PaginatedDataResponse> getDoctorsList(
    PaginationParameters parameters,
  ) async {
    Query query = _firestore
        .collection('doctors')
        .limit(parameters.limit)
        .orderBy('createdAt', descending: true);

    if (parameters.lastDocument != null) {
      query = query.startAfterDocument(
        parameters.lastDocument as DocumentSnapshot<Map<String, dynamic>>,
      );
    }

    final QuerySnapshot<Object?> snapshot = await query.get();

    DocumentSnapshot? lastDocument;
    if (snapshot.docs.isNotEmpty) {
      lastDocument = snapshot.docs.last;
    }

    final List<DoctorModel> doctorList = snapshot.docs.map((doc) {
      final doctorData = doc.data() as Map<String, dynamic>;

      return DoctorModel.fromJson({'doctorId': doc.id, ...doctorData});
    }).toList();

    return PaginatedDataResponse(
      doctors: doctorList.map((doctor) => doctor.toEntity()).toList(),
      lastDocument: lastDocument,
      hasMore:
          snapshot.docs.length ==
          parameters.limit, // To determine if there are other pages
    );
  }
}
