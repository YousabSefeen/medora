import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/animations/custom_animation_transition.dart'
    show CustomAnimationTransition;
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/enum/animation_type.dart' show AnimationType;
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart';
import 'package:medora/features/search/presentation/controller/states/search_states.dart';

class PriceDisplayWidget extends StatelessWidget {
  const PriceDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildMinPriceSection(context),

        _buildPriceSeparator(),

        _buildMaxPriceSection(context),
      ],
    );
  }

  Widget _buildMinPriceSection(BuildContext context) {
    return _buildPriceItem(
      context: context,
      priceSelector: (range) => range.start.round(),
    );
  }

  Widget _buildMaxPriceSection(BuildContext context) {
    return _buildPriceItem(
      context: context,
      priceSelector: (range) => range.end.round(),
    );
  }

  Widget _buildPriceSeparator() =>const Text(
    '  -  ',
    style:  TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
  );

  Widget _buildPriceItem({
    required BuildContext context,

    required Function(RangeValues) priceSelector,
  }) {
    final textStyle = Theme.of(
      context,
    ).textTheme.latoSemiBoldDark.copyWith(
      fontSize: 18.sp
    );
    return BlocSelector<SearchCubit, SearchStates, RangeValues>(
      selector: (state) => state.priceRange,
      builder: (context, priceRange) {
        final priceValue = priceSelector(priceRange);
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCurrencySymbol(textStyle),
            _buildAnimatedPriceValue(priceValue, textStyle),
          ],
        );
      },
    );
  }

  Widget _buildCurrencySymbol(TextStyle textStyle) =>
      Text('EGP ', style: textStyle.copyWith(

      ));

  Widget _buildAnimatedPriceValue(int price, TextStyle textStyle) {
    return CustomAnimationTransition(
      animationType: AnimationType.slideUp,
      child: Text(key: ValueKey(price), price.toString(), style: textStyle),
    );
  }
}
