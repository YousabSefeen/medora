import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart' show KeyboardVisibilityBuilder;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart' show AppAlerts;
import 'package:medora/core/constants/app_routes/app_router.dart' show AppRouter;
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart' show SearchCubit;
import 'package:medora/features/search/presentation/controller/states/search_states.dart' show SearchStates;
import 'package:medora/features/search/presentation/widgets/filter_sheet_content.dart' show FilterSheetContent;

class FilterButton extends StatelessWidget {


  const FilterButton({super.key, });

  @override
  Widget build(BuildContext context) {
    return   KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) => BlocSelector<SearchCubit, SearchStates, bool>(
        selector: (state) => state.isSearchingByCriteria,
        builder: (context, isSearchingByCriteria) =>  ElevatedButton(
          style: _buildButtonStyle(  isSearchingByCriteria),
          onPressed: (){
            if (isKeyboardVisible) {
              _dismissKeyboardThenShowFilterBottomSheet(context);
            } else {
              _showFilterBottomSheet(context);
            }
          },
          child:   buildFilterIcon(isSearchingByCriteria),
        ),
      ),
    );
  }

  FaIcon buildFilterIcon(bool isSearchingByCriteria) {
    return FaIcon(
          FontAwesomeIcons.sliders,
          color:isSearchingByCriteria? AppColors.white: Colors.black54,
          size: 18.sp,
        );
  }
  void _dismissKeyboardThenShowFilterBottomSheet(BuildContext context) {
    AppRouter.dismissKeyboard();

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!context.mounted) return;
      _showFilterBottomSheet(context);
    });
  }

  void _showFilterBottomSheet(BuildContext context) {
    AppAlerts.showCustomBottomSheet(
      shouldShowScrollbar: false,
      context: context,
      appBarBackgroundColor: AppColors.white,
      appBarTitle: 'Filter Search',
      appBarTitleColor: AppColors.black,
      body: const FilterSheetContent(),
    );
  }
  ButtonStyle _buildButtonStyle(  bool isSearchingByCriteria    ) => ButtonStyle(
      padding: WidgetStateProperty.all(EdgeInsets.zero),
      backgroundColor: WidgetStateProperty.all(isSearchingByCriteria? AppColors.softBlue:  AppColors.fieldFillColor),
      elevation: WidgetStateProperty.all(1),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: const BorderSide(color: AppColors.fieldBorderColor),
        ),
      ),
      minimumSize: WidgetStateProperty.all(const Size(50, 40)),
    );
}