import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:medora/core/extensions/theme_extension.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../../core/constants/themes/app_text_styles.dart';
import '../../domain/entities/review_entity.dart';

class ReviewsList extends StatelessWidget {
  final List<ReviewEntity> reviews;

  final double rating;
  final int ratingCount;

  const ReviewsList({
    super.key,
    required this.reviews,
    required this.rating,
    required this.ratingCount,
  });

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        // 1. Top Summary Section
        SliverToBoxAdapter(
          child: _RatingSummaryHeader(
            rating: rating,
            ratingCount: ratingCount,
            reviews: reviews,
          ),
        ),

        // 2. List Title
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Text(
              '${AppStrings.userReviews} (${reviews.length})',
              style: context.textTheme.mediumBlackBold16,
            ),
          ),
        ),

        // 3. Rating List
        reviews.isEmpty
            ? SliverFillRemaining(
                child: Center(
                  child: Text(
                    AppStrings.noReviews,
                    style: context.textTheme.subTitle,
                  ),
                ),
              )
            : SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: reviews.length,
                    (context, index) => _ReviewCardTile(review: reviews[index]),
                  ),
                ),
              ),
      ],
    );
  }
}

class _RatingSummaryHeader extends StatelessWidget {
  final double rating;
  final int ratingCount;
  final List<ReviewEntity> reviews;

  const _RatingSummaryHeader({
    required this.rating,
    required this.ratingCount,
    required this.reviews,
  });

  // calculate the percentage of each star out of the total ratings
  double _calculateStarPercentage(int starRating) {
    if (ratingCount == 0 || reviews.isEmpty) return 0.0;
    final count = reviews.where((r) => r.rating.round() == starRating).length;
    return count / ratingCount;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 1)),
        ],
      ),
      child: Row(
        children: [
          // 1. Left side: Overall rating and stars
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  rating.toStringAsFixed(1),

                  style: context.textTheme.largeBlack,
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Icon(
                      index < rating.floor()
                          ? Icons.star_rounded
                          : (index < rating && rating % 1 != 0)
                          ? Icons.star_half_rounded
                          : Icons.star_outline_rounded,
                      color: Colors.amber,
                      size: 16.sp,
                    );
                  }),
                ),
                SizedBox(height: 6.h),
                Text(
                  '$ratingCount ${AppStrings.reviewsLabile}',
                  style: context.textTheme.authFieldTitle.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),
          Container(height: 90.h, width: 1.w, color: Colors.grey[200]),
          SizedBox(width: 12.w),

          // 2. Right side: Ratio indicators for each star (5 -> 1)
          Expanded(
            flex: 3,
            child: Column(
              children: List.generate(5, (index) {
                final starNum = 5 - index; // It starts from 5 and ends with 1
                final percent = _calculateStarPercentage(starNum);

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: Row(
                    children: [
                      Text(
                        '$starNum',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: 12.sp,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: LinearPercentIndicator(
                          lineHeight: 6.h,
                          percent: percent.clamp(0.0, 1.0),
                          progressColor: Colors.amber,
                          backgroundColor: Colors.grey[200],
                          barRadius: Radius.circular(8.r),
                          padding: EdgeInsets.zero,
                          animation: true,
                          animationDuration: 1000,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCardTile extends StatelessWidget {
  final ReviewEntity review;

  const _ReviewCardTile({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: Theme.of(
                  context,
                ).primaryColor.withOpacity(0.1),
                backgroundImage:
                    review.clientImage != null && review.clientImage!.isNotEmpty
                    ? NetworkImage(review.clientImage!)
                    : null,
                child: review.clientImage == null || review.clientImage!.isEmpty
                    ? Text(
                        review.clientName.isNotEmpty
                            ? review.clientName[0].toUpperCase()
                            : 'U',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : null,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.clientName,
                      style: context.textTheme.smallOrangeMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      DateFormat('dd MMM yyyy').format(review.createdAt),
                      style: context.textTheme.smallGreyMedium,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: Colors.amber[700],
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      review.rating.toString(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber[900],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (review.comment.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Text(
              review.comment,
              style: context.textTheme.smallOrangeMedium.copyWith(
                fontSize: 13.sp,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
