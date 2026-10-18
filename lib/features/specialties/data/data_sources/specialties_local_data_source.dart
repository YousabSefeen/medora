import '../../../../generated/assets.dart';
import '../models/specialty_model.dart';

abstract class SpecialtiesLocalDataSource {
  List<SpecialtyModel> getTopSpecialties();
  List<SpecialtyModel> getAllSpecialties();
}

class SpecialtiesLocalDataSourceImpl implements SpecialtiesLocalDataSource {
  @override
  List<SpecialtyModel> getAllSpecialties() {
    return [
      SpecialtyModel(
        specialtyId: 'general_practice_id',

        imageUrl: Assets.svg.specialties.doctor.path,
        name: 'General',
      ),
      SpecialtyModel(
        specialtyId: 'dentistry_id',
        imageUrl: Assets.svg.specialties.dentistry.path,
        name: 'Dentistry',
      ),
      SpecialtyModel(
        specialtyId: 'pediatrics_id',
        imageUrl: Assets.svg.specialties.pediatrics.path,
        name: 'Pediatrics',
      ),
      SpecialtyModel(
        specialtyId: 'obstetrics_and_gynecology_id',
        imageUrl: Assets.svg.specialties.obstetricsAndGynecology.path,
        name: 'Obstetrics & Gynecology',
      ),
      SpecialtyModel(
        specialtyId: 'dermatology_id',
        imageUrl: Assets.svg.specialties.dermatology.path,
        name: 'Dermatology',
      ),
      SpecialtyModel(
        specialtyId: 'orthopedics_id',
        imageUrl: Assets.svg.specialties.orthopedics.path,
        name: 'Orthopedics',
      ),
      SpecialtyModel(
        specialtyId: 'ophthalmology_id',
        imageUrl: Assets.svg.specialties.ophthalmology.path,
        name: 'Ophthalmology',
      ),
      SpecialtyModel(
        specialtyId: 'internal_medicine_id',
        imageUrl: Assets.svg.specialties.internalMedicine.path,
        name: 'Internal Medicine',
      ),
      SpecialtyModel(
        specialtyId: 'ent_id',
        imageUrl: Assets.svg.specialties.ent.path,
        name: 'ENT',
      ),
      SpecialtyModel(
        specialtyId: 'cardiology_id',
        imageUrl: Assets.svg.specialties.cardiology.path,
        name: 'Cardiology',
      ),
      SpecialtyModel(
        specialtyId: 'psychiatry_id',
        imageUrl: Assets.svg.specialties.psychiatry.path,
        name: 'Psychiatry',
      ),
      SpecialtyModel(
        specialtyId: 'neurology_id',
        imageUrl: Assets.svg.specialties.neurology.path,
        name: 'Neurology',
      ),
      SpecialtyModel(
        specialtyId: 'urology_id',

        imageUrl: Assets.svg.specialties.urology.path,
        name: 'Urology',
      ),
      SpecialtyModel(
        specialtyId: 'endocrinology_id',
        imageUrl: Assets.svg.specialties.endocrinology.path,
        name: 'Endocrinology',
      ),
      SpecialtyModel(
        specialtyId: 'pulmonology_id',
        imageUrl: Assets.svg.specialties.pulmonology.path,
        name: 'Pulmonology',
      ),
    ];
  }

  @override
  List<SpecialtyModel> getTopSpecialties()  {
     return [
       SpecialtyModel(
         specialtyId: 'general_practice_id',

         imageUrl: Assets.svg.specialties.doctor.path,
         name: 'General',
       ),
       SpecialtyModel(
         specialtyId: 'dentistry_id',
         imageUrl: Assets.svg.specialties.dentistry.path,
         name: 'Dentistry',
       ),
       SpecialtyModel(
         specialtyId: 'pediatrics_id',
         imageUrl: Assets.svg.specialties.pediatrics.path,
         name: 'Pediatrics',
       ),
       SpecialtyModel(
         specialtyId: 'obstetrics_and_gynecology_id',
         imageUrl: Assets.svg.specialties.obstetricsAndGynecology.path,
         name: 'Obstetrics & Gynecology',
       ),
       SpecialtyModel(
         specialtyId: 'dermatology_id',
         imageUrl: Assets.svg.specialties.dermatology.path,
         name: 'Dermatology',
       ),
       SpecialtyModel(
         specialtyId: 'orthopedics_id',
         imageUrl: Assets.svg.specialties.orthopedics.path,
         name: 'Orthopedics',
       ),
     ];
  }
}
