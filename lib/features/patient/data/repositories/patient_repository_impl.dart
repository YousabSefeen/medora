import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/patient/data/models/patient_model.dart' show PatientModel;
import 'package:medora/features/patient/data/data_sources/patient_local_data_source.dart'
    show PatientLocalDataSource;
import 'package:medora/features/patient/domain/entities/patient_entity.dart';
import 'package:medora/features/patient/domain/repository/patient_repository.dart'
    show PatientRepository;

class PatientRepositoryImpl extends PatientRepository {
  final PatientLocalDataSource patientLocalDataSource;

  PatientRepositoryImpl({required this.patientLocalDataSource});

  @override
  Future<Either<Failure, PatientEntity?>> getCachedPatientData() async {
    try {
      final patient = patientLocalDataSource.getCachedPatientData();
      return Right(patient);
    } catch (e) {
      return Left(LocalFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, void>> savePatientData(PatientEntity patient) async {
    try {
      final patientModel = PatientModel.fromEntity(patient);
      await patientLocalDataSource.cachePatientData(patientModel);
      return const Right(null);
    } catch (e) {
      return Left(LocalFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, void>> clearCachedPatientData() async {
    try {
      await patientLocalDataSource.clearCachedPatientData();
      return const Right(null);
    } catch (e) {
      return Left(LocalFailure(catchError: e));
    }
  }
}
