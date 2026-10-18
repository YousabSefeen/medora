import 'package:medora/features/specialties/domain/entities/specialty_entity.dart';

class SpecialtyModel extends SpecialtyEntity {
  const SpecialtyModel({
    required super.specialtyId,
    required super.imageUrl,
    required super.name,
  });

  SpecialtyEntity toEntity() {
    return SpecialtyEntity(
      specialtyId: specialtyId,
      imageUrl: imageUrl,
      name: name,
    );
  }
}
