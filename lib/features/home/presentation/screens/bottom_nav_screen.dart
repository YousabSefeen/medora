import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_duration/app_duration.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/features/home/presentation/constants/bottom_nav_constants.dart';
import 'package:medora/features/home/presentation/controller/cubits/bottom_nav_cubit.dart';
import 'package:medora/features/home/presentation/controller/states/bottom_nav_state.dart';
import 'package:medora/features/home/presentation/widgets/bottom_nav_search_button.dart';
import 'package:medora/features/home/presentation/widgets/custom_animated_bottom_bar.dart';
import 'package:medora/features/search/presentation/screens/search_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late AnimationController _hideBottomBarAnimationController;

  final ValueNotifier<bool> _isFabVisible = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _hideBottomBarAnimationController = AnimationController(
      duration: AppDurations.milliseconds_500,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _hideBottomBarAnimationController.dispose();
    _isFabVisible.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      if (notification.direction == ScrollDirection.reverse) {
        if (_isFabVisible.value) {
          _hideBottomBarAnimationController.forward();
          _isFabVisible.value = false;
        }
      } else if (notification.direction == ScrollDirection.forward) {
        if (!_isFabVisible.value) {
          _hideBottomBarAnimationController.reverse();
          _isFabVisible.value = true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.customWhite,

      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: _isFabVisible,
        builder: (_, isVisible, __) =>
            BottomNavSearchButton(isFabHidden: !isVisible),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomAnimatedBottomBar(
        hideAnimationController: _hideBottomBarAnimationController,
      ),
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: _handleScrollNotification,
          child: BlocBuilder<BottomNavCubit, BottomNavState>(
            buildWhen: (prev, curr) => prev.index != curr.index,
            builder: (context, state) {
              if (state.index == BottomNavConstants.searchTabIndex) {
                return const SearchScreen();
              }
              return BottomNavConstants.screens[state.index];
            },
          ),
        ),
      ),
    );
  }
}
