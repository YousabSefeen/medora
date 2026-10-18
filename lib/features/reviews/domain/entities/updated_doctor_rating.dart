// features/reviews/domain/entities/updated_doctor_rating.dart

typedef UpdatedDoctorRating = ({
  String doctorId,
  double updatedRating,
  int updatedRatingCount,
});

// Record مخصص لنتائج عملية الإضافة
typedef AddReviewResult = ({String reviewId, UpdatedDoctorRating doctorRating});
