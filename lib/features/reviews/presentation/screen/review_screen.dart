import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medora/features/reviews/domain/params/delete_review_params.dart';

import '../../../../core/constants/app_alerts/app_alerts.dart';
import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../../core/constants/common_widgets/app_network_image.dart';
import '../../../../core/constants/common_widgets/error_retry_widget.dart';
import '../../../../core/constants/themes/app_colors.dart';
import '../../../../core/enum/lazy_request_state.dart';
import '../../../../core/enum/review_operation.dart';
import '../../../../core/services/overlay_notification_service.dart';
import '../../../appointments/domain/entities/client_appointments_entity.dart';
import '../../../appointments/presentation/controller/cubit/completed_appointments_cubit.dart';
import '../../../doctor_list/presentation/controller/cubit/doctor_list_cubit.dart';
import '../../../favorites/presentation/controller/cubit/favorites_cubit.dart';
import '../../../shared/presentation/widgets/custom_app_bar.dart';
import '../../../shared/presentation/widgets/custom_circular_progress.dart';
import '../../../shared/presentation/widgets/labeled_text_field.dart';
import '../../../shared/presentation/widgets/primary_button.dart';
import '../../../shared/presentation/widgets/rating_bar_badge.dart';
import '../../../shared/presentation/widgets/secondary_button.dart';
import '../../../user/presentation/controllers/cubit/user_cubit.dart';
import '../../domain/entities/updated_doctor_rating.dart';
import '../../domain/params/add_review_params.dart';
import '../../domain/params/update_review_params.dart';
import '../controller/cubit/reviews_cubit.dart';
import '../controller/states/reviews_state.dart';

class ReviewScreen extends StatefulWidget {
  final ClientAppointmentsEntity appointment;

