final class LocalDAOError implements Exception {
  final String message;
  final Object? original;

  const LocalDAOError({required this.message, this.original});

  @override
  String toString() {
    return "LocalDAOError: $message";
  }
}
