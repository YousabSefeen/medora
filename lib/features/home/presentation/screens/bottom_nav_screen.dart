import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/features/home/presentation/constants/bottom_nav_constants.dart'
    show BottomNavConstants;
import 'package:medora/features/home/presentation/controller/cubits/bottom_nav_cubit.dart'
    show BottomNavCubit;
import 'package:medora/features/home/presentation/controller/states/bottom_nav_state.dart'
    show BottomNavState;
import 'package:medora/features/home/presentation/widgets/bottom_nav_search_button.dart'
    show BottomNavSearchButton;
import 'package:medora/features/home/presentation/widgets/bottom_nav_tab.dart'
    show BottomNavTab;
import 'package:medora/features/search/presentation/screens/search_screen.dart'
    show SearchScreen;

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
  late AnimationController _borderRadiusAnimationController;

  @override
  void initState() {
    super.initState();
    _initAnimationControllers();
    _startBorderRadiusAnimation();
  }

  void _initAnimationControllers() {
    _hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  void _startBorderRadiusAnimation() {
    _borderRadiusAnimationController.forward();
  }

  @override
  void dispose() {
    _hideBottomBarAnimationController.dispose();
    _borderRadiusAnimationController.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      final cubit = context.read<BottomNavCubit>();
      if (notification.direction == ScrollDirection.reverse) {
        _hideBottomBarAnimationController.forward();
        cubit.hideFab();
      } else if (notification.direction == ScrollDirection.forward) {
        _hideBottomBarAnimationController.reverse();
        cubit.showFab();
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          backgroundColor: AppColors.customWhite,

          appBar: state.index == 0
              ? null
              : AppBar(
                  backgroundColor: AppColors.customWhite,
                  title: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(BottomNavConstants.appBarTitles[state.index]),
                  ),
                ),
          body: SafeArea(
            key: const PageStorageKey<String>('bottom_nav_screen'),
            child: NotificationListener<ScrollNotification>(
              onNotification: _handleScrollNotification,
              child: _buildBody(state.index),
            ),
          ),
          floatingActionButton: BottomNavSearchButton(
            isFabHidden: state.isFabHidden,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: _buildAnimatedNavigationBar(state),
        );
      },
    );
  }

  Widget _buildBody(int index) {
    if (index == BottomNavConstants.searchTabIndex) {
      return const SearchScreen();
    }
    return BottomNavConstants.screens[index];
  }

  Widget _buildAnimatedNavigationBar(BottomNavState state) =>
      AnimatedBottomNavigationBar.builder(
        itemCount: BottomNavConstants.iconList.length,

        tabBuilder: (int index, bool isActive) => BottomNavTab(
          iconData: BottomNavConstants.iconList[index],
          title: BottomNavConstants.titles[index],
          isActive: isActive,
        ),

        backgroundColor: AppColors.softBlue,
        activeIndex: state.index,
        onTap: (index) => context.read<BottomNavCubit>().changeTabIndex(index),
        hideAnimationController: _hideBottomBarAnimationController,
        gapLocation: GapLocation.center,

        notchSmoothness: NotchSmoothness.defaultEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
      );
}
