import 'package:flutter/material.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';

class FilterSectionTitle extends StatelessWidget {
  final String title;

  const FilterSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: ValueKey(title),
      padding: const EdgeInsets.only(bottom: 10, top: 20),
      child: Text(title, style: Theme.of(context).textTheme.caladeaWhite),
    );
  }
}
