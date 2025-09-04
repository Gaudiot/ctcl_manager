class ClassSumary {
  final String id;
  final String name;
  final String local;
  final int studentsQuantity;

  ClassSumary({
    required this.id,
    required this.name,
    required this.local,
    required this.studentsQuantity,
  });
}

class ClassViewModel {
  List<ClassSumary> classes;

  ClassViewModel({required this.classes});
}
