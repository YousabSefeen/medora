import '../../../../../core/enum/request_state.dart';
import '../../../../shared/domain/entities/doctor_entity.dart';
import '../../../../shared/presentation/controllers/state/base_pagination_state.dart';

class SpecialtyDoctorsState extends BasePaginationState<DoctorEntity> {
  final String specialtyName;

  const SpecialtyDoctorsState({
    super.dataList,
    super.requestState,
    super.failureMessage,
    super.isLoadingMore,
    super.hasMore,
    super.lastDocument,
    super.isLoadedBefore,
    this.specialtyName = '',
  });

  @override
  SpecialtyDoctorsState copyWith({
    List<DoctorEntity>? dataList,
    RequestState? requestState,
    String? failureMessage,
    bool? isLoadingMore,
    bool? hasMore,
    dynamic lastDocument,
    bool? isLoadedBefore,
    String? specialtyName,
  }) {
    return SpecialtyDoctorsState(
      dataList: dataList ?? this.dataList,
      requestState: requestState ?? this.requestState,
      failureMessage: failureMessage ?? this.failureMessage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      lastDocument: lastDocument ?? this.lastDocument,
      isLoadedBefore: isLoadedBefore ?? this.isLoadedBefore,
      specialtyName: specialtyName ?? this.specialtyName,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    specialtyName,
  ];
}