import "package:ctcl_manager/base/DAOs/class.dao.dart";
import "package:ctcl_manager/base/DAOs/local.dao.dart";
import "package:ctcl_manager/core/navigation/navigation.dart";
import "package:ctcl_manager/core/notifications/toast.dart";
import "package:ctcl_manager/l10n/localizations_extension.dart";
import "package:ctcl_manager/src/views/bottomsheets/create_local.bottomsheet.dart";
import "package:ctcl_manager/src/views/viewstates/create_class.viewstate.dart";
import "package:flutter/material.dart";

final class CreateClassViewModel {
  final BuildContext context;
  final ToastNotifications toast;
  final CreateClassViewState state;

  CreateClassViewModel(this.context, {required this.state})
    : toast = ToastNotifications(context: context);

  String get newLocalId => "new_local";

  // MARK: - Fetch Data

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
        toast.showError(
          title: context.strings.error_fetch_locals_title,
          description: context.strings.error_fetch_locals_description,
        );
        state.hasError = true;
      },
    );
  }

  // MARK: - Network related

  Future<void> createClass({
    required String name,
    required int valueHundred,
    required String? localId,
    required String description,
    required BuildContext context,
  }) async {
    var isValidClass = true;

    state.nameField.isValid = true;
    if (name.isEmpty) {
      state.nameField.isValid = false;
      isValidClass = false;
    }

    state.valueField.isValid = true;
    if (valueHundred == 0) {
      state.valueField.isValid = false;
      isValidClass = false;
    }

    state.localField.isValid = true;
    if (localId == null || localId.isEmpty) {
      state.localField.isValid = false;
      isValidClass = false;
    }

    if (!isValidClass) {
      state.notifyListeners();
      return;
    }

    final response = await ClassDAO.addClass(
      name: name,
      valueHundred: valueHundred,
      localId: localId!,
      description: description,
    );

    response.when(
      onOk: (data) {
        NavigationManager.popWithConfirm(context);
      },
      onError: (error) {
        toast.showError(
          title: context.strings.error_create_class_title,
          description: context.strings.error_create_class_description,
        );
      },
    );
  }

  // MARK: - Navigation

  void cancelCreation(BuildContext context) {
    NavigationManager.pop(context);
  }

  void goToCreateLocalBottomSheet(
    BuildContext context,
    ValueChanged<String> onLocalCreated,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CreateLocalBottomSheet(
          onCreateLocal: ({required id, required name}) {
            state.addLocal(LocalSummary(id: id, name: name));
            onLocalCreated(id);
            state.notifyListeners();
          },
        );
      },
    );
  }
}
