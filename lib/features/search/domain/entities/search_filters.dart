import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show RangeValues;

class SearchFilters extends Equatable {
  final String doctorName;
  final RangeValues priceRange;

  final List<String> specialties;
  final String? location;

  const SearchFilters({
    required this.doctorName,
    required this.priceRange,

    required this.specialties,
    required this.location,
  });

  @override
  List<Object?> get props => [priceRange, specialties, location];
}
