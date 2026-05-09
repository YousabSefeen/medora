/*
import 'dart:typed_data' show Uint8List;

import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:medora/core/constants/gemini_config/gemini_config.dart'
    show GeminiConfig;
import 'package:medora/core/enum/languages.dart';
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/core/error/gemini_error_handler.dart'
    show GeminiErrorHandler;
import 'package:medora/core/utils/language_detector.dart' show LanguageDetector;
import 'package:medora/features/gemini/presentation/controllers/states/gemini_chat_state.dart'
    show GeminiChatState;



class GeminiChatCubit extends Cubit<GeminiChatState> {
  GeminiChatCubit() : super(const GeminiChatState());

  // دالة إرسال النص (Streaming)
  void sendMessage(
      String prompt,
      void Function(String text, bool isDone, Languages lang) onUpdate,
      ) {
    final Languages promptLanguage = LanguageDetector.detect(prompt);
    _setLoadingState(prompt, promptLanguage);

    final instruction = _getInstruction(promptLanguage);
    final model = GeminiModelFactory.create(instruction: instruction);

    String fullResponse = '';

    model
        .generateContentStream([Content.text(prompt)])
        .listen(
          (chunk) {
        fullResponse += chunk.text ?? '';
        final responseLanguage = LanguageDetector.detect(fullResponse);
        onUpdate(fullResponse, false, responseLanguage);
      },
      onDone: () {
        final finalLang = LanguageDetector.detect(fullResponse);
        onUpdate(fullResponse, true, finalLang);
        emit(state.copyWith(requestState: LazyRequestState.lazy));
      },
      onError: (error) => _handleError(error, promptLanguage),
    );
  }

  // دالة إرسال الصور (Single Prompt)
  Future<void> sendImage({
    required Uint8List bytes,
    required String prompt,
    required void Function(String) onResponse,
  }) async {
    emit(state.copyWith(requestState: LazyRequestState.loading));
    print('******************prompt:  $prompt ');
    final lang = LanguageDetector.detect(prompt);

    try {
      final compressedBytes = await _imageProcessor(bytes);
      final model = GeminiModelFactory.create(
        instruction: _getInstruction(lang),
      );

      final imagePart = InlineDataPart('image/jpeg', compressedBytes);
      final response = await model.generateContent([
        Content.multi([TextPart(prompt), imagePart]),
      ]);

      final output = response.text ?? "لم يتمكن من التحليل";
      print('LanguageDetector: ${lang}'); // هل يحتوي على 555؟
      print('DEBUG GEMINI RESPONSE: $output'); // هل يحتوي على 555؟
      onResponse(output);
      emit(state.copyWith(requestState: LazyRequestState.lazy));
    } catch (e) {
      _handleError(e, lang);
    }
  }

  // --- دوال مساعدة لتحسين القراءة (Private Helpers) ---

  void _setLoadingState(String prompt, Languages lang) {
    emit(
      state.copyWith(
        prompt: prompt,
        language: lang,
        requestState: LazyRequestState.loading,
      ),
    );
  }

  Content _getInstruction(Languages lang) {
    return lang == Languages.arabic
        ? GeminiConfig.systemContextArabic
        : GeminiConfig.systemContextEnglish;
  }

  void _handleError(Object error, Languages lang) {
    final errorMessage = GeminiErrorHandler.getErrorMessage(
      error: error,
      language: lang,
    );
    emit(
      state.copyWith(
        requestState: LazyRequestState.error,
        requestStateError: errorMessage,
      ),
    );
  }

  // دالة معالجة الصور منفصلة لزيادة الـ Reusability
  Future<Uint8List> _imageProcessor(Uint8List bytes) async {
    final image = img.decodeImage(bytes);
    if (image == null) return bytes;
    final resized = img.copyResize(image, width: 512, height: 512);
    return Uint8List.fromList(img.encodeJpg(resized, quality: 70));
  }
}

class GeminiModelFactory {
  static GenerativeModel create({
    required Content instruction,
    String modelName =  'gemini-1.5-flash',
  }) {
    final googleAI = FirebaseAI.googleAI(auth: FirebaseAuth.instance,);

    return googleAI.generativeModel(
      model: modelName,


      generationConfig: GenerationConfig(

        temperature: 0.1,
        maxOutputTokens: 1082,
        topP: 0.8,
        topK: 40,
      ),
      systemInstruction: instruction,
    );
  }
}
*/
