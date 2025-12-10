import 'package:equatable/equatable.dart' show Equatable;

class PaginationParameters extends Equatable {
  final dynamic lastDocument;

  final int limit;

  const PaginationParameters({this.lastDocument, this.limit = 10});

  @override
  List<Object?> get props => [lastDocument, limit];
}
