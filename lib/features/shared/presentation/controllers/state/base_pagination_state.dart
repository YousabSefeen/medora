// core/utils/pagination/base_pagination_state.dart

import 'package:equatable/equatable.dart';
import 'package:medora/core/enum/request_state.dart';

abstract class BasePaginationState<T> extends Equatable {
  final List<T> dataList;
  final RequestState requestState;
  final String failureMessage;
  final bool isLoadingMore;
  final bool hasMore;
  final dynamic lastDocument;
  final bool isLoadedBefore;

  const BasePaginationState({
    this.dataList = const [],
    this.requestState = RequestState.loading,
    this.failureMessage = '',
    this.isLoadingMore = false,
    this.hasMore = true,
    this.lastDocument,
    this.isLoadedBefore = false,
  });

  // دالة copyWith ستكون abstract هنا لأن كل كلاس وارث سيحتاج لتنفيذها لنوعه الخاص
  BasePaginationState<T> copyWith({
    List<T>? dataList,
    RequestState? requestState,
    String? failureMessage,
    bool? isLoadingMore,
    bool? hasMore,
    dynamic lastDocument,
    bool? isLoadedBefore,
  });

  @override
  List<Object?> get props => [
    dataList,
    requestState,
    failureMessage,
    isLoadingMore,
    hasMore,
    lastDocument,
    isLoadedBefore,
  ];
}
