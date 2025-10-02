

extension ListStringExtension on List<String> {
  String buildJoin() {
    if (isEmpty) return '';
    final result = map((e) => '$e, ').join();
    return result.substring(0, result.length - 2);
  }
}