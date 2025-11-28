import 'package:cloud_firestore/cloud_firestore.dart' show Query;
import 'package:medora/features/search/domain/value_objects/search_filters/search_filter.dart'
    show SearchFilter;

class NameFilter implements SearchFilter {
  final String name;

  const NameFilter(this.name);

  @override
  Query<Map<String, dynamic>> apply(Query<Map<String, dynamic>> query) {
    return query
        .where('name', isGreaterThanOrEqualTo: name)
        .where('name', isLessThanOrEqualTo: '$name\uf8ff');
  }
}
