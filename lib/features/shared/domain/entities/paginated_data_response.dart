import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;


class PaginatedDataResponse<T> {
  final List<T> list;
  final DocumentSnapshot? lastDocument;
  final bool hasMore;

  PaginatedDataResponse({
    required this.list,
    this.lastDocument,
    this.hasMore = false,
  });
}
