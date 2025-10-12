import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/features/doctor_profile/presentation/widgets/doctor_info_field.dart';
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart'
    show SearchCubit;

class LocationFilterField extends StatelessWidget {
  const LocationFilterField({super.key});

  @override
  Widget build(BuildContext context) {
    return DoctorInfoField(
      isDense: true,
      onChanged: (location) {
        context.read<SearchCubit>().locationFilter(location);
      },
    );
  }
}
