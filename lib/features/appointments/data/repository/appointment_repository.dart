import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medora/features/appointments/data/models/book_appointment_model.dart' show BookAppointmentModel;

import '../../../../core/enum/appointment_status.dart';
import '../../../../core/error/failure.dart' show Failure, ServerFailure;
import '../../../doctor_profile/data/models/doctor_model.dart';
import '../models/client_appointments_model.dart';
import '../models/doctor_appointment_model.dart';
import 'appointment_repository_base.dart';

class AppointmentRepository extends AppointmentRepositoryBase {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  /// Constructor with dependency injection for better testability
  AppointmentRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  /// Fetches all appointments for a specific doctor
  @override
  Future<Either<Failure, List<DoctorAppointmentModel>>> fetchDoctorAppointments({
    required String doctorId,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('doctors')
          .doc(doctorId)
          .collection('appointments')
          .get();

      final appointments = snapshot.docs.map(_convertToDoctorAppointment).toList();
      return right(appointments);
    } catch (e) {
      _logError('fetchDoctorAppointments', e);
      return left(ServerFailure(catchError: e));
    }
  }

  /// Converts Firestore document to DoctorAppointmentModel
  DoctorAppointmentModel _convertToDoctorAppointment(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return DoctorAppointmentModel.fromJson({
      'appointmentId': doc.id,
      'appointmentModel': doc.data(),
    });
  }

  /// Fetches reserved time slots for a doctor on specific date
  @override
  Future<Either<Failure, List<String>>> fetchReservedTimeSlotsForDoctorOnDate({
    required String doctorId,
    required String date,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('appointments')
          .where('doctorId', isEqualTo: doctorId)
          .where('appointmentDate', isEqualTo: date)
          .get();

      final timeSlots = snapshot.docs
          .map((doc) => doc['appointmentTime'] as String)
          .toList();

      return right(timeSlots);
    } catch (e) {
      _logError('fetchReservedTimeSlotsForDoctorOnDate', e);
      return left(ServerFailure(catchError: e));
    }
  }

  /// Books a new appointment with the doctor
  @override
  Future<Either<Failure, void>> bookAppointment({
    required String doctorId,
    required BookAppointmentModel bookAppointmentModel,
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

      return right(null);
    } on SocketException catch (e) {
      return left(ServerFailure(catchError: e));
    } on FirebaseException catch (e) {
      return left(ServerFailure(catchError: e));
    } catch (e) {
      _logError('bookAppointment', e);
      return left(ServerFailure(catchError: e));
    }
  }

  /// Gets current authenticated user ID
  String _getCurrentUserId() {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    return user.uid;
  }

