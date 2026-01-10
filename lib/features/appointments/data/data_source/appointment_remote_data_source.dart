import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medora/core/enum/appointment_status.dart';
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;

import '../models/client_appointments_model.dart';
import '../models/doctor_appointment_model.dart';
import 'appointment_remote_data_source_base.dart';

class AppointmentRemoteDataSource extends AppointmentRemoteDataSourceBase {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AppointmentRemoteDataSource({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _auth = auth ?? FirebaseAuth.instance;

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
        'appointmentStatus':AppointmentStatus.pendingPayment.name,
        'appointmentId': appointmentId,
        'createdAt': FieldValue.serverTimestamp(),
        'expiresAt': Timestamp.fromDate(
          DateTime.now().add(const Duration(minutes: 12)),
        ),
      };

      await appointmentRef.set(data);
      await FirebaseFirestore.instance
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

  // confirmAppointment
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

        'appointmentStatus':     AppointmentStatus.confirmed.name,
        'confirmedAt': FieldValue.serverTimestamp(),

        'expiresAt': FieldValue.delete(),
      };

      //   Update the appointment in the public collection
      await _firestore
          .collection('appointments')
          .doc(appointmentId)
          .update(updateData);
      //   Update the appointment in the doctor's collection
      await _firestore
          .collection('doctors')
          .doc(doctorId)
          .collection('appointments')
          .doc(appointmentId)
          .update(updateData);
    } catch (e) {
      _logError('confirmAppointment', e);
      rethrow;
    }
  }

  //   fetching all doctor appointments
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

  // Retrieve the booked times for a specific date
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
            final status = doc['appointmentStatus'] as String;

            if (status == 'confirmed') return true;

            if (status == 'pending') {
              final expiresAt = doc['expiresAt'] as Timestamp?;
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

  //   Reschedule an appointment
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

  //   Cancel appointment
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

  //   fetch client appointments with doctor details

  Future<List<ClientAppointmentsModel>?> _fetchAppointments({
    required String appointmentStatus,
  }) async {
    final clientId = _getCurrentUserId();
    final appointments = await _fetchAppointmentsByClientId(
      clientId: clientId,
      appointmentStatus: appointmentStatus,
    );
    final doctorIds = _extractUniqueDoctorIds(appointments);
    final doctorDataMap = await _fetchDoctorsDataByIds(doctorIds);

    return appointments.map((appointment) {
      final doctorId = appointment['doctorId'] as String;
      return _createClientAppointmentModel(
        appointment,
        doctorDataMap[doctorId],
      );
    }).toList();
  }

  //   Delete appointment
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

  // -----------------------------------------------------------------------
  //                        الدوال المساعدة (Helper Methods)
  // -----------------------------------------------------------------------

  /// تحويل مستند Firestore إلى DoctorAppointmentModel
  DoctorAppointmentModel _convertToDoctorAppointment(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    return DoctorAppointmentModel.fromJson({
      'appointmentId': doc.id,
      'appointmentModel': doc.data(),
    });
  }

  /// الحصول على معرف المستخدم الحالي
  String _getCurrentUserId() {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    return user.uid;
  }

  /// تحديث موعد في كلتا المجموعتين (العامة والخاصة بالطبيب)
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

  /*  /// جلب المواعيد حسب معرف العميل
  Future<List<Map<String, dynamic>>> _fetchAppointmentsByClientId(
    String clientId,
  ) async {
    final snapshot = await _firestore
        .collection('appointments')
        .where('appointmentStatus', isEqualTo: 'confirmed')
        .where('clientId', isEqualTo: clientId)
        .orderBy('appointmentDate')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['appointmentId'] = doc.id;
      return data;
    }).toList();
  }*/

  ///  جديد جلب المواعيد حسب معرف العميل
  Future<List<Map<String, dynamic>>> _fetchAppointmentsByClientId({
    required String clientId,
    required String appointmentStatus,
  }) async {
    final snapshot = await _firestore
        .collection('appointments')
        .where('appointmentStatus', isEqualTo: appointmentStatus)
        .where('clientId', isEqualTo: clientId)
        .orderBy('appointmentDate')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['appointmentId'] = doc.id;
      return data;
    }).toList();
  }

  /// Extracting unique doctors  identifiers
  List<String> _extractUniqueDoctorIds(
    List<Map<String, dynamic>> appointments,
  ) {
    return appointments
        .map((appointment) => appointment['doctorId'] as String)
        .toSet()
        .toList();
  }

  /// جلب بيانات الأطباء بالجملة
  Future<Map<String, DoctorModel>> _fetchDoctorsDataByIds(
    List<String> doctorIds,
  ) async {
    if (doctorIds.isEmpty) return {};

    final snapshot = await _firestore
        .collection('doctors')
        .where(FieldPath.documentId, whereIn: doctorIds)
        .get();

    return {
      for (var doc in snapshot.docs) doc.id: DoctorModel.fromJson(doc.data()),
    };
  }

  /// إنشاء ClientAppointmentsModel من البيانات الخام
  ClientAppointmentsModel _createClientAppointmentModel(
    Map<String, dynamic> appointment,
    DoctorModel? doctorModel,
  ) {
    return ClientAppointmentsModel.fromJson({
      ...appointment,

      'doctorModel': doctorModel?.toJson() ?? {},
    });
  }

  void _logError(String methodName, dynamic error) {
    print('AppointmentRemoteDataSource.$methodName ERROR: $error');
  }


  @override
  Future<List<ClientAppointmentsModel>?> fetchUpcomingAppointments() async{
    try {
      return await _fetchAppointments(appointmentStatus:     AppointmentStatus.confirmed.name);
    } catch (e) {
      _logError('fetchCancelledAppointments', e);
      rethrow;
    }
  }
  @override
  Future<List<ClientAppointmentsModel>?> fetchCompletedAppointments() async{
    try {
      return await _fetchAppointments(appointmentStatus: AppointmentStatus.confirmed.name);
    } catch (e) {
      _logError('fetchCancelledAppointments', e);
      rethrow;
    }
  }
  @override
  Future<List<ClientAppointmentsModel>?> fetchCancelledAppointments() async {
    try {
      return await _fetchAppointments(appointmentStatus: 'cancelled');
    } catch (e) {
      _logError('fetchCancelledAppointments', e);
      rethrow;
    }
  }

}
