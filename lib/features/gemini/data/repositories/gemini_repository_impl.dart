import 'package:dartz/dartz.dart';

import '../../../../core/enum/languages.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/repositories/gemini_repository.dart';
import '../data_sources/gemini_remote_data_source.dart';

class GeminiRepositoryImpl implements GeminiRepository {
  final GeminiRemoteDataSource remoteDataSource;

  GeminiRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<Either<Failure, ChatMessageEntity>> sendTextMessageStream({
    required String prompt,
    required String modelName,
    required Languages language,
  }) async* {
    try {
      final stream = remoteDataSource.sendTextMessageStream(
        prompt: prompt,
        modelName: modelName,
        language: language,
      );

      await for (final model in stream) {
        yield Right(model.toEntity());
      }
    } catch (e) {
      yield Left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, ChatMessageEntity>> sendImageMessage({
    required String imagePath,
    required String prompt,
    required String modelName,
    required Languages language,
  }) async {
    try {
      final model = await remoteDataSource.sendImageMessage(
        imagePath: imagePath,
        prompt: prompt,
        modelName: modelName,
        language: language,
      );
      return Right(model.toEntity());
    } catch (e) {
      return Left(ServerFailure(catchError: e));
    }
  }
}
