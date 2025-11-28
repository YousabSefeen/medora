import 'package:cloud_firestore/cloud_firestore.dart' show Query;
import 'package:medora/features/search/domain/value_objects/search_filters/search_filter.dart'
    show SearchFilter;

class SpecialtyFilter implements SearchFilter {
  final List<String> specialties;

  const SpecialtyFilter(this.specialties);

  @override
  Query<Map<String, dynamic>> apply(Query<Map<String, dynamic>> query) {
    return query.where('specialties', arrayContainsAny: specialties);
  }
}
