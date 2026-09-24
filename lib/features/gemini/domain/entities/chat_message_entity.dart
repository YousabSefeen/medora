import 'package:equatable/equatable.dart';

import '../../../../core/enum/languages.dart';

class ChatMessageEntity extends Equatable {
  final String text;
  final bool isDone;
  final Languages language;

  const ChatMessageEntity({
    required this.text,
    required this.isDone,
    required this.language,
  });

  @override
  List<Object?> get props => [text, isDone, language];
}
