import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';

import '../../../../core/di/injection_container.dart';
import '../../../shared/presentation/widgets/custom_app_bar.dart';
import '../controller/cubit/specialty_doctors_cubit.dart';
import '../widgets/specialty_doctors_list.dart';

class SpecialtyDoctorsScreen extends StatefulWidget {
  final String specialtyName;

  const SpecialtyDoctorsScreen({super.key, required this.specialtyName});

  @override
  State<SpecialtyDoctorsScreen> createState() => _SpecialtyDoctorsScreenState();
}

class _SpecialtyDoctorsScreenState extends State<SpecialtyDoctorsScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.customWhite,
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const BouncingScrollPhysics(),
          slivers: [
            CustomAppBar.sliver(
              title: '${widget.specialtyName} ${AppStrings.doctors}',
              context: context,
            ),
            SliverPadding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 15.w),
              sliver: BlocProvider(
                create: (context) =>
                    sl<SpecialtyDoctorsCubit>(param1: widget.specialtyName),

                child: SpecialtyDoctorsList(
                  scrollController: _scrollController,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
