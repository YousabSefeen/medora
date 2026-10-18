import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medora/core/constants/firestore_constants/firestore_constants.dart';
import 'package:medora/features/doctor_list/data/data_sources/doctors_list_remote_data_source.dart';
import 'package:medora/features/shared/data/models/doctor_model.dart';
import 'package:medora/features/shared/domain/entities/doctor_entity.dart';
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart';
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart';

class DoctorsListRemoteDataSourceImpl extends DoctorsListRemoteDataSource {
  final FirebaseFirestore _firestore;

  DoctorsListRemoteDataSourceImpl({required this._firestore});

  @override
  Future<PaginatedDataResponse<DoctorEntity>> getDoctorsList(
    PaginationParameters parameters,
  ) async {
    Query query = _firestore
        .collection(FirestoreConstants.doctorsCollection)
        .limit(parameters.limit)
        .orderBy(FirestoreConstants.fieldCreatedAt, descending: true);

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
      list: doctorList.map((doctor) => doctor.toEntity()).toList(),
      lastDocument: lastDocument,
      hasMore:
          snapshot.docs.length ==
          parameters.limit, // To determine if there are other pages
    );
  }
}
