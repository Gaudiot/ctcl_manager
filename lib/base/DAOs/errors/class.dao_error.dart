final class ClassDAOError implements Exception {
  final String message;
  final Object? original;

  const ClassDAOError({required this.message, this.original});

  @override
  String toString() {
    return "ClassDAOError: $message";
  }
}
