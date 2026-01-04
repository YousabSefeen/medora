import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/enum/doctor_info_variant.dart';
import 'package:medora/core/enum/navigation_source.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/time_slot_cubit.dart';
import 'package:medora/features/appointments/presentation/widgets/book_appointment_button.dart'
    show BookAppointmentButton;
import 'package:medora/features/appointments/presentation/widgets/custom_sliver_app_bar.dart';
import 'package:medora/features/appointments/presentation/widgets/doctor_appointment_booking_section.dart';
import 'package:medora/features/appointments/presentation/widgets/doctor_info_header.dart';
import 'package:medora/features/shared/domain/entities/doctor_entity.dart';
import 'package:medora/features/shared/models/doctor_schedule_model.dart';
import 'package:medora/features/shared/presentation/widgets/doctor_info_footer.dart';

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
  static const _horizontalPadding = 8.0;
  static const _smallSpacing = 5.0;
  static const _mediumSpacing = 20.0;
  static const _dividerPadding = 10.0;

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _initializeTimeSlotCubit();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _initializeTimeSlotCubit() =>
      context.read<TimeSlotCubit>().resetStates();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      bottomNavigationBar: BookAppointmentButton(doctor: widget.doctor),
      body: SafeArea(child: _buildScrollView()),
    );
  }

  Widget _buildScrollView() {
    return Scrollbar(
      controller: _scrollController,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [_buildAppBar(), _buildContent()],
      ),
    );
  }

  Widget _buildAppBar() => CustomSliverAppBar(
    doctor: widget.doctor,
    navigationSource: widget.navigationSource,
  );

  Widget _buildContent() => SliverFillRemaining(
    hasScrollBody: false,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: _smallSpacing),
          _buildDoctorInfoHeader(),
          const SizedBox(height: _mediumSpacing),
          _buildDoctorInfoFooter(),
          _buildDivider(),
          _buildBookingSection(),
        ],
      ),
    ),
  );

  Widget _buildDoctorInfoHeader() =>
      DoctorInfoHeader(doctorInfo: widget.doctor);

  Widget _buildDoctorInfoFooter() => DoctorInfoFooter(
    variant: DoctorInfoVariant.details,
    fee: widget.doctor.fees,
    location: widget.doctor.location,
  );

  Widget _buildDivider() => const Padding(
    padding: EdgeInsets.symmetric(vertical: _dividerPadding),
    child: Divider(
      color: Colors.black12,
      thickness: 2,
      indent: _dividerPadding,
      endIndent: _dividerPadding,
    ),
  );

  Widget _buildBookingSection() => DoctorAppointmentBookingSection(
    doctorSchedule: DoctorScheduleModel(
      doctorId: widget.doctor.doctorId!,
      doctorAvailability: widget.doctor.doctorAvailability,
    ),
  );
}
