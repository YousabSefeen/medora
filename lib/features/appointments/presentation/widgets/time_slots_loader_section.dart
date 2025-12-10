import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/features/appointments/presentation/widgets/time_slots_display_section.dart'
    show TimeSlotsDisplaySection;

import '../../../../core/constants/common_widgets/custom_error_widget.dart';
import '../../../../core/constants/common_widgets/custom_shimmer.dart';
import '../../../../core/enum/request_state.dart';
import '../controller/cubit/appointment_cubit.dart';
import '../controller/states/appointment_state.dart';

class TimeSlotsLoaderSection extends StatelessWidget {
  const TimeSlotsLoaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      AppointmentCubit,
      AppointmentState,
      Tuple2<RequestState, String>
    >(
      selector: (state) =>
          Tuple2(state.reservedTimeSlotsState, state.reservedTimeSlotsError),
      builder: (context, requestStatusAndError) {
        final requestState = requestStatusAndError.value1;
        final errorMessage = requestStatusAndError.value2;

        switch (requestState) {
          case RequestState.initial:
          case RequestState.loading:
            return CustomShimmer(height: 100.h, width: double.infinity);
          case RequestState.loaded:
            return const TimeSlotsDisplaySection();
          case RequestState.error:
            return CustomErrorWidget(errorMessage: errorMessage);
        }
      },
    );
  }
}
