import "package:ctcl_manager/base/DAOs/models/student.dao_model.dart";
import "package:ctcl_manager/base/DAOs/student.dao.dart";
import "package:ctcl_manager/core/database/interface.database.dart";
import "package:ctcl_manager/core/navigation/navigation.dart";
import "package:ctcl_manager/src/views/viewstates/create_student.viewstate.dart";
import "package:flutter/material.dart";

final class CreateStudentViewModel {
  final CreateStudentViewState state;
  final BuildContext context;

  final IDatabaseClient databaseClient;

  CreateStudentViewModel({
    required this.state,
    required this.databaseClient,
    required this.context,
  });

  Future<void> createStudent({
    required String firstName,
    required String lastName,
    required String phone,
    String? emailAddress,
    String? birthday,
    String? instagram,
  }) async {
    final studentDAO = StudentDAO(databaseClient: databaseClient);

    state.isLoading = true;
    final studentResult = await studentDAO.create(
      StudentDAOModel(
        id: "",
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        emailAddress: emailAddress,
        birthday: DateTime.now().subtract(Duration(days: 365 * 30)),
        instagram: instagram,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    studentResult.when(
      onOk: (_) {
        NavigationManager.pop(context);
        debugPrint("Student created");
      },
      onError: (error) {
        state.hasError = true;
        debugPrint("Error creating student: ${error.message}");
      },
    );
  }
}
