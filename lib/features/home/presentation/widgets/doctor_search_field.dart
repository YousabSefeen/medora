import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext, BlocSelector;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart' show TypeAheadField;
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons;
import 'package:medora/core/constants/app_duration/app_duration.dart';
import 'package:medora/core/constants/app_routes/app_router.dart'
    show AppRouter;
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/enum/navigation_source.dart' show NavigationSource;
import 'package:medora/features/appointments/presentation/screens/create_appointment_screen.dart'
    show CreateAppointmentScreen;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/search/presentation/controller/cubit/home_doctor_search_cubit.dart'
    show HomeDoctorSearchCubit;
import 'package:medora/features/search/presentation/controller/states/home_doctor_search_states.dart';
import 'package:medora/features/shared/presentation/widgets/doctor_search_card.dart' show DoctorSearchCard;
import 'package:medora/features/shared/presentation/widgets/empty_search_list_results.dart' show EmptySearchListResult;


class DoctorSearchField extends StatelessWidget {
  final bool isExpanded;

  const DoctorSearchField({super.key, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    if (!isExpanded) {
      return const SizedBox.shrink();
    }
    return BlocSelector<HomeDoctorSearchCubit, HomeDoctorSearchStates, String?>(
      selector: (HomeDoctorSearchStates state) => state.doctorName,

      builder: (BuildContext context, String? doctorName) {
        final bool isFelledEmpty = doctorName == null || doctorName == '';

        return TypeAheadField<DoctorModel>(
          hideOnEmpty: isFelledEmpty,
          hideOnUnfocus: false,
          hideWithKeyboard: false,
          hideOnSelect: false,

          constraints: const BoxConstraints(),
          debounceDuration: AppDurations.milliseconds_700,
          decorationBuilder: (BuildContext context, Widget? widget) =>
              _buildDecorationBuilder(isFelledEmpty, widget),
          emptyBuilder: _buildEmptyBuilder,

          suggestionsCallback: (pattern) =>
              _performInstantSearch(pattern, context),
          builder:
              (
                BuildContext context,
                TextEditingController controller,
                FocusNode focusNode,
              ) {
                return _buildSearchTextField(
                  doctorName,
                  context,
                  controller,
                  focusNode,
                );
              },

          itemBuilder: _buildSuggestionItem,

          itemSeparatorBuilder: _itemSeparatorBuilder,
          onSelected: (doctor) => _handleDoctorSelection(doctor, context),
          loadingBuilder: _buildLoadingIndicator,
        );
      },
    );
  }

  Container _buildDecorationBuilder(bool isFelledEmpty, Widget? widget) =>
      Container(
        decoration: BoxDecoration(
          color: AppColors.customWhite,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: isFelledEmpty ? [] : _buildBoxShadow(),
        ),
        child: widget,
      );

  List<BoxShadow> _buildBoxShadow() => const [
    BoxShadow(
      color: AppColors.softBlue,
      spreadRadius: 1,
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];

  Widget _buildEmptyBuilder(BuildContext context) => Container(
    height: MediaQuery.sizeOf(context).height * 0.5,
    color: Colors.white,
    child: const EmptySearchListResult(),
  );

  Widget _itemSeparatorBuilder(BuildContext context, int index) =>
      const Divider(
        color: Colors.black12,
        indent: 10,
        endIndent: 10,
        height: 10,
        thickness: 2,
      );

  Future<List<DoctorModel>> _performInstantSearch(
    String searchPattern,
    BuildContext context,
  ) async {
    final cubit = context.read<HomeDoctorSearchCubit>();
    final doctorsList = await cubit.searchDoctorsInstant(searchPattern);

    return doctorsList;
  }

  TextFormField _buildSearchTextField(
    String? doctorName,
    BuildContext context,
    TextEditingController controller,
    FocusNode focusNode,
  ) {
    controller.text = doctorName ?? '';

    final TextTheme textTheme = Theme.of(context).textTheme;

    return TextFormField(
      autofocus: true,
      controller: controller,
      focusNode: focusNode,
      readOnly: !isExpanded,
      style: _createTextFieldTextStyle(textTheme),
      cursorColor: Colors.black,
      cursorHeight: 20.sp,
      decoration: _createInputDecoration(textTheme),
    );
  }

  TextStyle _createTextFieldTextStyle(TextTheme textTheme) =>
      textTheme.styleInputField.copyWith(color: Colors.white, fontSize: 18.sp);

  InputDecoration _createInputDecoration(TextTheme textTheme) =>
      InputDecoration(
        filled: true,
        fillColor: AppColors.blueAccent,
        prefixIcon: _buildPrefixIcon(),
        contentPadding: _calculateContentPadding(),

        hint: _buildHintWidget(textTheme),
        border: _createBorder(),
        focusedBorder: _createBorder(),
        hintStyle: _createHintTextStyle(),
      );

  Icon _buildPrefixIcon() => Icon(
    FontAwesomeIcons.magnifyingGlass,
    size: 15.sp,
    color: AppColors.white,
  );

  Text _buildHintWidget(TextTheme textTheme) {
    return Text(
      AppStrings.searchHint,
      style: textTheme.hintFieldStyle.copyWith(
        color: AppColors.darkBlue,
        letterSpacing: 1.5,
        height: 0,
      ),
    );
  }

  EdgeInsets _calculateContentPadding() =>
      isExpanded ? EdgeInsets.only(left: 15.w, right: 28.w) : EdgeInsets.zero;

  InputBorder _createBorder() => const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30.0)),

    borderSide: BorderSide.none,
  );

  TextStyle _createHintTextStyle() {
    return TextStyle(
      fontSize: 13.sp,
      color: Colors.grey.shade900,
      fontWeight: FontWeight.w500,
    );
  }

  DoctorSearchCard _buildSuggestionItem(
    BuildContext context,
    DoctorModel doctor,
  ) => DoctorSearchCard(doctor: doctor);

  void _handleDoctorSelection(DoctorModel doctor, BuildContext context) =>
      AppRouter.push(
        context,
        CreateAppointmentScreen(
          doctor: doctor,
          navigationSource: NavigationSource.search,
        ),
      );

  Widget _buildLoadingIndicator(BuildContext context) =>
      const LinearProgressIndicator(color: Colors.amber);
}
