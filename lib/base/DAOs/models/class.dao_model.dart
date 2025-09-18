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
  final int valueHundred;
  final String localId;
  final String localName;

  const ClassDAOModel({
    required this.id,
    required this.name,
    required this.description,
    required this.valueHundred,
    required this.localId,
    required this.localName,
  });
}
