import 'package:equatable/equatable.dart';

class SpecialtyEntity extends Equatable {
  final String specialtyId;
  final String imageUrl;
  final String name;

  const SpecialtyEntity({
    required this.specialtyId,
    required this.imageUrl,
    required this.name,
  });

  @override
  List<Object?> get props => [specialtyId, imageUrl, name];
}
