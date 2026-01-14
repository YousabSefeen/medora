import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medora/core/enum/appointment_status.dart';

import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart' show ClientAppointmentsEntity;
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart' show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;

import '../models/client_appointments_model.dart';
import '../models/doctor_appointment_model.dart';
import 'appointment_remote_data_source_base.dart';

class AppointmentRemoteDataSource extends AppointmentRemoteDataSourceBase {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  static const String _appointmentsCollection = 'appointments';
  static const String _doctorsCollection = 'doctors';


  AppointmentRemoteDataSource({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  // -------------------------------------------------------------
  // 1. PAGINATION METHODS - بنفس نمط DoctorsList
  // -------------------------------------------------------------

  @override
  Future<PaginatedDataResponse> fetchUpcomingAppointments({
   required PaginationParameters parameters  ,
  }) async {
    return _fetchAppointmentsByStatus(
      status: AppointmentStatus.confirmed.name,
      parameters: parameters,
      isPastDate: false, // Upcoming: تاريخ مستقبلي
    );
  }

  @override
  Future<PaginatedDataResponse> fetchCompletedAppointments({
    PaginationParameters parameters = const PaginationParameters(),
  }) async {
    return _fetchAppointmentsByStatus(
      status: AppointmentStatus.completed.name,
      parameters: parameters,
      isPastDate: true, // Completed: تاريخ مضى
    );
  }

  @override
  Future<PaginatedDataResponse> fetchCancelledAppointments({
    PaginationParameters parameters = const PaginationParameters(),
  }) async {
    return _fetchAppointmentsByStatus(
      status: AppointmentStatus.cancelled.name,
      parameters: parameters,
    );
  }

  Future<PaginatedDataResponse> _fetchAppointmentsByStatus({
    required String status,
    required PaginationParameters parameters,
    bool? isPastDate,
  }) async {
    try {
      final clientId = _getCurrentUserId();

      // 1. جلب المواعيد مع Pagination
      final querySnapshot = await _fetchPaginatedAppointments(
        clientId: clientId,
        status: status,
        parameters: parameters,
        isPastDate: isPastDate,
      );

      // 2. إذا لم توجد مواعيد
      if (querySnapshot.docs.isEmpty) {
        return PaginatedDataResponse(
          list: [],
          hasMore: false,
        );
      }

      // 3. استخراج doctor IDs
      final doctorIds = _extractDoctorIdsFromDocs(querySnapshot.docs);

      // 4. جلب بيانات الأطباء بالجملة
      final doctorDataMap = await _fetchDoctorsDataByIds(doctorIds);

      // 5. تحويل إلى Models ثم Entities
      final appointmentEntities = _convertDocsToEntities(
        docs: querySnapshot.docs,
        doctorDataMap: doctorDataMap,
      );
      print('appointmentEntities.length333333333333: ${appointmentEntities.length}');
      // 6. إرجاع النتيجة مع Pagination data - بنفس نمط DoctorsList
      return PaginatedDataResponse(
        list: appointmentEntities,
        lastDocument: querySnapshot.docs.isNotEmpty
            ? querySnapshot.docs.last
            : null,
        hasMore: querySnapshot.docs.length == parameters.limit,
      );
    } catch (error) {
      _logError('_fetchAppointmentsByStatus', error);
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> _fetchPaginatedAppointments({
    required String clientId,
    required String status,
    required PaginationParameters parameters,
    bool? isPastDate,
  }) async {


    // بناء Query الأساسي - بنفس نمط DoctorsList
    Query<Map<String, dynamic>> query = _firestore
        .collection(_appointmentsCollection)
        .where('appointmentStatus', isEqualTo: status)
        .where('clientId', isEqualTo: clientId);

 /*   // إضافة filter للتاريخ إذا طلب
    if (isPastDate != null) {
      final now = DateTime.now();
      final todayDate = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

      if (isPastDate) {
        // Completed: تاريخ مضى (أقل من اليوم)
        query = query.where('appointmentDate', isLessThan: todayDate);
      } else {
        // Upcoming: تاريخ مستقبلي (أكبر من أو يساوي اليوم)
        query = query.where('appointmentDate', isGreaterThanOrEqualTo: todayDate);
      }
    }*/

    // إضافة Order و Limit - بنفس نمط DoctorsList
    query = query
        .orderBy('appointmentDate')
        .orderBy('appointmentTime')
        .limit(parameters.limit);

    // Pagination - بنفس نمط DoctorsList
    if (parameters.lastDocument != null) {
      query = query.startAfterDocument(parameters.lastDocument!);
    }

    return await query.get();
  }

  // -------------------------------------------------------------
  // 2. HELPER METHODS - محسنة بنفس النمط
  // -------------------------------------------------------------

  List<String> _extractDoctorIdsFromDocs(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
      ) {
    try {
      return docs
          .map((doc) {
        final data = doc.data();
        final doctorId = data['doctorId'] as String?;
        return doctorId ?? '';
      })
          .where((id) => id.isNotEmpty) // تصفية IDs الفارغة
          .toSet()
          .toList();
    } catch (e) {
      _logError('_extractDoctorIdsFromDocs', e);
      return [];
    }
  }

  Future<Map<String, DoctorModel>> _fetchDoctorsDataByIds(
      List<String> doctorIds,
      ) async {
    if (doctorIds.isEmpty) return {};

    final snapshot = await _firestore
        .collection(_doctorsCollection)
        .where(FieldPath.documentId, whereIn: doctorIds)
        .get();

    return {
      for (var doc in snapshot.docs)
        doc.id: DoctorModel.fromJson({'doctorId': doc.id, ...doc.data()}),
    };
  }

  List<ClientAppointmentsModel> _convertDocsToModels({
    required List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
    required Map<String, DoctorModel> doctorDataMap,
  }) {
    return docs.map((doc) {
      try {
        final appointmentData = doc.data();
        final doctorId = appointmentData['doctorId'] as String;
        final doctorModel = doctorDataMap[doctorId];

        return ClientAppointmentsModel.fromJson({
          'appointmentId': doc.id,
          ...appointmentData,
          'doctorModel': doctorModel?.toJson() ?? {},
        });
      } catch (e) {
        _logError('_convertDocsToModels for doc: ${doc.id}', e);
        rethrow;
      }
    }).toList();
  }

  List<ClientAppointmentsEntity> _convertDocsToEntities({
    required List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
    required Map<String, DoctorModel> doctorDataMap,
  }) {
    final models = _convertDocsToModels(
      docs: docs,
      doctorDataMap: doctorDataMap,
    );

    // التحويل إلى Entities بنفس نمط DoctorsList
    return models.map((model) => model.toEntity()).toList();
  }

  // -------------------------------------------------------------
  // 3. EXISTING METHODS - بدون تغيير
  // -------------------------------------------------------------

  @override
  Future<String> bookAppointment({
    required Map<String, dynamic> queryParams,
  }) async {
    try {
      final appointmentRef = _firestore.collection('appointments').doc();
      final appointmentId = appointmentRef.id;
      final data = {
        ...queryParams,
        'clientId': _getCurrentUserId(),
        'appointmentStatus': AppointmentStatus.pendingPayment.name,
        'appointmentId': appointmentId,
        'createdAt': FieldValue.serverTimestamp(),
        'expiresAt': Timestamp.fromDate(
          DateTime.now().add(const Duration(minutes: 12)),
        ),
      };

      await appointmentRef.set(data);
      await _firestore
          .collection('doctors')
          .doc(queryParams['doctorId'])
          .collection('appointments')
          .doc(appointmentId)
          .set(data);
      return appointmentId;
    } catch (e) {
      _logError('bookAppointment', e);
      rethrow;
    }
  }

  @override
  Future<void> confirmAppointment({
    required Map<String, dynamic> queryParams,
  }) async {
    try {
      final doctorId = queryParams['doctorId'];
      final appointmentId = queryParams['appointmentId'];

      final updateData = {
        'patientName': queryParams['patientName'],
        'patientGender': queryParams['patientGender'],
        'patientAge': queryParams['patientAge'],
        'patientProblem': queryParams['patientProblem'],
        'appointmentStatus': AppointmentStatus.confirmed.name,
        'confirmedAt': FieldValue.serverTimestamp(),
        'expiresAt': FieldValue.delete(),
      };

      await _updateAppointment(
        doctorId: doctorId,
        appointmentId: appointmentId,
        updates: updateData,
        operationName: 'confirmAppointment',
      );
    } catch (e) {
      _logError('confirmAppointment', e);
      rethrow;
    }
  }

  @override
  Future<List<DoctorAppointmentModel>> fetchDoctorAppointments({
    required String doctorId,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('doctors')
          .doc(doctorId)
          .collection('appointments')
          .get();

      return snapshot.docs.map(_convertToDoctorAppointment).toList();
    } catch (e) {
      _logError('fetchDoctorAppointments', e);
      rethrow;
    }
  }

  @override
  Future<List<String>> fetchBookedTimeSlots({
    required Map<String, dynamic> queryParams,
  }) async {
    try {
      final doctorId = queryParams['doctorId'] as String;
      final date = queryParams['date'] as String;

      final snapshot = await _firestore
          .collection('appointments')
          .where('doctorId', isEqualTo: doctorId)
          .where('appointmentDate', isEqualTo: date)
          .get();

      final now = DateTime.now();

      return snapshot.docs
          .where((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final status = data['appointmentStatus'] as String;

        if (status == AppointmentStatus.confirmed.name) return true;

        if (status == AppointmentStatus.pendingPayment.name) {
          final expiresAt = data['expiresAt'] as Timestamp?;
          return expiresAt != null && expiresAt.toDate().isAfter(now);
        }

        return false;
      })
          .map((doc) => doc['appointmentTime'] as String)
          .toList();
    } catch (e) {
      _logError('fetchBookedTimeSlots', e);
      rethrow;
    }
  }

  @override
  Future<void> rescheduleAppointment({
    required Map<String, dynamic> queryParams,
  }) async {
    final doctorId = queryParams['doctorId'] as String;
    final appointmentId = queryParams['appointmentId'] as String;
    final appointmentDate = queryParams['appointmentDate'] as String;
    final appointmentTime = queryParams['appointmentTime'] as String;

    final updates = {
      'appointmentDate': appointmentDate,
      'appointmentTime': appointmentTime,
      'appointmentStatus': AppointmentStatus.confirmed.name,
    };

    return await _updateAppointment(
      doctorId: doctorId,
      appointmentId: appointmentId,
      updates: updates,
      operationName: 'rescheduleAppointment',
    );
  }

  @override
  Future<void> cancelAppointment({
    required Map<String, dynamic> queryParams,
  }) async {
    final doctorId = queryParams['doctorId'] as String;
    final appointmentId = queryParams['appointmentId'] as String;
    final updates = {'appointmentStatus': AppointmentStatus.cancelled.name};

    return await _updateAppointment(
      doctorId: doctorId,
      appointmentId: appointmentId,
      updates: updates,
      operationName: 'cancelAppointment',
    );
  }

  @override
  Future<void> deleteAppointment({
    required Map<String, dynamic> queryParams,
  }) async {
    final doctorId = queryParams['doctorId'] as String;
    final appointmentId = queryParams['appointmentId'] as String;

    try {
      await Future.wait([
        _firestore.collection('appointments').doc(appointmentId).delete(),
        _firestore
            .collection('doctors')
            .doc(doctorId)
            .collection('appointments')
            .doc(appointmentId)
            .delete(),
      ]);
    } catch (e) {
      _logError('deleteAppointment', e);
      rethrow;
    }
  }

  // -------------------------------------------------------------
  // 4. PRIVATE HELPER METHODS - بدون تغيير
  // -------------------------------------------------------------

  DoctorAppointmentModel _convertToDoctorAppointment(
      QueryDocumentSnapshot<Map<String, dynamic>> doc,
      ) {
    return DoctorAppointmentModel.fromJson({
      'appointmentId': doc.id,
      'appointmentModel': doc.data(),
    });
  }

  String _getCurrentUserId() {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    return user.uid;
  }

  Future<void> _updateAppointment({
    required String doctorId,
    required String appointmentId,
    required Map<String, dynamic> updates,
    required String operationName,
  }) async {
    try {
      await Future.wait([
        _updateGlobalAppointment(appointmentId, updates),
        _updateDoctorAppointment(doctorId, appointmentId, updates),
      ]);
    } catch (e) {
      _logError(operationName, e);
      rethrow;
    }
  }

  Future<void> _updateGlobalAppointment(
      String appointmentId,
      Map<String, dynamic> updates,
      ) {
    return _firestore
        .collection('appointments')
        .doc(appointmentId)
        .update(updates);
  }

  Future<void> _updateDoctorAppointment(
      String doctorId,
      String appointmentId,
      Map<String, dynamic> updates,
      ) {
    return _firestore
        .collection('doctors')
        .doc(doctorId)
        .collection('appointments')
        .doc(appointmentId)
        .update(updates);
  }

  void _logError(String methodName, dynamic error) {
    print('AppointmentRemoteDataSource.$methodName ERROR: $error');
  }
}