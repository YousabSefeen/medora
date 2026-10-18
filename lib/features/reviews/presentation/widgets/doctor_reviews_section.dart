import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:medora/core/enum/lazy_request_state.dart';
import 'package:medora/features/reviews/presentation/controller/cubit/reviews_cubit.dart';
import 'package:medora/features/reviews/presentation/controller/states/reviews_state.dart';
import 'package:medora/features/reviews/presentation/widgets/reviews_list.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/constants/common_widgets/sliver_loading _list.dart';
import '../../domain/entities/review_entity.dart';

class DoctorReviewsSection extends StatefulWidget {
  final String doctorId;
  final double rating;
  final int ratingCount;

  const DoctorReviewsSection({
    super.key,
    required this.doctorId,
    required this.rating,
    required this.ratingCount,
  });

  @override
  State<DoctorReviewsSection> createState() => _DoctorReviewsSectionState();
}

class _DoctorReviewsSectionState extends State<DoctorReviewsSection> {
  @override
  void initState() {
    context.read<ReviewsCubit>().fetchReviews(widget.doctorId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsCubit, ReviewsState>(
      builder: (context, state) {
        switch(state.fetchReviewsStatus){

          case LazyRequestState.lazy:
            return const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              sliver: SliverLoadingList(height: 100),
            );
          case LazyRequestState.loading:
            return const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              sliver: SliverLoadingList(height: 100),
            );
          case LazyRequestState.loaded:
            return ReviewsList( reviews:state.reviews,rating:  widget.rating, ratingCount: widget.ratingCount);
          case LazyRequestState.error:
            return const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              sliver: SliverLoadingList(height: 100),
            );
        }

      },
    );
  }
}

