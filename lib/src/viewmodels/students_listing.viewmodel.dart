import "package:ctcl_manager/base/DAOs/student.dao.dart";
import "package:ctcl_manager/core/database/interface.database.dart";
import "package:ctcl_manager/core/notifications/toast.dart";
import "package:ctcl_manager/l10n/localizations_extension.dart";
import "package:ctcl_manager/src/views/viewstates/students_listing.viewstate.dart";
import "package:flutter/widgets.dart";

class StudentsListingViewModel {
  final BuildContext context;
  final ToastNotifications toast;
  final StudentsListingViewState state;

  final IDatabaseClient databaseClient;

  StudentsListingViewModel(
    this.context, {
    required this.state,
    required this.databaseClient,
  }) : toast = ToastNotifications(context: context);

  Future<void> getStudents() async {
    state.isLoading = true;
    final studentsResult =
        await StudentDAO(databaseClient: databaseClient).getAll();

    studentsResult.when(
      onOk: (students) {
        state.students = students
            .map(
              (student) => StudentSummary(
                id: student.id,
                firstName: student.firstName,
                lastName: student.lastName,
                checkInQuantity: 10,
              ),
            )
            .toList();
        state.isLoading = false;
      },
      onError: (error) {
        toast.showError(
          title: context.strings.error_fetch_students_title,
          description: context.strings.error_fetch_students_description,
        );
        state.hasError = true;
      },
    );
  }

  Future<void> getStudentsByName(String name) async {
    state.isLoading = true;
    final studentsResult =
        await StudentDAO(databaseClient: databaseClient).getByName(name);

    studentsResult.when(
      onOk: (students) {
        state.students = students
            .map(
              (student) => StudentSummary(
                id: student.id,
                firstName: student.firstName,
                lastName: student.lastName,
                checkInQuantity: 10,
              ),
            )
            .toList();
        state.isLoading = false;
      },
      onError: (error) {
        toast.showError(
          title: context.strings.error_fetch_students_title,
          description: context.strings.error_fetch_students_description,
        );
        state.hasError = true;
      },
    );
  }
}
