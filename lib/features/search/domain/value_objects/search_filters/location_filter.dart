import 'package:cloud_firestore/cloud_firestore.dart' show Query;
import 'package:medora/features/search/domain/value_objects/search_filters/search_filter.dart'
    show SearchFilter;

class LocationFilter implements SearchFilter {
  final String location;

  const LocationFilter(this.location);

  @override
  Query<Map<String, dynamic>> apply(Query<Map<String, dynamic>> query) {
    return query
        .where('location', isGreaterThanOrEqualTo: location)
        .where('location', isLessThanOrEqualTo: '$location\uf8ff');
  }
}
