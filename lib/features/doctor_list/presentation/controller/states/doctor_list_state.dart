import 'package:equatable/equatable.dart';

import '../../../../../core/enum/request_state.dart';
import '../../../../doctor_profile/data/models/doctor_model.dart';

class DoctorListState extends Equatable {
  final bool isLoadedBefore;
  final List<DoctorModel> doctorList;
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
    List<DoctorModel>? doctorList,
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
