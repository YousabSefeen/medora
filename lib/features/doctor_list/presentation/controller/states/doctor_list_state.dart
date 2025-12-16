import 'package:equatable/equatable.dart';

import 'package:medora/features/shared/domain/entities/doctor_entity.dart' show DoctorEntity;

import '../../../../../core/enum/request_state.dart';

class DoctorListState extends Equatable {
  final bool isLoadedBefore;
  final List<DoctorEntity> doctorList;
  final RequestState doctorListState;
  final String doctorListError;

  //  fields for Pagination
  final dynamic lastDocument;
  final bool hasMore;
  final bool isLoadingMore;

  const DoctorListState({
    this.isLoadedBefore = false,
    this.doctorList = const [],
    this.doctorListState = RequestState.loading,
    this.doctorListError = '',
    this.lastDocument,
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  DoctorListState copyWith({
    bool? isLoadedBefore,
    List<DoctorEntity>? doctorList,
    RequestState? doctorListState,
    String? doctorListError,
    dynamic lastDocument,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return DoctorListState(
      isLoadedBefore: isLoadedBefore ?? this.isLoadedBefore,
      doctorList: doctorList ?? this.doctorList,
      doctorListState: doctorListState ?? this.doctorListState,
      doctorListError: doctorListError ?? this.doctorListError,
      lastDocument: lastDocument ?? this.lastDocument,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
    isLoadedBefore,
    doctorList,
    doctorListState,
    doctorListError,
    lastDocument,
    hasMore,
    isLoadingMore,
  ];
}
