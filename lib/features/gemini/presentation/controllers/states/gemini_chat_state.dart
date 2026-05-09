import 'package:equatable/equatable.dart' show Equatable;
import 'package:medora/core/enum/languages.dart' show Languages;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;

class GeminiChatState extends Equatable {
  final String sourceImage;
  final String modelName;
  final String prompt;

  final LazyRequestState requestState;
  final String requestStateError;
  final Languages language;

  const GeminiChatState({
    this.modelName = 'gemini-3-flash-preview',
    this.sourceImage = '',
    this.prompt = '',

    this.requestState = LazyRequestState.lazy,
    this.requestStateError = '',
    this.language = Languages.english,
  });

  GeminiChatState copyWith({
    String? modelName,
    String? sourceImage,
    String? prompt,

    LazyRequestState? requestState,
    String? requestStateError,
    Languages? language,
  }) {
    return GeminiChatState(
      modelName: modelName ?? this.modelName,
      sourceImage: sourceImage ?? this.sourceImage,
      prompt: prompt ?? this.prompt,

      requestState: requestState ?? this.requestState,
      requestStateError: requestStateError ?? this.requestStateError,
      language: language ?? this.language,
    );
  }

  @override
  List<Object?> get props => [
    modelName,
    sourceImage,
    prompt,
    requestState,
    requestStateError,
    language,
  ];
}
