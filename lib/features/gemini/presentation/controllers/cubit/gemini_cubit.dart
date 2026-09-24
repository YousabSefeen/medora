import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/enum/languages.dart';
import 'package:medora/core/enum/lazy_request_state.dart';
import 'package:medora/core/utils/language_detector.dart';
import 'package:medora/features/gemini/presentation/controllers/states/gemini_state.dart';

import '../../../domain/use_cases/send_gemini_message_usecase.dart';

class GeminiCubit extends Cubit<GeminiState> {
  final SendGeminiMessageUseCase sendGeminiMessageUseCase;

  GeminiCubit({required this.sendGeminiMessageUseCase})
    : super(const GeminiState());

  void onActionSend({
    required String text,
    required void Function(String fullText, bool isDone, Languages lang)
    onUpdate,
  }) {
    if (state.sourceImage.isEmpty) {
      _executeTextMessage(text, onUpdate);
    } else {
      _executeImageMessage(text, onUpdate);
    }
  }

  void _executeTextMessage(
    String text,
    void Function(String fullText, bool isDone, Languages lang) onUpdate,
  ) {
    emit(state.copyWith(requestState: LazyRequestState.loading));
    final lang = LanguageDetector.detectLanguage(text);

    sendGeminiMessageUseCase
        .executeTextStream(
          prompt: text,
          modelName: state.modelName,
          language: lang,
        )
        .listen(
          (either) => either.fold(
            (failure) => emit(
              state.copyWith(
                requestState: LazyRequestState.error,
                requestStateError: failure.errorMessage,
              ),
            ),
            (entity) {
              onUpdate(entity.text, entity.isDone, lang);
              emit(state.copyWith(requestState: LazyRequestState.lazy));
            },
          ),
        );
  }

  void _executeImageMessage(
    String text,
    void Function(String fullText, bool isDone, Languages lang) onUpdate,
  ) async {
    emit(state.copyWith(requestState: LazyRequestState.loading));
    final imagePath = state.sourceImage;
    clearSourceImage();

    final lang = LanguageDetector.detectLanguage(text);

    final result = await sendGeminiMessageUseCase.executeImage(
      imagePath: imagePath,
      prompt: text,
      modelName: state.modelName,
      language: lang,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          requestState: LazyRequestState.error,
          requestStateError: failure.errorMessage,
        ),
      ),
      (entity) {
        onUpdate(entity.text, entity.isDone, lang);
        emit(state.copyWith(requestState: LazyRequestState.lazy));
      },
    );
  }

  void setSourceImage(String sourceImage) =>
      emit(state.copyWith(sourceImage: sourceImage));

  void clearSourceImage() => emit(state.copyWith(sourceImage: ''));
}
