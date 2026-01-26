// features/appointments/presentation/controller/states/upcoming_appointments_state.dart

import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;
import 'package:medora/features/shared/presentation/controllers/state/base_pagination_state.dart'
    show BasePaginationState;

class UpcomingAppointmentsState
    extends BasePaginationState<ClientAppointmentsEntity> {
  const UpcomingAppointmentsState({
    super.dataList,
    super.requestState,
    super.failureMessage,
    super.isLoadingMore,
    super.hasMore,
    super.lastDocument,
    super.isLoadedBefore,
  });

  @override
  UpcomingAppointmentsState copyWith({
    List<ClientAppointmentsEntity>? dataList,
    RequestState? requestState,
    String? failureMessage,
    bool? isLoadingMore,
    bool? hasMore,
    dynamic lastDocument,
    bool? isLoadedBefore,
  }) {
    return UpcomingAppointmentsState(
      dataList: dataList ?? this.dataList,
      requestState: requestState ?? this.requestState,
      failureMessage: failureMessage ?? this.failureMessage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      lastDocument: lastDocument ?? this.lastDocument,
      isLoadedBefore: isLoadedBefore ?? this.isLoadedBefore,
    );
  }
}
