import 'package:cloud_firestore/cloud_firestore.dart' show Query;
import 'package:flutter/material.dart' show RangeValues;
import 'package:medora/features/search/domain/value_objects/search_filters/search_filter.dart'
    show SearchFilter;

class PriceRangeFilter implements SearchFilter {
  final RangeValues priceRange;

  const PriceRangeFilter(this.priceRange);

  @override
  Query<Map<String, dynamic>> apply(Query<Map<String, dynamic>> query) {
    return query
        .where('fees', isGreaterThanOrEqualTo: priceRange.start)
        .where('fees', isLessThanOrEqualTo: priceRange.end);
  }
}
