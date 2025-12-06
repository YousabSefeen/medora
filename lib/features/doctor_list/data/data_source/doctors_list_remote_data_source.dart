import 'package:cloud_firestore/cloud_firestore.dart'
    show FirebaseFirestore, QuerySnapshot;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;

abstract class DoctorsListRemoteDataSourceBase {
  Future<List<DoctorModel>> getDoctorsList();
}

class DoctorsListRemoteDataSource extends DoctorsListRemoteDataSourceBase {
  final FirebaseFirestore _firestore;

  DoctorsListRemoteDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<DoctorModel>> getDoctorsList() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('doctors')
        .get();

    final List<DoctorModel> doctorList = snapshot.docs.map((doc) {
      final doctorData = doc.data();

      return DoctorModel.fromJson({
        'doctorId': doc.id,
        ...doctorData, // Spread Operator to integrate fields
      });
    }).toList();
    return doctorList;
  }
}
