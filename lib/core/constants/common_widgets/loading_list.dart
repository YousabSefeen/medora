import 'package:flutter/material.dart';
import 'package:medora/core/constants/common_widgets/custom_shimmer.dart'
    show CustomShimmer;

class LoadingList extends StatelessWidget {
  final double height;

  const LoadingList({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) =>
          CustomShimmer(height: height, width: deviceSize.width * 8),
    );
  }
}
