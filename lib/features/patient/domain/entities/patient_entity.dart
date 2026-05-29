import 'package:equatable/equatable.dart' show Equatable;
import 'package:medora/core/enum/gender_type.dart';

class PatientEntity extends Equatable {
  final String name;
  final String age;
  final String problem;
  final GenderType gender;

  const PatientEntity({
    required this.name,
    required this.age,
    required this.problem,
    required this.gender,
  });

  @override
  List<Object> get props => [name, age, problem, gender];
}