  const ReviewScreen({super.key, required this.appointment});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  ClientAppointmentsEntity get appointment => widget.appointment;
  late final TextEditingController _commentController;
  double _rating = 2.5;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
    _loadInitialReview();
  }

  void _loadInitialReview() {
    if (appointment.isReviewed && appointment.reviewId != null) {
      context.read<ReviewsCubit>().fetchSingleReview(appointment.reviewId!);
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isReviewed = appointment.isReviewed;

    return Scaffold(
      appBar: CustomAppBar(
        title: isReviewed ? AppStrings.editReview : AppStrings.writeAReview,
        backgroundColor: Colors.white,
        actions: [
          if (isReviewed) _DeleteReviewIconButton(onPressed: _onDeletePressed),
        ],
      ),
      bottomNavigationBar: _ReviewBottomBar(
        isReviewed: isReviewed,
        onSubmitPressed: _onSubmitPressed,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ReviewsCubit, ReviewsState>(
            listenWhen: (prev, curr) =>
                prev.fetchSingleReviewStatus != curr.fetchSingleReviewStatus &&
                curr.fetchSingleReviewStatus == LazyRequestState.loaded,
            listener: (context, state) {
              if (state.selectedReview != null) {
                setState(() {
                  _rating = state.selectedReview!.rating;
                  _commentController.text = state.selectedReview!.comment;
                });
              }
            },
          ),
          BlocListener<ReviewsCubit, ReviewsState>(
            listenWhen: (prev, curr) => prev.actionStatus != curr.actionStatus,
            listener: _handleActionStateChanges,
          ),
        ],
        child: isReviewed ? const _SingleReviewFetcherBody() : _buildFormBody(),
      ),
    );
  }

  Widget _buildFormBody() => _ReviewFormBody(
    doctorName: appointment.doctorEntity.name,
    doctorImageUrl: appointment.doctorEntity.imageUrl,
    commentController: _commentController,
    rating: _rating,
    onRatingUpdate: (newRating) => setState(() => _rating = newRating),
  );

  void _onDeletePressed() {
    final selectedRating =
        context.read<ReviewsCubit>().state.selectedReview?.rating ?? _rating;

    context.read<ReviewsCubit>().deleteReview(
      DeleteReviewParams(
        reviewId: appointment.reviewId!,
        appointmentId: appointment.appointmentId,
        doctorId: appointment.doctorId,
        ratingToDelete: selectedRating,
      ),
    );
  }

  void _onSubmitPressed() {
    final cubit = context.read<ReviewsCubit>();
    final comment = _commentController.text.trim();

    if (appointment.isReviewed && appointment.reviewId != null) {
      final initialRating = cubit.state.selectedReview?.rating ?? _rating;
      cubit.updateReview(
        UpdateReviewParams(
          reviewId: appointment.reviewId!,
          appointmentId: appointment.appointmentId,
          doctorId: appointment.doctorId,
          oldRating: initialRating,
          newRating: _rating,
          newComment: comment,
        ),
      );
    } else {
      final currentUser = context.read<UserCubit>().currentUser;
      cubit.addReview(
        AddReviewParams(
          appointmentId: appointment.appointmentId,
          doctorId: appointment.doctorId,
          clientId: appointment.clientId,
          clientName: currentUser?.name ?? 'Anonymous',
          clientImage: currentUser?.imageUrl ?? '',
          rating: _rating,
          comment: comment,
        ),
      );
    }
  }

  void _handleActionStateChanges(BuildContext context, ReviewsState state) {
    switch (state.actionStatus) {
      case LazyRequestState.loading:
        AppAlerts.showCircularProgressIndicatorLoadingDialog(context);
        break;

      case LazyRequestState.error:
        context.pop(); // Close loading dialog
        OverlayNotificationService.show(
          context: context,
          message: state.actionErrorMessage ?? AppStrings.defaultErrorMessage,
          type: SnackBarType.error,
        );
        context.read<ReviewsCubit>().resetActionStatus();
        break;

      case LazyRequestState.loaded:
        context.pop(); // Close loading dialog
        _onActionSuccess(state);
        break;

      case LazyRequestState.lazy:
        break;
    }
  }

  /*  void _onActionSuccess(ReviewsState state) {
    if (state.addReviewResult != null) {
      _handleReviewAdded(state.addReviewResult!);
    } else if (state.updatedDoctorRating != null) {
      if (appointment.isReviewed) {
        _handleReviewUpdatedOrDeleted(state.updatedDoctorRating!);
      }
    }
    context.read<ReviewsCubit>().resetActionStatus();
    context.pop(); // Close current screen
  }*/
  void _onActionSuccess(ReviewsState state) {
    switch (state.reviewOperation) {
      case ReviewOperation.add:
        _handleReviewAdded(state.addReviewResult!);
        break;

      case ReviewOperation.update:
        _handleReviewUpdated(state.updatedDoctorRating!);
        break;

      case ReviewOperation.delete:
        _handleReviewDeleted(state.updatedDoctorRating!);
        break;

      case ReviewOperation.none:
        break;
    }

    context.read<ReviewsCubit>().resetActionStatus();
    context.pop(); // Close current screen
  }

  void _handleReviewAdded(AddReviewResult result) {
    context.read<CompletedAppointmentsCubit>().updateAppointmentLocally(
      appointmentId: appointment.appointmentId,
      isReviewed: true,
      reviewId: result.reviewId,
    );
    final event = DoctorRatingUpdatedEvent(
      doctorId: result.reviewId,
      newRating: result.doctorRating.updatedRating,
      newRatingCount: result.doctorRating.updatedRatingCount,
    );
    context.read<DoctorListCubit>().updateDoctorRatingLocally(event: event);

    context.read<FavoritesCubit>().updateDoctorRatingLocally(event: event);

    OverlayNotificationService.show(
      context: context,
      message: AppStrings.reviewAddedSuccess,
      type: SnackBarType.success,
    );
  }

  void _handleReviewUpdated(UpdatedDoctorRating result) {
    final event = DoctorRatingUpdatedEvent(
      doctorId: result.doctorId,
      newRating: result.updatedRating,
      newRatingCount: result.updatedRatingCount,
    );
    context.read<DoctorListCubit>().updateDoctorRatingLocally(event: event);
    context.read<FavoritesCubit>().updateDoctorRatingLocally(event: event);
    OverlayNotificationService.show(
      context: context,
      message: AppStrings.reviewUpdatedSuccess,
      type: SnackBarType.success,
    );
  }

  void _handleReviewDeleted(UpdatedDoctorRating result) {
    context.read<CompletedAppointmentsCubit>().updateAppointmentLocally(
      appointmentId: appointment.appointmentId,
      isReviewed: false,
      reviewId: null,
    );
    final event = DoctorRatingUpdatedEvent(
      doctorId: result.doctorId,
      newRating: result.updatedRating,
      newRatingCount: result.updatedRatingCount,
    );
    context.read<DoctorListCubit>().updateDoctorRatingLocally(event: event);
    context.read<FavoritesCubit>().updateDoctorRatingLocally(event: event);
    OverlayNotificationService.show(
      context: context,
      message: AppStrings.reviewDeletedSuccess,
      type: SnackBarType.warning,
    );
  }

