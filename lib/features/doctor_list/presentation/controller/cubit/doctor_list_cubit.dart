import 'package:dartz/dartz.dart';
import 'package:medora/features/doctor_list/domain/use_cases/fetch_doctors_list_use_case.dart'
    show FetchDoctorsListUseCase;
import 'package:medora/features/doctor_list/presentation/controller/states/doctor_list_state.dart'
    show DoctorListState;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart'
    show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;
import 'package:medora/features/shared/presentation/controllers/cubit/base_pagination_cubit.dart'
    show BasePaginationCubit;

import '../../../../../core/error/failure.dart' show Failure;

class DoctorListCubit
    extends BasePaginationCubit<DoctorEntity, DoctorListState> {
  final FetchDoctorsListUseCase useCase;

  DoctorListCubit({required this.useCase}) : super(const DoctorListState());

  @override
  Future<Either<Failure, PaginatedDataResponse<DoctorEntity>>> getUseCaseCall(
    PaginationParameters params,
  ) {
    return useCase.call(params);
  }

  void updateDoctorRatingLocally({required DoctorRatingUpdatedEvent event}) {
    if (state.dataList.isEmpty) return;

    final int index = state.dataList.indexWhere(
          (doc) => doc.doctorId == event.doctorId,
    );

    if (index != -1) {
      final currentList = List<DoctorEntity>.from(state.dataList);

      // استبدال كائن الطبيب بنسخة محدثة من التقييم والعدد
      currentList[index] = currentList[index].copyWith(
        rating: event.newRating,
        ratingCount: event.newRatingCount,
      );

      emit(state.copyWith(dataList: currentList));
    }
  }
}

class DoctorRatingUpdatedEvent {
  final String doctorId;
  final double newRating;
  final int newRatingCount;

  DoctorRatingUpdatedEvent({
    required this.doctorId,
    required this.newRating,
    required this.newRatingCount,
  });
}
