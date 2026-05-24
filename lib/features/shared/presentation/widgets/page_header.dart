import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final String title;

  const PageHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: Center(
        child: Text(
          title,
          style: Theme.of(context).appBarTheme.titleTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
