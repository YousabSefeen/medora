import '../../../shared/domain/entities/pagination_parameters.dart';

class GetDoctorsBySpecialtyParameters extends PaginationParameters {
  final String specialtyName;

  const GetDoctorsBySpecialtyParameters({
    required this.specialtyName,
    super.lastDocument,
    super.limit,
  });

  /// دالة مساعدة لتحويل الـ PaginationParameters الأساسية مع اسم التخصص
  factory GetDoctorsBySpecialtyParameters.fromPaginationParams({
    required PaginationParameters paginationParams,
    required String specialtyName,
  }) {
    return GetDoctorsBySpecialtyParameters(
      specialtyName: specialtyName,
      lastDocument: paginationParams.lastDocument,
      limit: paginationParams.limit,
    );
  }
}