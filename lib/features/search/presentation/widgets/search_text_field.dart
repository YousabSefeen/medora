import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextFormField(
      style: textTheme.styleInputField,
      onChanged: (query) => _onSearchQueryChanged(context, query),
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

  Widget _buildSearchIcon() {
    return const Padding(
      padding: EdgeInsets.all(12),
      child: FaIcon(
        FontAwesomeIcons.magnifyingGlass,
        color: Colors.grey,
        size: 15,
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: color),
    );
  }

  void _onSearchQueryChanged(BuildContext context, String query) {

    context.read<SearchCubit>().doctorNameFilter(query);
    context.read<SearchCubit>().onSearchQueryChanged(query);
  }
}
