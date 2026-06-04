import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;
import 'package:medora/features/shared/presentation/controllers/state/base_pagination_state.dart'
    show BasePaginationState;

class FavoritesState extends BasePaginationState<DoctorEntity> {
  final Set<String> favoriteIds;
  final RequestState idsLoadingState;
  final RequestState toggleState;

  const FavoritesState({
    super.dataList,
    super.requestState,
    super.failureMessage,
    super.isLoadingMore,
    super.hasMore,
    super.lastDocument,
    super.isLoadedBefore,
    this.favoriteIds = const {},
    this.idsLoadingState = RequestState.loaded,
    this.toggleState = RequestState.loaded,
  });

  @override
  FavoritesState copyWith({
    List<DoctorEntity>? dataList,
    RequestState? requestState,
    String? failureMessage,
    bool? isLoadingMore,
    bool? hasMore,
    dynamic lastDocument,
    bool? isLoadedBefore,
    Set<String>? favoriteIds,
    RequestState? idsLoadingState,
    RequestState? toggleState,
  }) {
    return FavoritesState(
      dataList: dataList ?? this.dataList,
      requestState: requestState ?? this.requestState,
      failureMessage: failureMessage ?? this.failureMessage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      lastDocument: lastDocument ?? this.lastDocument,
      isLoadedBefore: isLoadedBefore ?? this.isLoadedBefore,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      idsLoadingState: idsLoadingState ?? this.idsLoadingState,
      toggleState: toggleState ?? this.toggleState,
    );
  }

  bool isFavorite(String doctorId) => favoriteIds.contains(doctorId);

  @override
  List<Object?> get props => [
    ...super.props, // هذا يضمن جلب خصائص الأب تلقائياً
    favoriteIds,
    idsLoadingState,
    toggleState,
  ];
}
