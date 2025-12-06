import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/base_use_case/base_use_case.dart' show NoParameters;
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/features/doctor_list/domain/use_cases/get_doctors_list_use_case.dart'
    show GetDoctorsListUseCase;
import 'package:medora/features/doctor_list/presentation/controller/states/doctor_list_state.dart'
    show DoctorListState;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;

import '../../../../../core/error/failure.dart' show Failure;

class DoctorListCubit extends Cubit<DoctorListState> {
  final GetDoctorsListUseCase getDoctorsListUseCase;

  DoctorListCubit({required this.getDoctorsListUseCase})
    : super(const DoctorListState());

  Future getDoctorsList() async {
    final Either<Failure, List<DoctorModel>> response =
        await getDoctorsListUseCase.call(const NoParameters());

    response.fold(
      (failure) => emit(
        state.copyWith(
          doctorListState: RequestState.error,
          doctorListError: failure.toString(),
        ),
      ),
      (List<DoctorModel> doctorList) => emit(
        state.copyWith(
          doctorList: doctorList,
          doctorListState: RequestState.loaded,
        ),
      ),
    );
  }
}
