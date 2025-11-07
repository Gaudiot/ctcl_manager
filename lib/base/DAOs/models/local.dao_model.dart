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

  factory LocalDAOModel.fromJson(Map<String, dynamic> json) {
    return LocalDAOModel(
      id: json["id"] as String,
      name: json["name"] as String,
      createdAt: DateTime.parse(json["created_at"] as String),
      updatedAt: DateTime.parse(json["updated_at"] as String),
    );
  }
}

final class LocalSummaryDAOModel {
  final String id;
  final String name;

  LocalSummaryDAOModel({required this.id, required this.name});
}
