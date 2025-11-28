

import 'package:cloud_firestore/cloud_firestore.dart' show Query;

abstract class SearchFilter {
  Query<Map<String, dynamic>> apply(Query<Map<String, dynamic>> query);
}