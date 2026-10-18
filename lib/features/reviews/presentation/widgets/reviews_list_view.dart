// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:medora/features/reviews/presentation/controller/cubit/reviews_cubit.dart';
// import 'package:medora/features/reviews/presentation/controller/states/reviews_state.dart';
//
// import '../../../../core/constants/common_widgets/sliver_loading _list.dart';
// import '../../../../core/constants/themes/app_colors.dart';
// import '../../../../generated/assets.dart';
// import '../../domain/entities/review_entity.dart';
//
// class ReviewsListView extends StatefulWidget {
//   const ReviewsListView({super.key});
//
//   @override
//   State<ReviewsListView> createState() => _ReviewsListViewState();
// }
//
// class _ReviewsListViewState extends State<ReviewsListView> {
//   @override
//   void initState() {
//     context.read<ReviewsCubit>().fetchDoctorReviews(
//       'bNo7XLWQxac4vwQR91RJnxfP0GJ3',
//     );
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ReviewsCubit, ReviewsState>(
//       builder: (context, state) {
//         if (state is GetReviewsLoading) {
//           return const SliverPadding(
//             padding: EdgeInsets.symmetric(horizontal: 10),
//             sliver: SliverLoadingList(height: 100),
//           );
//         } else if (state is GetReviewsSuccess) {
//           return SliverList.builder(
//             itemCount: state.reviews.length,
//
//             itemBuilder: (context, index) =>
//                 _ReviewItem(review: state.reviews[index]),
//           );
//         } else if (state is GetReviewsFailure) {
//           return const SliverLoadingList(height: 150);
//         }
//         return const SliverLoadingList(height: 150);
//       },
//     );
//   }
// }
//
// class _ReviewItem extends StatelessWidget {
//   final ReviewEntity review;
//
//   const _ReviewItem({super.key, required this.review});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
//       child: Column(
//         children: [
//           Row(
//             spacing: 10,
//             children: [
//               CircleAvatar(
//                 radius: 20.r,
//                 child: ClipOval(
//                   child: CachedNetworkImage(
//                     imageUrl: review.clientImage,
//                     fit: BoxFit.cover,
//                     placeholder: (context, _) => Assets.images.loading.image(),
//                     errorWidget: (context, _, _) => Assets.images.error.image(),
//                   ),
//                 ),
//               ),
//
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//
//                 children: [
//                   const SizedBox(height: 5),
//                   Text(
//                     review.clientName,
//                     style: Theme.of(context).listTileTheme.titleTextStyle!
//                         .copyWith(fontSize: 13, color: AppColors.softBlue),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     review.comment,
//                     style: const TextStyle(
//                       fontSize: 13,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//
//         ],
//       ),
//     );
//   }
// }
