final class ClassSummaryDAOModel {
  final String id;
  final String name;
  final String localName;
  final int studentsQuantity;

  const ClassSummaryDAOModel({
    required this.id,
    required this.name,
    required this.localName,
    required this.studentsQuantity,
  });
}

final class ClassDAOModel {
  final String id;
  final String name;
  final String description;
  final int? valueHundred;
  final String? localId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ClassDAOModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.valueHundred,
    this.localId,
  });

  factory ClassDAOModel.fromJson(Map<String, dynamic> json) {
    return ClassDAOModel(
      id: json["id"] as String,
      name: json["name"] as String,
      description: json["description"] as String,
      valueHundred: json["value_hundred"] as int?,
      localId: json["local_id"] as String?,
      createdAt: DateTime.parse(json["created_at"] as String),
      updatedAt: DateTime.parse(json["updated_at"] as String),
    );
  }
}
