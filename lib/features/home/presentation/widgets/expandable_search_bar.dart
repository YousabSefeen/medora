import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons, FaIcon;
import 'package:medora/core/constants/app_duration/app_duration.dart'
    show AppDurations;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/enum/search_bar_state.dart' show SearchBarState;
import 'package:medora/features/home/presentation/constants/home_constants.dart'
    show HomeConstants;
import 'package:medora/features/home/presentation/widgets/doctor_search_field.dart'
    show DoctorSearchField;
import 'package:medora/features/home/presentation/widgets/home_app_bar_button.dart'
    show HomeAppBarButton;

class ExpandableSearchBar extends StatefulWidget {
  const ExpandableSearchBar({super.key});

  @override
  State<ExpandableSearchBar> createState() => _ExpandableSearchBarState();
}

class _ExpandableSearchBarState extends State<ExpandableSearchBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  SearchBarState _currentState = SearchBarState.collapsed;

  @override
  void initState() {
    super.initState();
    _initializeAnimationController();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _initializeAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      duration: AppDurations.milliseconds_1200,
    );
  }

  void _collapseSearchBar() {
    _unfocusKeyboard();
    _animationController.reverse();
    _updateSearchState(SearchBarState.collapsed);
  }

  void _expandSearchBar() {
    _animationController.forward();
    _updateSearchState(SearchBarState.expanded);
  }

  void _updateSearchState(SearchBarState newState) {
    setState(() => _currentState = newState);
  }

  void _toggleSearchBar() {
    if (_currentState == SearchBarState.collapsed) {
      _expandSearchBar();
    } else {
      _collapseSearchBar();
    }
  }

  void _unfocusKeyboard() {
    final focusScope = FocusScope.of(context);
    if (!focusScope.hasPrimaryFocus && focusScope.hasFocus) {
      focusScope.unfocus();
    }
  }

  bool get _isExpanded => _currentState == SearchBarState.expanded;

  @override
  Widget build(BuildContext context) {
    return _buildAnimatedSearchContainer();
  }

  AnimatedContainer _buildAnimatedSearchContainer() => AnimatedContainer(
    alignment: Alignment.centerLeft,
    duration: AppDurations.milliseconds_1000,
    height: _calculateContainerHeight(),
    width: _calculateContainerWidth(),
    curve: Curves.easeOut,
    decoration: _buildContainerDecoration(),
    child: Stack(
      children: [
        _buildSearchField(),
        _buildCloseButton(),
        _buildSearchButton(),
      ],
    ),
  );

  double _calculateContainerHeight() => _isExpanded
      ? HomeConstants.barContentHeight
      : HomeConstants.appBarIconSize;

  double _calculateContainerWidth() => _isExpanded
      ? HomeConstants.appBarWidth(context)
      : HomeConstants.appBarIconSize;

  BoxDecoration _buildContainerDecoration() =>
      HomeConstants.createBarActionDecoration(hasShadow: !_isExpanded);

  Visibility _buildSearchButton() => Visibility(
    visible: !_isExpanded,
    child: HomeAppBarButton(
      onPressed: _toggleSearchBar,
      icon: FontAwesomeIcons.magnifyingGlass,
    ),
  );

  Visibility _buildSearchField() => Visibility(
    visible: _isExpanded,
    child: AnimatedOpacity(
      opacity: 1,
      duration: AppDurations.milliseconds_500,
      curve: Curves.easeOut,
      child: DoctorSearchField(isExpanded: _isExpanded),
    ),
  );

  Visibility _buildCloseButton() => Visibility(
    visible: _isExpanded,
    child: AnimatedAlign(
      alignment: Alignment.centerRight,
      duration: AppDurations.milliseconds_1200,
      curve: Curves.easeOut,
      child: _buildAnimatedCloseIcon(),
    ),
  );

  AnimatedBuilder _buildAnimatedCloseIcon() => AnimatedBuilder(
    animation: _animationController,
    builder: (context, child) => Transform.rotate(
      angle: _animationController.value * 2.0 * pi,
      child: child,
    ),
    child: _buildCloseIcon(),
  );

  GestureDetector _buildCloseIcon() => GestureDetector(
    onTap: _toggleSearchBar,
    child: Padding(
      padding: EdgeInsets.only(right: 5.w),
      child: CircleAvatar(
        radius: 12.r,
        backgroundColor: AppColors.red,
        child: FaIcon(
          FontAwesomeIcons.xmark,
          size: HomeConstants.iconSize,
          color: Colors.white,
        ),
      ),
    ),
  );
}
