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

  final ValueNotifier<bool> _isFabVisible = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
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
      bottomNavigationBar: _buildAnimatedNavigationBar(),
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: _handleScrollNotification,
          child: BlocBuilder<BottomNavCubit, BottomNavState>(
            buildWhen: (prev, curr) => prev.index != curr.index,
            builder: (context, state) => _buildBody(state.index),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(int index) {
    if (index == BottomNavConstants.searchTabIndex) return const SearchScreen();
    return BottomNavConstants.screens[index];
  }

  Widget _buildAnimatedNavigationBar() => RepaintBoundary(
    child: BlocBuilder<BottomNavCubit, BottomNavState>(
      buildWhen: (prev, curr) => prev.index != curr.index,
      builder: (context, state) {
        return AnimatedBottomNavigationBar.builder(
          itemCount: BottomNavConstants.iconList.length,
          tabBuilder: (int index, bool isActive) => BottomNavTab(
            iconData: BottomNavConstants.iconList[index],
            title: BottomNavConstants.titles[index],
            isActive: isActive,
          ),
          backgroundColor: AppColors.softBlue,
          activeIndex: state.index,
          onTap: (index) =>
              context.read<BottomNavCubit>().changeTabIndex(index),
          hideAnimationController: _hideBottomBarAnimationController,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.defaultEdge,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
        );
      },
    ),
  );
}

class _BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavState>(
      buildWhen: (prev, curr) => prev.index != curr.index,
      builder: (context, state) {
        if (state.index == 0) {
          return PreferredSize(preferredSize: Size.zero, child: Container());
        }
        return AppBar(
          backgroundColor: AppColors.customWhite,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(BottomNavConstants.appBarTitles[state.index]),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
