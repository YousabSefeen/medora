import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/features/doctor_list/presentation/controller/states/doctor_list_state.dart' show DoctorListState;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart' show DoctorModel;

import '../../../../../core/error/failure.dart' show Failure;
import '../../../data/models/doctor_list_model.dart';
import '../../../data/repository/doctor_list_repository.dart';

class DoctorListCubit extends Cubit<DoctorListState> {
  final DoctorListRepository doctorListRepository;

  DoctorListCubit({
    required this.doctorListRepository,
  }) : super(const DoctorListState());
  Future getDoctorList() async {
    final Either<Failure, List<DoctorModel>> response =
        await doctorListRepository.getDoctorList();

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
