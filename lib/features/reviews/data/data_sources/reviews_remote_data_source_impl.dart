import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medora/core/services/logger_service.dart';
import 'package:medora/features/reviews/data/data_sources/reviews_remote_data_source.dart';
import 'package:medora/features/reviews/data/models/review_model.dart';
import 'package:medora/features/reviews/domain/params/update_review_params.dart';

import '../../../../core/constants/firestore_constants/firestore_constants.dart';
import '../../domain/entities/updated_doctor_rating.dart';
import '../../domain/params/add_review_params.dart';
import '../../domain/params/delete_review_params.dart';

class ReviewsRemoteDataSourceImpl extends ReviewsRemoteDataSource {
  final FirebaseFirestore _firestore;

  ReviewsRemoteDataSourceImpl({required this._firestore});

/*  @override
  Future<String> addReview({required AddReviewParams params}) async {
    final doctorId = params.doctorId;

    // References للمستندات
    final reviewRef = _firestore.collection('reviews').doc();
    final doctorRef = _firestore.collection('doctors').doc(doctorId);

    // 1. Reference لمستند الحجز الرئيس
    final appointmentRef = _firestore
        .collection(FirestoreConstants.appointmentsCollection)
        .doc(params.appointmentId);

    // 2. Reference لمستند الحجز الفرعي داخل الطبيب
    final doctorAppointmentRef = _firestore
        .collection(FirestoreConstants.doctorsCollection)
        .doc(doctorId)
        .collection(FirestoreConstants.appointmentsCollection)
        .doc(params.appointmentId);

    await _firestore.runTransaction((transaction) async {
      // 1. قراءة بيانات الطبيب الحالية
      final doctorSnapshot = await transaction.get(doctorRef);

      if (!doctorSnapshot.exists) {
        throw Exception('Doctor not found');
      }

      final doctorData = doctorSnapshot.data() as Map<String, dynamic>;

      final double currentRating =
          (doctorData['rating'] as num?)?.toDouble() ?? 0.0;
      final int currentRatingCount =
          (doctorData['ratingCount'] as num?)?.toInt() ?? 0;

      // 2. حساب القيم الجديدة للتقييم
      final int updatedCount = currentRatingCount + 1;
      final double updatedRating =
          ((currentRating * currentRatingCount) + params.rating) / updatedCount;

      final generatedReviewId = reviewRef.id;

      // 3. إنشاء كائن التقييم
      final reviewModel = ReviewModel(
        reviewId: generatedReviewId,
        doctorId: params.doctorId,
        clientId: params.clientId,
        clientName: params.clientName,
        clientImage: params.clientImage,
        rating: params.rating,
        comment: params.comment,
        createdAt: DateTime.now(),
      );

      // 4. تنفيذ العمليات الذرية (Atomic Operations)

      // أ. حفظ مستند التقييم في مجموعة reviews
      transaction.set(reviewRef, reviewModel.toJson());

      // ب. تحديث متوسط تقييم الطبيب وعدد التقييمات
      transaction.update(doctorRef, {
        'rating': double.parse(updatedRating.toStringAsFixed(1)),
        'ratingCount': updatedCount,
      });

      // ج. تحديث حالة التقييم في مستند الحجز الرئيسي
      transaction.update(appointmentRef, {
        'isReviewed': true,
        'reviewId': generatedReviewId,
      });

      // د. تحديث حالة التقييم في مستند الحجز الفرعي داخل الطبيب
      transaction.update(doctorAppointmentRef, {
        'isReviewed': true,
        'reviewId': generatedReviewId,
      });

    });
     AppLogger.warning(' reviewRef.id: ${ reviewRef.id}');
     return reviewRef.id;
  }*/

