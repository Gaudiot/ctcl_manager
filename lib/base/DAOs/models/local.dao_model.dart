final class LocalDAOModel {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  LocalDAOModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
}

final class LocalSummaryDAOModel {
  final String id;
  final String name;

  LocalSummaryDAOModel({required this.id, required this.name});
}
