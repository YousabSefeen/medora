




/*
Future<String> createPendingAppointment({
    required String appointmentDate,
    required String appointmentTime,
  }) async {
    try {
      final appointmentRef = FirebaseFirestore.instance
          .collection('appointments')
          .doc();
      final appointmentId = appointmentRef.id;
      final doctorId = widget.doctor.doctorId;
      final clientId = _getCurrentUserId();

      final data = {
        'appointmentId': appointmentId,
        'doctorId': doctorId,
        'clientId': clientId,
        'appointmentDate': appointmentDate,
        'appointmentTime': appointmentTime,

        'appointmentStatus': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
        'expiresAt': Timestamp.fromDate(
          DateTime.now().add(const Duration(minutes: 10)),
        ),

        // ...pendingAppointmentModel.toJson(),
      };

      // 1️⃣ حفظ الموعد بشكل عام
      await appointmentRef.set(data);

      // 2️⃣ حفظ الموعد تحت الطبيب
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctorId)
          .collection('appointments')
          .doc(appointmentId)
          .set(data);
      print('appointmentId: $appointmentId');
      apoointmentIdNew = appointmentId;
      return appointmentId;
    } catch (e) {
      print('createPendingAppointment: ERROR: $e');
      rethrow;
    }
  }

  String _getCurrentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('User not authenticated');
    return user.uid;
  }

  Future<void> confirmAppointment({
    required String appointmentId,
    required String patientName,
    required String patientGender,
    required String patientAge,
    required String patientProblem,
  }) async {
    try {
      final doctorId = widget.doctor.doctorId;

      final updateData = {
        'patientName': patientName,
        'patientGender': patientGender,
        'patientAge': patientAge,
        'patientProblem': patientProblem,

        'appointmentStatus': 'confirmed',
        'confirmedAt': FieldValue.serverTimestamp(),

        // مهم جداً
        'expiresAt': FieldValue.delete(),
      };

      // 1️⃣ تحديث الموعد في collection العامة
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointmentId)
          .update(updateData);

      // 2️⃣ تحديث الموعد في collection الطبيب
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctorId)
          .collection('appointments')
          .doc(appointmentId)
          .update(updateData);

      print('confirmAppointment: SUCCESS for $appointmentId');
    } catch (e) {
      print('confirmAppointment: ERROR: $e');
      rethrow;
    }
  }
 */