  /// Saves appointment under doctor's collection
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
        .set({
      'clientId': clientId,
      ...bookAppointmentModel.toJson(),
    });
  }

  /// Saves appointment in global appointments collection
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

  @override
  Future<Either<Failure, void>> rescheduleAppointment({
    required String doctorId,
    required String appointmentId,
    required String appointmentDate,
    required String appointmentTime,
  }) async {
    final updates = {
      'appointmentDate': appointmentDate,
      'appointmentTime': appointmentTime,
      'appointmentStatus':AppointmentStatus.confirmed.name,
    };

    return await _updateAppointment(
      doctorId: doctorId,
      appointmentId: appointmentId,
      updates: updates,
      operationName: 'rescheduleAppointment',
    );
  }

  @override
  Future<Either<Failure, void>> cancelAppointment({
    required String doctorId,
    required String appointmentId,
  }) async {
    final updates = {
      'appointmentStatus':AppointmentStatus.cancelled.name,
    };

    return await _updateAppointment(
      doctorId: doctorId,
      appointmentId: appointmentId,
      updates: updates,
      operationName: 'cancelAppointment',
    );
  }

  /// 🔁 General-purpose method to update appointment in both collections
  Future<Either<Failure, void>> _updateAppointment({
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
      return right(null);
    } catch (e) {
      _logError(operationName, e);
      return left(ServerFailure(catchError: e));
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
  //
  /// Reschedules an existing appointment
/*  @override
  Future<Either<Failure, void>> rescheduleAppointment({
    required String doctorId,
    required String appointmentId,
    required String appointmentDate,
    required String appointmentTime,
  }) async {
    try {
      final updates = {
        'appointmentDate': appointmentDate,
        'appointmentTime': appointmentTime,
        'appointmentStatus': 'Rescheduled',
      };

      // Update in global appointments collection
      await _firestore
          .collection('appointments')
          .doc(appointmentId)
          .update(updates);

      // Update in doctor's subcollection
      await _firestore
          .collection('doctors')
          .doc(doctorId)
          .collection('appointments')
          .doc(appointmentId)
          .update(updates);

      return right(null);
    } catch (e) {
      _logError('rescheduleAppointment', e);
      return left(ServerFailure(catchError: e));
    }
  }
  @override
  Future<Either<Failure, void>> cancelAppointment({required String doctorId, required String appointmentId}) async{
    try {
      final updates = {

        'appointmentStatus':AppointmentStatusStrings.cancelled,
      };

      // Update in global appointments collection
      await _firestore
          .collection('appointments')
          .doc(appointmentId)
          .update(updates);

      // Update in doctor's subcollection
      await _firestore
          .collection('doctors')
          .doc(doctorId)
          .collection('appointments')
          .doc(appointmentId)
          .update(updates);

      return right(null);
    } catch (e) {
      _logError('rescheduleAppointment', e);
      return left(ServerFailure(catchError: e));
    }
  }*/
  /// Fetches client appointments with complete doctor details
  @override
  Future<Either<Failure, List<ClientAppointmentsModel>?>>
  fetchClientAppointmentsWithDoctorDetails() async {
    try {
      final clientId = _getCurrentUserId();
      final appointments = await _fetchAppointmentsByClientId(clientId);

      final doctorIds = _extractUniqueDoctorIds(appointments);

      final doctorDataMap = await _fetchDoctorsDataByIds(doctorIds);

      final models = appointments.map((appointment) {
        final doctorId = appointment['doctorId'] as String;
        return _createClientAppointmentModel(appointment, doctorDataMap[doctorId]);
      }).toList();

      return Right(models);
    } catch (e) {
      _logError('fetchClientAppointmentsWithDoctorDetails', e);
      return left(ServerFailure(catchError: e));
    }
  }

  /// Creates ClientAppointmentsModel from raw data
  ClientAppointmentsModel _createClientAppointmentModel(
      Map<String, dynamic> appointment,
      DoctorModel? doctorModel,
      ) {
    return ClientAppointmentsModel.fromJson({
      ...appointment,
      'doctorModel': doctorModel?.toJson() ?? {},
    });
  }

  /// Fetches appointments for specific client
  Future<List<Map<String, dynamic>>> _fetchAppointmentsByClientId(
      String clientId) async {
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

  /// Deletes an appointment from both collections
  @override
  Future<Either<Failure, void>> deleteAppointment({
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

      return right(null);
    } catch (e) {
      _logError('deleteAppointment', e);
      return left(ServerFailure(catchError: e));
    }
  }

  /// Extracts unique doctor IDs from appointments list
  List<String> _extractUniqueDoctorIds(List<Map<String, dynamic>> appointments) {
    return appointments
        .map((appointment) => appointment['doctorId'] as String)
        .toSet()
        .toList();
  }

  /// Fetches doctor data in bulk for given IDs
  Future<Map<String, DoctorModel>> _fetchDoctorsDataByIds(
      List<String> doctorIds) async {
    if (doctorIds.isEmpty) return {};

    final snapshot = await _firestore
        .collection('doctors')
        .where(FieldPath.documentId, whereIn: doctorIds)
        .get();

    return {
      for (var doc in snapshot.docs) doc.id: DoctorModel.fromJson(doc.data())
    };
  }

  /// Helper method for consistent error logging
  void _logError(String methodName, dynamic error) {
    print('AppointmentRepository.$methodName ERROR: $error');
  }


}