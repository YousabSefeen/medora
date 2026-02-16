import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/extensions/media_query_extension.dart';
import 'package:medora/features/doctor_list/presentation/screen/popular_doctors_section.dart'
    show PopularDoctorsSection;
import 'package:medora/features/doctors_specialties/presentation/widgets/doctor_specialties_section.dart'
    show HomeScreenKeys, DoctorSpecialtiesSection;
import 'package:medora/features/home/presentation/widgets/home_sliver_app_bar.dart'
    show HomeSliverAppBar;
import 'package:medora/features/home/presentation/widgets/popular_doctors_header.dart'
    show PopularDoctorsHeader;
import 'package:medora/features/home/presentation/widgets/scroll_controller_provider.dart'
    show ScrollControllerProvider;
import 'package:medora/features/home/presentation/widgets/specialties_header.dart'
    show SpecialtiesHeader;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.w),
      child: ScrollControllerProvider(
        scrollController: _scrollController,
        child: CustomScrollView(
          controller: _scrollController,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          key: const PageStorageKey<String>('home_screen'),
          physics: const BouncingScrollPhysics(),
          slivers: const [
            HomeSliverAppBar(),
            SpecialtiesHeader(),
            DoctorSpecialtiesSection(),
            PopularDoctorsHeader(),
            _PopularDoctorsSection(),
          ],
        ),
      ),
    );
  }
}

class _PopularDoctorsSection extends StatelessWidget {
  const _PopularDoctorsSection();

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollControllerProvider.of(context);

    return SliverConstrainedCrossAxis(
      maxExtent: context.screenWidth * 0.95,
      sliver: PopularDoctorsSection(scrollController: scrollController),
    );
  }
}
