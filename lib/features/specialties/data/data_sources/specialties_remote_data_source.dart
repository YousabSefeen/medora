import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medora/core/constants/firestore_constants/firestore_constants.dart';
import 'package:medora/features/shared/data/models/doctor_model.dart';

import '../../../shared/domain/entities/doctor_entity.dart';
import '../../../shared/domain/entities/paginated_data_response.dart';
import '../../domain/params/fetch_doctors_by_specialty_params.dart';

abstract class SpecialtiesRemoteDataSource {
  Future<PaginatedDataResponse<DoctorEntity>> fetchDoctorsBySpecialty(
    GetDoctorsBySpecialtyParameters parameters,
  );
}

class SpecialtiesRemoteDataSourceImpl extends SpecialtiesRemoteDataSource {
  final FirebaseFirestore _firestore;

  SpecialtiesRemoteDataSourceImpl({required this._firestore});

  @override
  Future<PaginatedDataResponse<DoctorEntity>> fetchDoctorsBySpecialty(
    GetDoctorsBySpecialtyParameters parameters,
  ) async {
    // 1. بناء الـ Query واستخدام الـ specialtyName الديناميكي
    Query<Map<String, dynamic>> query = _firestore
        .collection(FirestoreConstants.doctorsCollection)
        .where('specialties', arrayContains: parameters.specialtyName)
        .limit(parameters.limit);

    // 2. تطبيق الـ Pagination في حال وجود lastDocument
    if (parameters.lastDocument != null) {
      query = query.startAfterDocument(
        parameters.lastDocument as DocumentSnapshot<Map<String, dynamic>>,
      );
    }

    final snapshot = await query.get();

    if (snapshot.docs.isEmpty) {
      return PaginatedDataResponse(list: [], hasMore: false);
    }

    // 3. تحويل الـ Docs إلى List<DoctorEntity>
    final doctorsList = snapshot.docs.map((doc) {
      return DoctorModel.fromJson({
        'doctorId': doc.id,
        ...doc.data(),
      }).toEntity();
    }).toList();

    return PaginatedDataResponse(
      list: doctorsList,
      lastDocument: snapshot.docs.last,
      hasMore: snapshot.docs.length == parameters.limit,
    );
  }
}
