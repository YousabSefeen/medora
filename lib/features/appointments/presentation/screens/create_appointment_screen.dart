import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_routes/app_router.dart'
    show AppRouter;
import 'package:medora/core/constants/app_routes/app_router_names.dart'
    show AppRouterNames;
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/enum/doctor_info_variant.dart'
    show DoctorInfoVariant;
import 'package:medora/core/enum/navigation_source.dart' show NavigationSource;

import 'package:medora/features/appointments/presentation/controller/cubit/appointment_cubit.dart'
    show AppointmentCubit;
import 'package:medora/features/appointments/presentation/controller/states/appointment_state.dart'
    show AppointmentState;
import 'package:medora/features/appointments/presentation/view_data/selected_doctor_view_data.dart' show SelectedDoctorViewData;

import 'package:medora/features/appointments/presentation/widgets/custom_sliver_app_bar.dart'
    show CustomSliverAppBar;
import 'package:medora/features/appointments/presentation/widgets/custom_widgets/adaptive_action_button.dart'
    show AdaptiveActionButton;
import 'package:medora/features/appointments/presentation/widgets/doctor_appointment_booking_section.dart'
    show DoctorAppointmentBookingSection;
import 'package:medora/features/appointments/presentation/widgets/doctor_info_header.dart'
    show DoctorInfoHeader;

import 'package:medora/features/shared/domain/entities/doctor_entity.dart' show DoctorEntity;
import 'package:medora/features/shared/models/doctor_schedule_model.dart'
    show DoctorScheduleModel;
import 'package:medora/features/shared/presentation/widgets/doctor_info_footer.dart'
    show DoctorInfoFooter;

class CreateAppointmentScreen extends StatefulWidget {
  final DoctorEntity doctor;
  final NavigationSource navigationSource;

  const CreateAppointmentScreen({
    super.key,
    required this.doctor,
    this.navigationSource = NavigationSource.direct,
  });

  @override
  State<CreateAppointmentScreen> createState() =>
      _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _initializeAppointmentCubit();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _initializeAppointmentCubit() =>
      context.read<AppointmentCubit>().resetStates();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(child: _buildScrollView()),
    );
  }

  Widget _buildScrollView() => Scrollbar(
    controller: _scrollController,
    child: CustomScrollView(
      controller: _scrollController,
      slivers: [_buildAppBar(), _buildContent()],
    ),
  );

  Widget _buildAppBar() => CustomSliverAppBar(
    doctor: widget.doctor,
    navigationSource: widget.navigationSource,
  );

  Widget _buildContent() => SliverFillRemaining(
    hasScrollBody: false,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          _buildDoctorInfoHeader(),
          const SizedBox(height: 10),
          _buildDoctorInfoFooter(),
          _buildDivider(),
          _buildBookingSection(),
          _buildBookButton(),
        ],
      ),
    ),
  );

  DoctorInfoHeader _buildDoctorInfoHeader() =>
      DoctorInfoHeader(doctorInfo: widget.doctor);

  DoctorInfoFooter _buildDoctorInfoFooter() => DoctorInfoFooter(
    variant: DoctorInfoVariant.details,
    fee: widget.doctor.fees,
    location: widget.doctor.location,
  );

  Divider _buildDivider() =>
      const Divider(color: Colors.black12, thickness: 1.7);

  DoctorAppointmentBookingSection _buildBookingSection() =>
      DoctorAppointmentBookingSection(
        doctorSchedule: DoctorScheduleModel(
          doctorId: widget.doctor.doctorId!,
          doctorAvailability: widget.doctor.doctorAvailability,
        ),
      );

  BlocSelector _buildBookButton() =>
      BlocSelector<AppointmentCubit, AppointmentState, String?>(
        selector: (state) => state.selectedTimeSlot,
        builder: (context, selectedTimeSlot) {
          final isEnabled =
              selectedTimeSlot != null && selectedTimeSlot.isNotEmpty;

          return AdaptiveActionButton(
            title: AppStrings.bookAppointment,
            isEnabled: isEnabled,
            isLoading: false,
            onPressed: _navigateToPatientDetailsAfterCaching,
          );
        },
      );

  void _navigateToPatientDetailsAfterCaching() {
    final cubit = context.read<AppointmentCubit>();
    cubit.cacheSelectedDoctor(
      SelectedDoctorViewData(
        doctorId: widget.doctor.doctorId!,
        doctorModel: widget.doctor,
      ),
    );
    AppRouter.pushNamed(context, AppRouterNames.patientDetails);
  }
}
