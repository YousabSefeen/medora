import 'package:dartz/dartz.dart';

import '../../../../core/enum/languages.dart';
import '../../../../core/error/failure.dart';
import '../entities/chat_message_entity.dart';

abstract class GeminiRepository {
  Stream<Either<Failure, ChatMessageEntity>> sendTextMessageStream({
    required String prompt,
    required String modelName,
    required Languages language,
  });

  Future<Either<Failure, ChatMessageEntity>> sendImageMessage({
    required String imagePath,
    required String prompt,
    required String modelName,
    required Languages language,
  });
}
