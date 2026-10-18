
import 'package:equatable/equatable.dart';
import '../../../../../core/enum/lazy_request_state.dart';
import '../../../domain/entities/specialty_entity.dart';

class SpecialtiesState extends Equatable {
  // 1. حالة وقائمة التخصصات الأكثر طلباً (Top 6)
  final LazyRequestState topSpecialtiesStatus;
  final List<SpecialtyEntity> topSpecialties;
  final String topSpecialtiesErrorMessage;

  // 2. حالة وقائمة جميع التخصصات (Grid / All)
  final LazyRequestState allSpecialtiesStatus;
  final List<SpecialtyEntity> allSpecialties;
  final String allSpecialtiesErrorMessage;

  const SpecialtiesState({
    this.topSpecialtiesStatus = LazyRequestState.lazy,
    this.topSpecialties = const [],
    this.topSpecialtiesErrorMessage = '',
    this.allSpecialtiesStatus = LazyRequestState.lazy,
    this.allSpecialties = const [],
    this.allSpecialtiesErrorMessage = '',
  });

  SpecialtiesState copyWith({
    LazyRequestState? topSpecialtiesStatus,
    List<SpecialtyEntity>? topSpecialties,
    String? topSpecialtiesErrorMessage,
    LazyRequestState? allSpecialtiesStatus,
    List<SpecialtyEntity>? allSpecialties,
    String? allSpecialtiesErrorMessage,
  }) {
    return SpecialtiesState(
      topSpecialtiesStatus: topSpecialtiesStatus ?? this.topSpecialtiesStatus,
      topSpecialties: topSpecialties ?? this.topSpecialties,
      topSpecialtiesErrorMessage:
      topSpecialtiesErrorMessage ?? this.topSpecialtiesErrorMessage,
      allSpecialtiesStatus: allSpecialtiesStatus ?? this.allSpecialtiesStatus,
      allSpecialties: allSpecialties ?? this.allSpecialties,
      allSpecialtiesErrorMessage:
      allSpecialtiesErrorMessage ?? this.allSpecialtiesErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    topSpecialtiesStatus,
    topSpecialties,
    topSpecialtiesErrorMessage,
    allSpecialtiesStatus,
    allSpecialties,
    allSpecialtiesErrorMessage,
  ];
}