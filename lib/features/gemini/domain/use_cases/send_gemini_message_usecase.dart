import 'package:dartz/dartz.dart';

import '../../../../core/enum/languages.dart';
import '../../../../core/error/failure.dart';
import '../entities/chat_message_entity.dart';
import '../repositories/gemini_repository.dart';

class SendGeminiMessageUseCase {
  final GeminiRepository repository;

  SendGeminiMessageUseCase(this.repository);

  Stream<Either<Failure, ChatMessageEntity>> executeTextStream({
    required String prompt,
    required String modelName,
    required Languages language,
  }) {
    return repository.sendTextMessageStream(
      prompt: prompt,
      modelName: modelName,
      language: language,
    );
  }

  Future<Either<Failure, ChatMessageEntity>> executeImage({
    required String imagePath,
    required String prompt,
    required String modelName,
    required Languages language,
  }) {
    return repository.sendImageMessage(
      imagePath: imagePath,
      prompt: prompt,
      modelName: modelName,
      language: language,
    );
  }
}
