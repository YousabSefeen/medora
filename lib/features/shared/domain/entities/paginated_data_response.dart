import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;

class PaginatedDataResponse {
  final List<DoctorModel> doctors;
  final DocumentSnapshot? lastDocument;
  final bool hasMore;

  PaginatedDataResponse({
    required this.doctors,
    this.lastDocument,
    this.hasMore = false,
  });
}
