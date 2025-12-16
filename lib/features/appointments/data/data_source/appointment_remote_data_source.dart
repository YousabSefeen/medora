// data/data_source/appointment_remote_data_source.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medora/core/enum/appointment_status.dart';
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;

import '../models/book_appointment_model.dart';
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

  // 1. fetching all doctor appointments
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
      rethrow; // إعادة رمي الخطأ ليتم التعامل معه في RepositoryImpl
    }
  }

  // 2. Retrieve the booked times for a specific date
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

      return snapshot.docs
          .map((doc) => doc['appointmentTime'] as String)
          .toList();
    } catch (e) {
      _logError('fetchReservedTimeSlotsForDoctorOnDate', e);
      rethrow;
    }
  }

  // 3. Book a new appointment
  @override
  Future<void> bookAppointment({
    required String doctorId,
    required BookAppointmentModel bookAppointmentModel, // يستقبل Model
  }) async {
    try {
      final appointmentId = _firestore.collection('appointments').doc().id;
      final clientId = _getCurrentUserId();

      await _saveAppointmentUnderDoctor(
        doctorId: doctorId,
        clientId: clientId,
        appointmentId: appointmentId,
        bookAppointmentModel: bookAppointmentModel,
      );

      await _saveAppointmentGlobally(
        doctorId: doctorId,
        clientId: clientId,
        appointmentId: appointmentId,
        bookAppointmentModel: bookAppointmentModel,
      );
    } catch (e) {
      _logError('bookAppointment', e);
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
    required String doctorId,
    required String appointmentId,
  }) async {
    final updates = {'appointmentStatus': AppointmentStatus.cancelled.name};

    return await _updateAppointment(
      doctorId: doctorId,
      appointmentId: appointmentId,
      updates: updates,
      operationName: 'cancelAppointment',
    );
  }

  // 6.  fetch client appointments with doctor details
  @override
  Future<List<ClientAppointmentsModel>?>
  fetchClientAppointments() async {
    try {
      final clientId = _getCurrentUserId();
      final appointments = await _fetchAppointmentsByClientId(clientId);
      final doctorIds = _extractUniqueDoctorIds(appointments);
      final doctorDataMap = await _fetchDoctorsDataByIds(doctorIds);

      return appointments.map((appointment) {
        final doctorId = appointment['doctorId'] as String;
        return _createClientAppointmentModel(
          appointment,
          doctorDataMap[doctorId],
        );
      }).toList();
    } catch (e) {
      _logError('fetchClientAppointmentsWithDoctorDetails', e);
      rethrow;
    }
  }

  //   Delete appointment
  @override
  Future<void> deleteAppointment({
    required String appointmentId,
    required String doctorId,
  }) async {
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

  /// حفظ الموعد في مجموعة الطبيب الفرعية
  Future<void> _saveAppointmentUnderDoctor({
    required String doctorId,
    required String clientId,
    required String appointmentId,
    required BookAppointmentModel bookAppointmentModel,
  }) async {
    await _firestore
        .collection('doctors')
        .doc(doctorId)
        .collection('appointments')
        .doc(appointmentId)
        .set({'clientId': clientId, ...bookAppointmentModel.toJson()});
  }

  /// حفظ الموعد في مجموعة المواعيد العامة
  Future<void> _saveAppointmentGlobally({
    required String doctorId,
    required String clientId,
    required String appointmentId,
    required BookAppointmentModel bookAppointmentModel,
  }) async {
    await _firestore.collection('appointments').doc(appointmentId).set({
      'doctorId': doctorId,
      'clientId': clientId,
      ...bookAppointmentModel.toJson(),
    });
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

  /// جلب المواعيد حسب معرف العميل
  Future<List<Map<String, dynamic>>> _fetchAppointmentsByClientId(
    String clientId,
  ) async {
    final snapshot = await _firestore
        .collection('appointments')
        .where('clientId', isEqualTo: clientId)
        .orderBy('appointmentDate')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['appointmentId'] = doc.id;
      return data;
    }).toList();
  }

  /// استخراج معرّفات الأطباء الفريدة
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
}
