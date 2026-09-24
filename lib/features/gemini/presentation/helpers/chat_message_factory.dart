import 'package:flutter_chat_core/flutter_chat_core.dart' as types;

import '../../../../core/utils/language_detector.dart';

/// Utility class responsible for creating and formatting chat messages.
abstract class ChatMessageFactory {
  static types.TextMessage createTextMessage({
    required String text,
    required String authorId,
    String? customId,
    String? language,
  }) {
    final detectedLang = language ?? LanguageDetector.detectLanguage(text).name;
    return types.TextMessage(
      id: customId ?? 'msg_${DateTime.now().millisecondsSinceEpoch}',
      authorId: authorId,
      text: text,
      createdAt: DateTime.now(),
      metadata: {'language': detectedLang},
    );
  }

  static types.ImageMessage createImageMessage({
    required String imagePath,
    required String authorId,
  }) {
    return types.ImageMessage(
      id: 'img_${DateTime.now().millisecondsSinceEpoch}',
      authorId: authorId,
      createdAt: DateTime.now(),
      source: imagePath,
    );
  }
}