  @override
  Future<AddReviewResult> addReview({required AddReviewParams params}) async {
    final doctorId = params.doctorId;

    // References للمستندات
    final reviewRef = _firestore.collection('reviews').doc();
    final doctorRef = _firestore.collection('doctors').doc(doctorId);

    // 1. Reference لمستند الحجز الرئيسي
    final appointmentRef = _firestore
        .collection(FirestoreConstants.appointmentsCollection)
        .doc(params.appointmentId);

    // 2. Reference لمستند الحجز الفرعي داخل الطبيب
    final doctorAppointmentRef = _firestore
        .collection(FirestoreConstants.doctorsCollection)
        .doc(doctorId)
        .collection(FirestoreConstants.appointmentsCollection)
        .doc(params.appointmentId);

    late double finalRating;
    late int finalCount;

    await _firestore.runTransaction((transaction) async {
      // 1. قراءة بيانات الطبيب الحالية
      final doctorSnapshot = await transaction.get(doctorRef);

      if (!doctorSnapshot.exists) {
        throw Exception('Doctor not found');
      }

      final doctorData = doctorSnapshot.data() as Map<String, dynamic>;

      final double currentRating =
          (doctorData['rating'] as num?)?.toDouble() ?? 0.0;
      final int currentRatingCount =
          (doctorData['ratingCount'] as num?)?.toInt() ?? 0;

      // 2. حساب القيم الجديدة للتقييم
      finalCount = currentRatingCount + 1;
      final double updatedRating =
          ((currentRating * currentRatingCount) + params.rating) / finalCount;

      finalRating = double.parse(updatedRating.toStringAsFixed(1));
      final generatedReviewId = reviewRef.id;

      // 3. إنشاء كائن التقييم
      final reviewModel = ReviewModel(
        reviewId: generatedReviewId,
        doctorId: params.doctorId,
        clientId: params.clientId,
        clientName: params.clientName,
        clientImage: params.clientImage,
        rating: params.rating,
        comment: params.comment,
        createdAt: DateTime.now(),
      );

      // 4. تنفيذ العمليات الذرية (Atomic Operations)

      // أ. حفظ مستند التقييم في مجموعة reviews
      transaction.set(reviewRef, reviewModel.toJson());

      // ب. تحديث متوسط تقييم الطبيب وعدد التقييمات
      transaction.update(doctorRef, {
        'rating': finalRating,
        'ratingCount': finalCount,
      });

      // ج. تحديث حالة التقييم في مستند الحجز الرئيسي
      transaction.update(appointmentRef, {
        'isReviewed': true,
        'reviewId': generatedReviewId,
      });

      // د. تحديث حالة التقييم في مستند الحجز الفرعي داخل الطبيب
      transaction.update(doctorAppointmentRef, {
        'isReviewed': true,
        'reviewId': generatedReviewId,
      });
    });

    AppLogger.warning('reviewRef.id: ${reviewRef.id}');

    // إرجاع الـ reviewId المولد والبيانات المحدثة للطبيب
    return (
    reviewId: reviewRef.id,
    doctorRating: (
    doctorId: doctorId,
    updatedRating: finalRating,
    updatedRatingCount: finalCount,
    ),
    );
  }
  @override
  Future<UpdatedDoctorRating> updateReview({required UpdateReviewParams params}) async {
    try {
      final doctorRef = _firestore.collection('doctors').doc(params.doctorId);
      final reviewRef = _firestore.collection('reviews').doc(params.reviewId);

      late double finalRating;
      late int finalRatingCount;

      await _firestore.runTransaction((transaction) async {
        final doctorSnapshot = await transaction.get(doctorRef);
        if (!doctorSnapshot.exists) throw Exception('Doctor not found');

        final doctorData = doctorSnapshot.data() as Map<String, dynamic>;
        final double currentRating = (doctorData['rating'] as num?)?.toDouble() ?? 0.0;
        final int ratingCount = (doctorData['ratingCount'] as num?)?.toInt() ?? 0;

        // حساب التقييم الجديد بنفس منطقك
        final double currentTotalSum = currentRating * ratingCount;
        final double newTotalSum = currentTotalSum - params.oldRating + params.newRating;

        finalRating = ratingCount > 0 ? (newTotalSum / ratingCount) : 0.0;
        finalRating = double.parse(finalRating.toStringAsFixed(1));
        finalRatingCount = ratingCount; // العدد لا يتغير في التعديل

        transaction.update(reviewRef, {
          'rating': params.newRating,
          'comment': params.newComment,
          'updatedAt': FieldValue.serverTimestamp(),
        });

        transaction.update(doctorRef, {
          'rating': finalRating,
        });
      });

      // إرجاع النتيجة المحدثة
      return (

      doctorId: params.doctorId,
      updatedRating: finalRating,
      updatedRatingCount: finalRatingCount,
      );
    } catch (e) {
      AppLogger.error('updateReview', error: e);
      rethrow;
    }
  }
  @override
  Future<UpdatedDoctorRating> deleteReview({
    required DeleteReviewParams params,
  }) async {
    try {
      final doctorRef = _firestore
          .collection(FirestoreConstants.doctorsCollection)
          .doc(params.doctorId);

      final reviewRef = _firestore
          .collection('reviews')
          .doc(params.reviewId);

      final appointmentRef = _firestore
          .collection(FirestoreConstants.appointmentsCollection)
          .doc(params.appointmentId);

      final doctorAppointmentRef = _firestore
          .collection(FirestoreConstants.doctorsCollection)
          .doc(params.doctorId)
          .collection(FirestoreConstants.appointmentsCollection)
          .doc(params.appointmentId);

      late double finalRating;
      late int finalCount;

      await _firestore.runTransaction((transaction) async {
        // 1. جلب بيانات الطبيب الحالية للحسابات
        final doctorSnapshot = await transaction.get(doctorRef);
        if (!doctorSnapshot.exists) {
          throw Exception('Doctor not found');
        }

        final doctorData = doctorSnapshot.data() as Map<String, dynamic>;
        final double currentRating =
            (doctorData['rating'] as num?)?.toDouble() ?? 0.0;
        final int currentRatingCount =
            (doctorData['ratingCount'] as num?)?.toInt() ?? 0;

        // 2. حساب القيم الجديدة بعد حذف التقييم
        finalCount = currentRatingCount > 1 ? currentRatingCount - 1 : 0;

        double updatedRating = 0.0;
        if (finalCount > 0) {
          final double currentTotalSum = currentRating * currentRatingCount;
          final double newTotalSum = currentTotalSum - params.ratingToDelete;

          // تجنب النواتج السالبة في حالة وجود فروق كسور بسيطة
          updatedRating = newTotalSum > 0 ? (newTotalSum / finalCount) : 0.0;
        }

        finalRating = double.parse(updatedRating.toStringAsFixed(1));

        // 3. تنفيذ عمليات الحذف والتحديث الذرية (Atomic Operations)

        // أ. حذف مستند المراجعة
        transaction.delete(reviewRef);

        // ب. تحديث تقييم وعدد تقييمات الطبيب
        transaction.update(doctorRef, {
          'rating': finalRating,
          'ratingCount': finalCount,
        });

        // ج. إعادة ضبط حالة التقييم في مستند الحجز الرئيسي والفرعي
        final resetAppointmentUpdates = {
          'isReviewed': false,
          'reviewId': null,
        };

        transaction.update(appointmentRef, resetAppointmentUpdates);
        transaction.update(doctorAppointmentRef, resetAppointmentUpdates);
      });

      // إرجاع النتيجة النهائية المحدثة الموثوقة من قاعدة البيانات
      return (

      doctorId: params.doctorId,
      updatedRating: finalRating,
      updatedRatingCount: finalCount,
      );
    } catch (e) {
      AppLogger.error('deleteReview', error: e);
      rethrow;
    }
  }
/*
  @override
  Future<void> updateReview({required UpdateReviewParams params}) async {
    try {
      final doctorRef = _firestore.collection('doctors').doc(params.doctorId);
      final reviewRef = _firestore.collection('reviews').doc(params.reviewId);

      await _firestore.runTransaction((transaction) async {
        final doctorSnapshot = await transaction.get(doctorRef);
        if (!doctorSnapshot.exists) throw Exception('Doctor not found');

        final doctorData = doctorSnapshot.data() as Map<String, dynamic>;
        final double currentRating =
            (doctorData['rating'] as num?)?.toDouble() ?? 0.0;
        final int ratingCount =
            (doctorData['ratingCount'] as num?)?.toInt() ?? 0;

        // حساب الفرق في حالة التعديل (دون زيادة العدد)
        final double currentTotalSum = currentRating * ratingCount;
        final double newTotalSum =
            currentTotalSum - params.oldRating + params.newRating;
        final double updatedRating = ratingCount > 0
            ? (newTotalSum / ratingCount)
            : 0.0;

        transaction.update(reviewRef, {
          'rating': params.newRating,
          'comment': params.newComment,
          'updatedAt': FieldValue.serverTimestamp(),
        });

        transaction.update(doctorRef, {
          'rating': double.parse(updatedRating.toStringAsFixed(1)),
        });
      });
    } catch (e) {
      AppLogger.error('updateReview', error: e);
      rethrow;
    }
  }*/
/*  @override
  Future<void> deleteReview({required DeleteReviewParams params}) async {
    try {
      final doctorRef = _firestore
          .collection(FirestoreConstants.doctorsCollection)
          .doc(params.doctorId);

      final reviewRef = _firestore
          .collection('reviews')
          .doc(params.reviewId);

      final appointmentRef = _firestore
          .collection(FirestoreConstants.appointmentsCollection)
          .doc(params.appointmentId);

      final doctorAppointmentRef = _firestore
          .collection(FirestoreConstants.doctorsCollection)
          .doc(params.doctorId)
          .collection(FirestoreConstants.appointmentsCollection)
          .doc(params.appointmentId);

      await _firestore.runTransaction((transaction) async {
        // 1. جلب بيانات الطبيب الحالية للحسابات
        final doctorSnapshot = await transaction.get(doctorRef);
        if (!doctorSnapshot.exists) {
          throw Exception('Doctor not found');
        }

        final doctorData = doctorSnapshot.data() as Map<String, dynamic>;
        final double currentRating = (doctorData['rating'] as num?)?.toDouble() ?? 0.0;
        final int currentRatingCount = (doctorData['ratingCount'] as num?)?.toInt() ?? 0;

        // 2. حساب القيم الجديدة بعد حذف التقييم
        final int updatedCount = currentRatingCount > 1 ? currentRatingCount - 1 : 0;

        double updatedRating = 0.0;
        if (updatedCount > 0) {
          final double currentTotalSum = currentRating * currentRatingCount;
          final double newTotalSum = currentTotalSum - params.ratingToDelete;
          // تجنب النواتج السالبة في حالة وجود فروق كسور بسيطة
          updatedRating = newTotalSum > 0 ? (newTotalSum / updatedCount) : 0.0;
        }

        // 3. تنفيذ عمليات الحذف والتحديث الذرية (Atomic Operations)

        // أ. حذف مستند المراجعة
        transaction.delete(reviewRef);

        // ب. تحديث تقييم وعدد تقييمات الطبيب
        transaction.update(doctorRef, {
          'rating': double.parse(updatedRating.toStringAsFixed(1)),
          'ratingCount': updatedCount,
        });

        // ج. إعادة ضبط حالة التقييم في مستند الحجز الرئيسي
        final resetAppointmentUpdates = {
          'isReviewed': false,
          'reviewId': null,
        };

        transaction.update(appointmentRef, resetAppointmentUpdates);

        // د. إعادة ضبط حالة التقييم في مستند الحجز الفرعي الخاص بالطبيب
        transaction.update(doctorAppointmentRef, resetAppointmentUpdates);
      });
    } catch (e) {
      AppLogger.error('deleteReview', error: e);
      rethrow;
    }
  }*/
  @override
  Future<List<ReviewModel>> fetchReviews({required String doctorId}) async {
    final querySnapshot = await _firestore
        .collection('reviews')
        .where('doctorId', isEqualTo: doctorId)
        .orderBy('createdAt', descending: true)
        .get();
    return querySnapshot.docs
        .map((doc) => ReviewModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<ReviewModel> fetchSingleReview({required String reviewId}) async {
    try {
      final doc = await _firestore.collection('reviews').doc(reviewId).get();
      if (!doc.exists) {
        throw Exception('Review not found');
      }
      return ReviewModel.fromJson(doc.data()!);
    } catch (e) {
      AppLogger.error('fetchReviewById', error: e);
      rethrow;
    }
  }
}
