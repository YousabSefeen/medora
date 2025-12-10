import 'package:cloud_firestore/cloud_firestore.dart'
    show FirebaseFirestore, Query, QueryDocumentSnapshot, QuerySnapshot;
import 'package:medora/features/search/domain/value_objects/search_filters/search_filter.dart'
    show SearchFilter;
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;

abstract class SearchRemoteDataSourceBase {
  Future<List<DoctorModel>> searchDoctors(List<SearchFilter> filters);
}

class SearchRemoteDataSource extends SearchRemoteDataSourceBase {
  final FirebaseFirestore _firestore;

  SearchRemoteDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<DoctorModel>> searchDoctors(List<SearchFilter> filters) async {
    Query<Map<String, dynamic>> query = _firestore.collection('doctors');

    for (final filter in filters) {
      query = filter.apply(query);
    }

    final snapshot = await query.limit(10).get();
    final doctorList = _parseSnapshot(snapshot);
    return doctorList;
  }

  List<DoctorModel> _parseSnapshot(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    final doctorList = snapshot.docs.map(_convertToDoctorModel).toList();
    return doctorList;
  }

  DoctorModel _convertToDoctorModel(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final doctorData = doc.data();
    return DoctorModel.fromJson({'doctorId': doc.id, ...doctorData});
  }
}
