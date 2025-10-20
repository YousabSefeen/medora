import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/features/doctor_profile/presentation/widgets/doctor_info_field.dart';
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart'
    show SearchCubit;
import 'package:medora/features/search/presentation/controller/states/search_states.dart'
    show SearchStates;

class LocationFilterField extends StatefulWidget {
  const LocationFilterField({super.key});

  @override
  State<LocationFilterField> createState() => _LocationFilterFieldState();
}

class _LocationFilterFieldState extends State<LocationFilterField> {
  late TextEditingController locationController;

  @override
  void initState() {
    locationController = TextEditingController(
      text: context.read<SearchCubit>().getDoctorLocation,
    );
    super.initState();
  }

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchCubit, SearchStates>(
      listener: (context, state) =>
          locationController.text = state.draftDoctorLocation??'',

      child: DoctorInfoField(
        isDense: true,
        controller: locationController,

        onChanged: (location) =>
            context.read<SearchCubit>().doctorLocationFilter(location),
      ),
    );
  }
}
