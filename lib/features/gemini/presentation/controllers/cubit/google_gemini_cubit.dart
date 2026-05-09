import 'dart:io' show File;
import 'dart:typed_data' show Uint8List;

import 'package:flutter_bloc/flutter_bloc.dart';
// الحزمة الجديدة
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image/image.dart' as img;
import 'package:medora/core/constants/gemini_config/gemini_config.dart'
    show GeminiConfig;
// استيرادات ملفاتك الخاصة (تأكد من صحة المسارات)
import 'package:medora/core/enum/languages.dart';
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/core/error/gemini_error_handler.dart'
    show GeminiErrorHandler;
import 'package:medora/core/extensions/message_types.dart' show MessageTypes;
import 'package:medora/core/utils/gemini_model_factory.dart'
    show GeminiModelFactory;
import 'package:medora/core/utils/language_detector.dart' show LanguageDetector;
import 'package:medora/features/gemini/presentation/controllers/states/gemini_chat_state.dart'
    show GeminiChatState;

class GoogleGeminiCubit extends Cubit<GeminiChatState> {
  GoogleGeminiCubit() : super(const GeminiChatState());

  // الدالة الموحدة الجديدة
  void onActionSend({
    required String text,
    required void Function(String text, bool isDone, Languages lang) onUpdate,
  }) async {
    // التحقق: إذا كان هناك صورة في الـ State، نستخدم نوع textWithImage
    final MessageTypes type = state.sourceImage.isNotEmpty
        ? MessageTypes.textWithImage
        : MessageTypes.text;

    if (type == MessageTypes.text) {
      // تنفيذ دالة النص العادي
      sendMessage(text, onUpdate);
    } else {
      // تنفيذ دالة الصورة
      final File imageFile = File(state.sourceImage);
      final Uint8List bytes = await imageFile.readAsBytes();

      // نقوم بتصفير الصورة في الـ State فور البدء بالإرسال
      setSourceImage('');

      await sendImage(
        bytes: bytes,
        prompt: text,
        onResponse: (res, lang) {
          // دالة الصورة حالياً لا تدعم الاستريمينج، لذا نرسلها كأنها Update نهائي
          onUpdate(res, true, lang);
        },
      );
    }
  }

  // دالة لمسح الصورة المختارة
  void clearSourceImage() => emit(state.copyWith(sourceImage: ''));

  // دالة إرسال النص (Streaming)
  void sendMessage(
    String prompt,
    void Function(String text, bool isDone, Languages lang) onUpdate,
  ) {
    print('******************  sendMessage Called  ************************');
    final Languages promptLanguage = LanguageDetector.detectLanguage(prompt);
    _setLoadingState(prompt, promptLanguage);

    final instruction = _getInstruction(promptLanguage);
    final model = GeminiModelFactory.create(
      modelName: state.modelName,

      instruction: instruction,
    );

    String fullResponse = '';

    // التعديل هنا: نستخدم GenerateContentResponse من الحزمة الجديدة
    model
        .generateContentStream([Content.text(prompt)])
        .listen(
          (chunk) {
            fullResponse += chunk.text ?? '';
            final responseLanguage = LanguageDetector.detectLanguage(
              fullResponse,
            );
            onUpdate(fullResponse, false, responseLanguage);
          },
          onDone: () {
            print('onDone.sendMessage: $fullResponse');
            final finalLang = LanguageDetector.detectLanguage(fullResponse);
            onUpdate(fullResponse, true, finalLang);
            emit(state.copyWith(requestState: LazyRequestState.lazy));
          },
          onError: (error) => _handleError(error, promptLanguage),
        );
  }

  void setSourceImage(String sourceImage) =>
      emit(state.copyWith(sourceImage: sourceImage));

  // دالة إرسال الصور (Single Prompt)
  Future<void> sendImage({
    required Uint8List bytes,
    required String prompt,
    required void Function(String, Languages lang) onResponse,
  }) async {
    print('******************  sendImage Called  ************************');
    print('******************  prompt    ***********$prompt ************');

    emit(state.copyWith(requestState: LazyRequestState.loading));
    final lang = LanguageDetector.detectLanguage(prompt);

    try {
      final compressedBytes = await _imageProcessor(bytes);
      final model = GeminiModelFactory.create(
        modelName: state.modelName,
        instruction: _getInstruction(lang),
      );

      // التعديل هنا: DataPart بدلاً من InlineDataPart (حسب إصدار الحزمة)
      final imagePart = DataPart('image/jpeg', compressedBytes);

      final response = await model.generateContent([
        Content.multi([TextPart(prompt), imagePart]),
      ]);

      final output = response.text ?? "لم يتمكن من التحليل";
      final responseLanguage = LanguageDetector.detectLanguage(output);

      onResponse(output, responseLanguage);
      print('onDone.sendMessage: $output');
      emit(state.copyWith(requestState: LazyRequestState.lazy));
    } catch (e) {
      _handleError(e, lang);
    }
  }

  void _setLoadingState(String prompt, Languages lang) => emit(
    state.copyWith(
      prompt: prompt,
      language: lang,
      requestState: LazyRequestState.loading,
    ),
  );

  Content _getInstruction(Languages lang) {
    final instructionText = lang == Languages.arabic
        ? GeminiConfig.systemContextArabic
        : GeminiConfig.systemContextEnglish;

    return Content.system(instructionText);
  }

  void _handleError(Object error, Languages lang) {
    print('Error: ${error.toString()}');

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

  Future<Uint8List> _imageProcessor(Uint8List bytes) async {
    final image = img.decodeImage(bytes);
    if (image == null) return bytes;
    final resized = img.copyResize(image, width: 512, height: 512);
    return Uint8List.fromList(img.encodeJpg(resized, quality: 70));
  }
}
