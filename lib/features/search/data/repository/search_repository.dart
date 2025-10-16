import 'package:cloud_firestore/cloud_firestore.dart'
    show FirebaseFirestore, QuerySnapshot, QueryDocumentSnapshot, Query;
import 'package:dartz/dartz.dart';
import 'package:flutter/src/material/slider_theme.dart';
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/search/data/repository/search_repository_base.dart'
    show SearchRepositoryBase;

import '../../../../core/error/failure.dart' show Failure, ServerFailure;

class SearchRepository extends SearchRepositoryBase {
  final FirebaseFirestore _firestore;

  SearchRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<Either<Failure, List<DoctorModel>>> searchDoctorsByName({
    required String doctorName,
  }) async {
    try {
      final String startAt = doctorName;
      final String endAt = '$doctorName\uf8ff';

      final snapshot = await _firestore
          .collection('doctors')
          .where('name', isGreaterThanOrEqualTo: startAt)
          .where('name', isLessThanOrEqualTo: endAt)
          .limit(10)
          .get();
      return _parseSnapshot(snapshot);
      final List<DoctorModel> doctorList = snapshot.docs.map((doc) {
        final doctorData = doc.data();

        return DoctorModel.fromJson({'doctorId': doc.id, ...doctorData});
      }).toList();
      return right(doctorList);

    } catch (e) {
      print('SearchRepository.searchDoctorsByName $e');

      return left(ServerFailure(catchError: e));
    }
  }

  ///xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxء
  @override
  Future<Either<Failure, List<DoctorModel>>> searchDoctorsByCriteria({
    required String doctorName,
    required RangeValues priceRange,
    List<String>? specialties,
    String? location,
  }) async {
    try {
      final query = await _buildQuery(
        doctorName: doctorName,
        priceRange: priceRange,
        specialties: specialties,
        location: location,
      );
      final snapshot = await query.limit(10).get();

      return _parseSnapshot(snapshot);
    } catch (e) {
      _logError('searchDoctorsByCriteria', e);
      return Left(ServerFailure(catchError: e));
    }
  }



  Future<Query<Map<String, dynamic>>> _buildQuery({
    required String doctorName,
    required RangeValues priceRange,
    List<String>? specialties,
    String? location,
  }) async {
    // 1. Basic construction (always required * Doctor Name && Price Range*)
    var query =  _firestore
        .collection('doctors')
        .where('name', isGreaterThanOrEqualTo: doctorName)
        .where('name', isLessThanOrEqualTo: '$doctorName\uf8ff')
        .where('fees', isGreaterThanOrEqualTo: priceRange.start)
        .where('fees', isLessThanOrEqualTo: priceRange.end);

    // 2. Conditional application of optional filters (specialties && location)
    query = _applyOptionalFilters(query, specialties, location);

    return query;
  }

  Query<Map<String, dynamic>> _applyOptionalFilters(
    Query<Map<String, dynamic>> query,
    List<String>? specialties,
    String? location,
  ) {
    // Apply the specialties filter if it exists
    if (specialties != null && specialties.isNotEmpty) {
      final limitedSpecialties = specialties.take(10).toList();

      query = query.where('specialties', arrayContainsAny: limitedSpecialties);
    }
    // Apply the location filter if it exists
    if (location != null && location.isNotEmpty) {
      query = query
          .where('location', isGreaterThanOrEqualTo: location)
          .where('location', isLessThanOrEqualTo: '$location\uf8ff');
    }
    return query;
  }

  Either<Failure, List<DoctorModel>> _parseSnapshot(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    try {
      final doctorList = snapshot.docs.map(_convertToDoctorModel).toList();
      return Right(doctorList);
    } catch (e) {
      _logError('_parseSnapshot', e);
      return Left(ServerFailure(catchError: e));
    }
  }

  DoctorModel _convertToDoctorModel(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final doctorData = doc.data();
    return DoctorModel.fromJson({'doctorId': doc.id, ...doctorData});
  }

  void _logError(String methodName, Object error) => print('SearchRepository.$methodName: $error');
/*
  Future<Query<Map<String, dynamic>>> _buildQuery(
    String doctorName,
    RangeValues priceRange,
    List<String>? specialties,
    String? location,
  ) async {
    final String startAt = doctorName ;
    final String endAt = '$doctorName\uf8ff';
    final String locationStartAt = location!;
    final String locationEndAt = '$locationStartAt\uf8ff';

    var query = _firestore
        .collection('doctors')
        .where('name', isGreaterThanOrEqualTo: startAt)
        .where('name', isLessThanOrEqualTo: endAt)
        .where('fees', isGreaterThanOrEqualTo: priceRange.start)
        .where('fees', isLessThanOrEqualTo: priceRange.end)
        .where('location', isGreaterThanOrEqualTo: locationStartAt)
        .where('location', isLessThanOrEqualTo: locationEndAt).where('specialties', arrayContainsAny: specialties);



    return query;
  }
*/
}



/*
  @override
  Future<Either<Failure, List<DoctorModel>>> searchDoctorsByCriteria({
    required String doctorName,
    required RangeValues priceRange,
    List<String>? specialties,
    String? location,
  }) async {
    try {
      print('startAt $doctorName');
      final String startAt = 'Yousab doctor';
      final String endAt = '$doctorName\uf8ff';

        QuerySnapshot<Map<String, dynamic>>  snapshot  = await FirebaseFirestore.instance
            .collection('doctors')
            .where('name', isGreaterThanOrEqualTo: startAt)
            .where('name', isLessThanOrEqualTo: endAt)
            .where('fees', isGreaterThanOrEqualTo: priceRange.start)
            .where('fees', isLessThanOrEqualTo: priceRange.end)
            .limit(10)
            .get();


      final List<DoctorModel> doctorList = snapshot.docs.map((doc) {
        final doctorData = doc.data();

        return DoctorModel.fromJson({'doctorId': doc.id, ...doctorData});
      }).toList();
      return right(doctorList);
    } catch (e) {
      print('SearchRepository.searchDoctorsByName $e');

      return left(ServerFailure(catchError: e));
    }
  }
 */
