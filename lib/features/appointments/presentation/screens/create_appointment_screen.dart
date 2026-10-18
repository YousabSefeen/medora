import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/enum/navigation_source.dart';
import 'package:medora/features/appointments/presentation/widgets/create_appointment_app_bar.dart';
import 'package:medora/features/appointments/presentation/widgets/create_appointment_footer_actions.dart';
import 'package:medora/features/appointments/presentation/widgets/doctor_appointment_booking_section.dart';
import 'package:medora/features/shared/domain/entities/doctor_entity.dart';
import 'package:medora/features/shared/models/doctor_schedule_model.dart';

import '../../../reviews/presentation/widgets/doctor_reviews_section.dart';
import '../widgets/doctor_details_section.dart';

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

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: AppStrings.createAppoint.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          CreateAppointmentAppBar(
            doctor: widget.doctor,
            navigationSource: widget.navigationSource,
          ),

          // Pin the TabBar to the top
          SliverPadding(
            padding: const EdgeInsetsGeometry.only(top: 8),
            sliver: SliverPersistentHeader(
              pinned: true,
              delegate: _SliverTabBarDelegate(
                height: 55.h,
                child: CustomTabBarWidget(tabController: _tabController),
              ),
            ),
          ),

          AnimatedBuilder(
            animation: _tabController,
            builder: (context, _) =>
                _buildSelectedTabContent(index: _tabController.index),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedTabContent({required int index}) {
    switch (index) {
      case 0:
        return SliverMainAxisGroup(
          slivers: [
            SliverToBoxAdapter(
              child: DoctorAppointmentBookingSection(
                doctorSchedule: DoctorScheduleModel(
                  doctorId: widget.doctor.doctorId!,
                  doctorAvailability: widget.doctor.doctorAvailability,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: CreateAppointmentFooterActions(doctor: widget.doctor),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 50)),
          ],
        );

      case 1:
        return SliverToBoxAdapter(
          child: DoctorDetailsSection(
            specialties: widget.doctor.specialties,
            bio: widget.doctor.bio,
            workingDays: widget.doctor.doctorAvailability.workingDays,
            workingHours:
                '${widget.doctor.doctorAvailability.availableFrom!} - ${widget.doctor.doctorAvailability.availableTo!}',
            location: widget.doctor.location,
          ),
        );

      case 2:
        return DoctorReviewsSection(
          doctorId: widget.doctor.doctorId!,
          rating: widget.doctor.rating,
          ratingCount: widget.doctor.ratingCount,
        );

      default:
        return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
  }
}

class CustomTabBarWidget extends StatelessWidget {
  final TabController tabController;

  const CustomTabBarWidget({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: tabController,
      builder: (context, _) {
        return TabBar(
          indicator: const BoxDecoration(),
          controller: tabController,
          isScrollable: true,
          indicatorColor: Colors.transparent,
          dividerColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          padding: EdgeInsets.zero,
          labelPadding: const EdgeInsets.symmetric(horizontal: 5),
          tabs: List.generate(
            AppStrings.createAppoint.length,
            (index) => _TabItem(
              title: AppStrings.createAppoint[index],
              isSelected: tabController.index == index,
            ),
          ),
        );
      },
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool isSelected;

  const _TabItem({required this.title, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.softBlue : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(50.r),
        border: Border.all(
          color: isSelected ? AppColors.softBlue : AppColors.black26,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: GoogleFonts.roboto(
          textStyle: TextStyle(
            fontSize: 15.sp,
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _SliverTabBarDelegate({required this.child, required this.height});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.fromLTRB(16, 10, 10, 10),
      child: child,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant _SliverTabBarDelegate oldDelegate) {
    return oldDelegate.height != height || oldDelegate.child != child;
  }
}
