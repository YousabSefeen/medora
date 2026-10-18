import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext, BlocSelector;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart' show TypeAheadField;
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons, FaIcon;
import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/app_duration/app_duration.dart';
import 'package:medora/core/constants/app_routes/app_router_names.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/enum/navigation_source.dart' show NavigationSource;
import 'package:medora/core/extensions/context_extension.dart';
import 'package:medora/core/extensions/media_query_extension.dart'
    show MediaQueryExtension;
import 'package:medora/features/search/presentation/controller/cubit/home_doctor_search_cubit.dart'
    show HomeDoctorSearchCubit;
import 'package:medora/features/search/presentation/controller/states/home_doctor_search_states.dart';
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;
import 'package:medora/features/shared/presentation/widgets/empty_search_list_results.dart'
    show EmptySearchListResult;

import '../../../../core/constants/common_widgets/app_network_image.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/extensions/theme_extension.dart';

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

        return TypeAheadField<DoctorEntity>(
          hideOnEmpty: isFelledEmpty,
          hideOnUnfocus: false,
          // hideWithKeyboard: false,
          hideOnSelect: false,

          constraints: const BoxConstraints(),
          debounceDuration: AppDurations.milliseconds_700,
          decorationBuilder: (BuildContext context, Widget? widget) =>
              _buildDecorationBuilder(context, isFelledEmpty, widget),
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
          animationDuration: AppDurations.milliseconds_400,
          onSelected: (doctor) => _handleDoctorSelection(doctor, context),
          loadingBuilder: _buildLoadingIndicator,
        );
      },
    );
  }

  /*  Material _buildDecorationBuilder(
    BuildContext context,
    bool isFelledEmpty,
    Widget? widget,
  ) => Material(
    elevation: 1,
    color: AppColors.white,
    shadowColor: AppColors.steelGray,
    borderRadius: BorderRadius.circular(12.r),
    child: Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 5),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: isFelledEmpty ? 0.0 : context.screenHeight * 0.12,
          maxHeight: context.screenHeight * 0.75,
        ),
        child: widget,
      ),
    ),
  );*/
  Widget _buildDecorationBuilder(
    BuildContext context,
    bool isFelledEmpty,
    Widget? widget,
  ) => isFelledEmpty
      ? const SizedBox.shrink()
      : Material(
          elevation: 1,
          color: AppColors.white,
          shadowColor: AppColors.steelGray,
          borderRadius: BorderRadius.circular(12.r),

          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: context.screenHeight * 0.12,
                maxHeight: context.screenHeight * 0.75,
              ),
              child: widget,
            ),
          ),
        );

  Widget _buildEmptyBuilder(BuildContext context) => Container(
    width: double.infinity,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.sizeOf(context).height * 0.5,
    ),
    child: const EmptySearchListResult(),
  );

  Widget _itemSeparatorBuilder(BuildContext context, int index) => Divider(
    color: Colors.grey.shade200,
    indent: 20,
    endIndent: 20,
    thickness: 1,
  );

  Future<List<DoctorEntity>> _performInstantSearch(
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
      style: textTheme.styleInputField.copyWith(
        color: Colors.white,
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      cursorColor: AppColors.darkBlue,
      cursorHeight: 20.sp,
      decoration: _createInputDecoration(textTheme),
    );
  }

  InputDecoration _createInputDecoration(TextTheme textTheme) =>
      InputDecoration(
        filled: true,
        fillColor: AppColors.blueAccent,

        prefix: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: FaIcon(
            FontAwesomeIcons.magnifyingGlass,
            size: 15.sp,
            color: AppColors.white,
          ),
        ),
        contentPadding: isExpanded
            ? EdgeInsets.only(left: 15.w, right: 28.w)
            : EdgeInsets.zero,

        hint: Text(
          AppStrings.searchHint,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.5,

            height: 0,
          ),
        ),
        border: _createBorder(),
        focusedBorder: _createBorder(),
        hintStyle: _createHintTextStyle(),
      );

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

  _DoctorCard _buildSuggestionItem(BuildContext context, DoctorEntity doctor) =>
      _DoctorCard(doctor: doctor);

  void _handleDoctorSelection(DoctorEntity doctor, BuildContext context)async {
    await context.ensureKeyboardIsClosed();
    final Map<String, dynamic> extra = {
      'doctor': doctor,
      'navigationSource': NavigationSource.search,
    };
    if(!context.mounted) return;
    context.push(AppRouterNames.createAppointment, extra: extra);
  }

  Padding _buildLoadingIndicator(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
    child: LinearProgressIndicator(color: Colors.amber),
  );
}

class _DoctorCard extends StatelessWidget {
  final DoctorEntity doctor;

  const _DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          AppNetworkImage(
            heroTag: 'No Hero',
            imageUrl: doctor.imageUrl,
            imageRadius: 360,
            height: 70,
            width: 70,
            padding: EdgeInsets.zero,
            side: const BorderSide(color: Colors.black12),
          ),

          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor Name + Favorite Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        'Dr. ${doctor.name.toCapitalizeFirstLetter()}',
                        style: context.textTheme.doctorName.copyWith(
                          fontSize: 15.sp,
                        ),
                        maxLines: 1,
                      ),
                    ),

                    const SizedBox(width: 10),
                  ],
                ),

                // Specialty
                Text(
                  doctor.specialties.first,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.dustyBlue,
                    height: 1.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),

                // Rating
                Row(
                  children: [
                    // ratingIconSize: 11.sp,
                    // ratingFontSize: 12.sp,
                    FaIcon(
                      FontAwesomeIcons.solidStar,
                      size: 11.sp,
                      color: const Color(0xFFFF4D4D),
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      doctor.rating.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2C3E50),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        '|  ${doctor.ratingCount} reviews',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color(0xFF8D99AE),
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),

                // Location
              ],
            ),
          ),
        ],
      ),
    );
  }
}
