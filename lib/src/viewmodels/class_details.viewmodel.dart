import "package:ctcl_manager/base/DAOs/class.dao.dart";
import "package:ctcl_manager/base/DAOs/local.dao.dart";
import "package:ctcl_manager/base/DAOs/models/class.dao_model.dart";
import "package:ctcl_manager/core/database/supabase/supabase_service.dart";
import "package:ctcl_manager/core/navigation/navigation.dart";
import "package:ctcl_manager/core/notifications/toast.dart";
import "package:ctcl_manager/l10n/localizations_extension.dart";
import "package:ctcl_manager/src/views/viewstates/class_details.viewstate.dart";
import "package:flutter/material.dart";

final class ClassDetailsViewModel {
  final BuildContext context;
  final ToastNotifications toast;
  final ClassDetailsViewState state;

  ClassDetailsViewModel(this.context, {required this.state})
      : toast = ToastNotifications(context: context);

  String get newLocalId => "new_local";

  // MARK: - Fetch Data

  Future<void> init(String classId) async {
    await getClassById(classId);
    await getLocals();
  }

  Future<void> getClassById(String id) async {
    state.isLoading = true;
    final classResult =
        await ClassDAO(databaseClient: SupabaseService.instance).getById(id);

    classResult.when(
      onOk: (classData) {
        state.name = classData.name;
        state.description = classData.description;
        state.valueHundred = classData.valueHundred ?? 0;
        state.localId = classData.localId ?? "";

        state.isLoading = false;
      },
      onError: (error) {
        toast.showError(
          title: context.strings.error_fetch_class_title,
          description: context.strings.error_fetch_class_description,
        );
        state.hasError = true;
      },
    );
  }

  Future<void> getLocals() async {
    state.isLoading = true;
    final localsResult =
        await LocalDAO(databaseClient: SupabaseService.instance).getAll();

    localsResult.when(
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
        toast.showError(
          title: context.strings.error_fetch_locals_title,
          description: context.strings.error_fetch_locals_description,
        );
        state.hasError = true;
      },
    );
  }

  // MARK: - Data

  Future<void> deleteClass(BuildContext context, String classId) async {
    final response = await ClassDAO(databaseClient: SupabaseService.instance)
        .deleteById(classId);
    response.when(
      onOk: (data) {
        NavigationManager.popWithConfirm(context);
      },
      onError: (error) {
        toast.showError(
          title: context.strings.delete_class_error,
          description: context.strings.delete_class_error_description,
        );
      },
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
    final response =
        await ClassDAO(databaseClient: SupabaseService.instance).updateById(
      classId,
      ClassDAOModel(
        id: classId,
        name: name,
        description: description,
        valueHundred: valueHundred,
        localId: localId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    response.when(
      onOk: (data) {
        NavigationManager.popWithConfirm(context);
      },
      onError: (error) {
        toast.showError(
          title: context.strings.update_class_error,
          description: context.strings.update_class_error_description,
        );
      },
    );
  }
}
