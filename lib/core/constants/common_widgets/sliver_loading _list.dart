import 'package:flutter/material.dart';

import 'custom_shimmer.dart';

class SliverLoadingList extends StatelessWidget {
  final double height;

  const SliverLoadingList({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    return SliverList.builder(
      itemCount: 20,
      itemBuilder: (context, index) =>CustomShimmer(
        height: height,
        width: deviceSize.width * 8,
      ),
    );
  }
}


/*
 return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: deviceSize.height * 0.88,
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) => CustomShimmer(
                height: height,
                width: deviceSize.width * 8,
              ),
            ),
          ),
        ],
      ),
    );
 */