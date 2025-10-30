final class StudentDAOError implements Exception {
  final String message;
  final Object? original;

  const StudentDAOError({required this.message, this.original});

  @override
  String toString() {
    return "StudentDAOError: $message";
  }
}
