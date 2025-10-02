import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_routes/app_router.dart' show AppRouter;
import 'package:medora/core/constants/app_routes/app_router_names.dart' show AppRouterNames;
import 'package:medora/core/constants/app_strings/app_strings.dart' show AppStrings;
import 'package:medora/core/constants/common_widgets/consultation_fee_and_wait_row.dart' show ConsultationFeeAndWaitRow;
import 'package:medora/features/appointments/data/models/picked_doctor_info_model.dart' show PickedDoctorInfoModel;
import 'package:medora/features/appointments/presentation/controller/cubit/appointment_cubit.dart' show AppointmentCubit;
import 'package:medora/features/appointments/presentation/controller/states/appointment_state.dart' show AppointmentState;
import 'package:medora/features/appointments/presentation/widgets/custom_sliver_app_bar.dart' show CustomSliverAppBar;
import 'package:medora/features/appointments/presentation/widgets/custom_widgets/adaptive_action_button.dart' show AdaptiveActionButton;
import 'package:medora/features/appointments/presentation/widgets/doctor_appointment_booking_section.dart' show DoctorAppointmentBookingSection;
import 'package:medora/features/appointments/presentation/widgets/doctor_info_header.dart' show DoctorInfoHeader;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart' show DoctorModel;
import 'package:medora/features/shared/models/doctor_schedule_model.dart' show DoctorScheduleModel;


class CreateAppointmentScreen extends StatefulWidget {
  final DoctorModel doctor;

  const CreateAppointmentScreen({super.key, required this.doctor});

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

  void _initializeAppointmentCubit() {
    context.read<AppointmentCubit>().resetStates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: _buildScrollView(),
      ),
    );
  }

  Widget _buildScrollView() => Scrollbar(
        controller: _scrollController,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            _buildAppBar(),
            _buildContent(),
          ],
        ),
      );

  Widget _buildAppBar() => CustomSliverAppBar(
        doctorName: widget.doctor.name,
        doctorImage: widget.doctor.imageUrl,
        specialties: widget.doctor.specialties,
      );

  Widget _buildContent() => SliverList(
        delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                _buildDoctorInfo(),
                _buildConsultationFee(),
                _buildDivider(),
                _buildBookingSection(),
                _buildBookButton(),
              ],
            ),
          ),
        ]),
      );

  Widget _buildDoctorInfo() => DoctorInfoHeader(doctorInfo: widget.doctor);

  Widget _buildConsultationFee() => ConsultationFeeAndWaitRow(
        fee: widget.doctor.fees.toString(),
      );

  Widget _buildDivider() => const Divider(
        color: Colors.black12,
        thickness: 1.7,
      );

  Widget _buildBookingSection() => DoctorAppointmentBookingSection(
        doctorSchedule: DoctorScheduleModel(
          doctorId: widget.doctor.doctorId!,
          doctorAvailability: widget.doctor.doctorAvailability,
        ),
      );

  Widget _buildBookButton() =>
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
    cubit.cachePickedDoctorInfo(
      PickedDoctorInfoModel(
        doctorId: widget.doctor.doctorId!,
        doctorModel: widget.doctor,
      ),
    );
    AppRouter.pushNamed(context, AppRouterNames.patientDetails);
  }
}