import '../../../../core/enum/languages.dart';
import '../../domain/entities/chat_message_entity.dart';

class ChatMessageModel extends ChatMessageEntity {
  const ChatMessageModel({
    required super.text,
    required super.isDone,
    required super.language,
  });

  factory ChatMessageModel.fromRawResponse({
    required String text,
    required bool isDone,
    required Languages language,
  }) => ChatMessageModel(text: text, isDone: isDone, language: language);

  ChatMessageEntity toEntity() =>
      ChatMessageEntity(text: text, isDone: isDone, language: language);
}
