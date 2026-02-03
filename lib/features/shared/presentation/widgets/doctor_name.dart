import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/string_extensions.dart';

class DoctorName extends StatelessWidget {
  final String name;


  const DoctorName({super.key, required this.name });

  @override
  Widget build(BuildContext context) {
    return Text(
      '${AppStrings.dR}${name.toCapitalizeFirstLetter()}',

      style: Theme.of(context).textTheme.largeBlackBold,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
