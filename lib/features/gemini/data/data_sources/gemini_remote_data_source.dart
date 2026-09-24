import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image/image.dart' as img;
import 'package:medora/core/utils/gemini_model_factory.dart';

import '../../../../core/enum/languages.dart';
import '../models/chat_message_model.dart';
import 'gemini_prompts.dart';

abstract class GeminiRemoteDataSource {
  Stream<ChatMessageModel> sendTextMessageStream({
    required String prompt,
    required String modelName,
    required Languages language,
  });

  Future<ChatMessageModel> sendImageMessage({
    required String imagePath,
    required String prompt,
    required String modelName,
    required Languages language,
  });
}

class GeminiRemoteDataSourceImpl implements GeminiRemoteDataSource {
  @override
  Stream<ChatMessageModel> sendTextMessageStream({
    required String prompt,
    required String modelName,
    required Languages language,
  }) async* {
    final model = GeminiModelFactory.create(
      modelName: modelName,
      instruction: _getInstruction(language),
    );

    final stream = model.generateContentStream([Content.text(prompt)]);
    String accumulatedText = '';

    await for (final chunk in stream) {
      if (chunk.text != null && chunk.text!.isNotEmpty) {
        accumulatedText += chunk.text!;
        yield ChatMessageModel.fromRawResponse(
          text: accumulatedText,
          isDone: false,
          language: language,
        );
      }
    }

    // Yield final state as completed
    yield ChatMessageModel.fromRawResponse(
      text: accumulatedText,
      isDone: true,
      language: language,
    );
  }

  @override
  Future<ChatMessageModel> sendImageMessage({
    required String imagePath,
    required String prompt,
    required String modelName,
    required Languages language,
  }) async {
    final bytes = await File(imagePath).readAsBytes();
    final compressedBytes = await compute(_compressImage, bytes);

    final model = GeminiModelFactory.create(
      modelName: modelName,
      instruction: _getInstruction(language),
    );

    final imagePart = DataPart('image/jpeg', compressedBytes);
    final response = await model.generateContent([
      Content.multi([TextPart(prompt), imagePart]),
    ]);

    final responseText = response.text ?? 'No response received.';

    return ChatMessageModel.fromRawResponse(
      text: responseText,
      isDone: true,
      language: language,
    );
  }

  Content _getInstruction(Languages language) {
    final instructionText = language == Languages.arabic
        ? GeminiPrompts.systemContextArabic
        : GeminiPrompts.systemContextEnglish;
    return Content.system(instructionText);
  }

  static Uint8List _compressImage(Uint8List bytes) {
    final image = img.decodeImage(bytes);
    if (image == null) return bytes;
    final resized = img.copyResize(image, width: 512, height: 512);
    return Uint8List.fromList(img.encodeJpg(resized, quality: 70));
  }
}
