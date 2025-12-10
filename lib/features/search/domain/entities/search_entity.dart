import 'package:medora/core/enum/search_type.dart' show SearchType;
import 'package:medora/features/search/domain/entities/search_filters.dart'
    show SearchFilters;

class SearchEntity {
  final String query;
  final SearchType type;
  final SearchFilters filters;

  const SearchEntity({
    required this.query,
    required this.type,
    required this.filters,
  });
}
