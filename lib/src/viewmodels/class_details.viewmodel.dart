import "package:ctcl_manager/base/DAOs/class.dao.dart";
import "package:ctcl_manager/base/DAOs/local.dao.dart";
import "package:ctcl_manager/core/navigation/navigation.dart";
import "package:ctcl_manager/src/views/viewstates/class_details.viewstate.dart";
import "package:flutter/material.dart";

final class ClassDetailsViewModel {
  final ClassDetailsViewState state;

  ClassDetailsViewModel({required this.state});

  String get newLocalId => "new_local";

  // MARK: - Fetch Data

  Future<void> init(String classId) async {
    await getClassById(classId);
    await getLocals();
  }

  Future<void> getClassById(String id) async {
    state.isLoading = true;
    final classResult = await ClassDAO.getClassById(id);

    classResult.when(
      onOk: (classData) {
        state.name = classData.name;
        state.description = classData.description;
        state.valueHundred = classData.valueHundred;
        state.localId = classData.localId;

        state.isLoading = false;
      },
      onError: (error) {
        state.hasError = true;
      },
    );
  }

  Future<void> getLocals() async {
    state.isLoading = true;
    final locals = await LocalDAO.getLocals();

    locals.when(
      onOk: (locals) {
        final fetchedLocals = locals
            .map((local) => LocalSummary(id: local.id, name: local.name))
            .toList();
        final newLocals = <LocalSummary>[
          LocalSummary(id: newLocalId, name: "Novo Local"),
          ...fetchedLocals,
        ];
        state.locals = newLocals;

        state.isLoading = false;
      },
      onError: (error) {
        state.hasError = true;
      },
    );
  }

  // MARK: - Data

  Future<void> deleteClass(BuildContext context, String classId) async {
    final response = await ClassDAO.delete(classId);
    response.when(
      onOk: (data) {
        NavigationManager.popWithConfirm(context);
      },
      onError: (error) {},
    );
  }

  Future<void> updateClass(
    BuildContext context, {
    required String classId,
    required String name,
    required String description,
    required int valueHundred,
    required String localId,
  }) async {
    final response = await ClassDAO.update(
      classId,
      name,
      description,
      valueHundred,
      localId,
    );

    response.when(
      onOk: (data) {
        NavigationManager.popWithConfirm(context);
      },
      onError: (error) {},
    );
  }
}
