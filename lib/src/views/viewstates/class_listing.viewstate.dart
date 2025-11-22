import "package:ctcl_manager/src/views/viewstates/base_viewstate.dart";

class ClassSummary {
  final String id;
  final String name;
  final String local;
  final int studentsQuantity;

  ClassSummary({
    required this.id,
    required this.name,
    required this.local,
    required this.studentsQuantity,
  });
}

final class ClassListingViewState extends BaseViewState {
  List<ClassSummary> classes;

  ClassListingViewState({required this.classes});

  void addClass(ClassSummary classSumary) {
    classes.add(classSumary);
    notifyListeners();
  }
}