/*  void _handleReviewUpdatedOrDeleted(UpdatedDoctorRating rating) {
    final isDeleteOperation =
        context.read<ReviewsCubit>().state.selectedReview == null;

    context.read<CompletedAppointmentsCubit>().updateAppointmentLocally(
      appointmentId: appointment.appointmentId,
      isReviewed: !isDeleteOperation,
      reviewId: isDeleteOperation ? null : appointment.reviewId,
    );

    context.read<DoctorListCubit>().updateDoctorRatingLocally(
      event: DoctorRatingUpdatedEvent(
        doctorId: rating.doctorId,
        newRating: rating.updatedRating,
        newRatingCount: rating.updatedRatingCount,
      ),
    );

    OverlayNotificationService.show(
      context: context,
      message: isDeleteOperation
          ? AppStrings.reviewDeletedSuccess
          : AppStrings.reviewUpdatedSuccess,
      type: isDeleteOperation ? SnackBarType.warning : SnackBarType.success,
    );
  }*/
}

// =============================================================================
// PRIVATE COMPONENTS
// =============================================================================

class _SingleReviewFetcherBody extends StatelessWidget {
  const _SingleReviewFetcherBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsCubit, ReviewsState>(
      buildWhen: (prev, curr) =>
          prev.fetchSingleReviewStatus != curr.fetchSingleReviewStatus,
      builder: (context, state) {
        switch (state.fetchSingleReviewStatus) {
          case LazyRequestState.lazy:
          case LazyRequestState.loading:
            return const Center(
              child: CustomCircularProgress(color: AppColors.softBlue),
            );

          case LazyRequestState.loaded:
            final parentState = context
                .findAncestorStateOfType<_ReviewScreenState>();
            return parentState?._buildFormBody() ?? const SizedBox();

          case LazyRequestState.error:
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ErrorRetryWidget(
                isSliverWidget: false,
                errorMessage:
                    state.fetchSingleReviewErrorMessage ??
                    AppStrings.defaultErrorMessage,
                onRetry: () {
                  final appointment = parentStateWidget(context)?.appointment;

                  if (appointment?.reviewId != null) {
                    context.read<ReviewsCubit>().fetchSingleReview(
                      appointment!.reviewId!,
                    );
                  }
                },
              ),
            );
        }
      },
    );
  }

  _ReviewScreenState? parentStateWidget(BuildContext context) =>
      context.findAncestorStateOfType<_ReviewScreenState>();
}

class _DeleteReviewIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _DeleteReviewIconButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: IconButton(
        onPressed: onPressed,
        icon: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: AppColors.brightRed.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black12),
          ),
          child: Icon(
            Icons.delete_outline,
            color: AppColors.brightRed,
            size: 20.r,
          ),
        ),
      ),
    );
  }
}

class _ReviewFormBody extends StatelessWidget {
  final String doctorName;
  final String doctorImageUrl;
  final TextEditingController commentController;
  final double rating;
  final ValueChanged<double> onRatingUpdate;

  const _ReviewFormBody({
    required this.doctorName,
    required this.doctorImageUrl,
    required this.commentController,
    required this.rating,
    required this.onRatingUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          const SizedBox(height: 25),
          _DoctorAvatar(imageUrl: doctorImageUrl),
          const SizedBox(height: 15),
          Text(
            AppStrings.howWasYourExperienceWith(doctorName),
            style: GoogleFonts.roboto(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          RatingBarBadge(
            itemPadding: 15,
            initialRating: rating,
            itemSize: 30.r,
            onRatingUpdate: onRatingUpdate,
          ),
          const SizedBox(height: 15),
          Divider(color: Colors.grey.shade200, thickness: 1.5),
          const SizedBox(height: 15),
          LabeledTextField(
            textHeight: 1.5,
            label: AppStrings.writeYourReview,
            hintText: AppStrings.enterYourComment,
            controller: commentController,
            maxLines: 5,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _ReviewBottomBar extends StatelessWidget {
  final bool isReviewed;
  final VoidCallback onSubmitPressed;

  const _ReviewBottomBar({
    required this.onSubmitPressed,
    required this.isReviewed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
        child: Row(
          children: [
            const SecondaryButton(),
            const SizedBox(width: 16),
            PrimaryButton(
              text: isReviewed
                  ? AppStrings.saveChanges
                  : AppStrings.submitReview,
              onPressed: onSubmitPressed,
            ),
          ],
        ),
      ),
    );
  }
}

class _DoctorAvatar extends StatelessWidget {
  final String imageUrl;

  const _DoctorAvatar({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.softBlue),
      ),
      child: AppNetworkImage(
        heroTag: 'doctor_avatar_hero',
        imageUrl: imageUrl,
        imageRadius: 360,
        height: 120,
        width: 120,
        padding: EdgeInsets.zero,
        side: const BorderSide(color: Colors.white),
      ),
    );
  }
}
