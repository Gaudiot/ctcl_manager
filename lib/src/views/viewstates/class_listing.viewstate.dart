import "package:ctcl_manager/src/views/viewstates/base_viewstate.dart";

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

final class ClassListingViewState extends BaseViewState {
  List<ClassSumary> classes;

  ClassListingViewState({required this.classes});

  void addClass(ClassSumary classSumary) {
    classes.add(classSumary);
    notifyListeners();
  }
}
