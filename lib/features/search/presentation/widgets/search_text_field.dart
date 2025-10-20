import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late final SearchCubit _searchCubit;
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchCubit = context.read<SearchCubit>();
    _searchController = TextEditingController(
      text: _searchCubit.state.doctorName,
    );
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextFormField(
      style: textTheme.styleInputField,
      controller: _searchController,
      onChanged: (query) => _updateDoctorName(query),
      decoration: InputDecoration(
        prefixIcon: _buildSearchIcon(),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        hintText: 'Find the right doctor for you',
        hintStyle: textTheme.hintFieldStyle,
        fillColor: AppColors.fieldFillColor,
        filled: true,
        border: _buildBorder(AppColors.fieldBorderColor),
        enabledBorder: _buildBorder(AppColors.fieldBorderColor),
        focusedBorder: _buildBorder(Colors.black26),
        errorBorder: _buildBorder(Colors.red),
        errorStyle: textTheme.styleInputFieldError,
      ),
    );
  }

  Widget _buildSearchIcon() => Padding(
    padding: EdgeInsets.all(12.sp),
    child: FaIcon(
      FontAwesomeIcons.magnifyingGlass,
      color: Colors.grey,
      size: 15.sp,
    ),
  );

  OutlineInputBorder _buildBorder(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(18.r),
    borderSide: BorderSide(color: color),
  );

  void _updateDoctorName(String query) =>
      _searchCubit.updateDoctorName(doctorName: query);
}
