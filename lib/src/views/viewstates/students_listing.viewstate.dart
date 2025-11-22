import "package:ctcl_manager/src/views/viewstates/base_viewstate.dart";

class StudentSummary {
  final String id;
  final String firstName;
  final String lastName;
  final int checkInQuantity;
  final DateTime? birthday;
  final String? className;

  StudentSummary({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.checkInQuantity,
    this.birthday,
    this.className,
  });

  int? get age {
    if (birthday == null) {
      return null;
    }

    final today = DateTime.now();
    final years = today.year - birthday!.year;

    if ((today.month < birthday!.month) ||
        (today.month == birthday!.month && today.day < birthday!.day)) {
      return years - 1;
    }

    return years;
  }
}

final class StudentsListingViewState extends BaseViewState {
  List<StudentSummary> students;

  StudentsListingViewState({required this.students});

  void addStudent(StudentSummary studentSummary) {
    students.add(studentSummary);
    notifyListeners();
  }
}
