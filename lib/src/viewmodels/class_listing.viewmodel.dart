import "package:ctcl_manager/base/DAOs/class.dao.dart";
import "package:ctcl_manager/core/navigation/navigation.dart";
import "package:ctcl_manager/core/notifications/toast.dart";
import "package:ctcl_manager/l10n/localizations_extension.dart";
import "package:ctcl_manager/src/views/viewstates/class_listing.viewstate.dart";
import "package:flutter/material.dart";

class ClassListingViewModel {
  final BuildContext context;
  final ToastNotifications toast;
  final ClassListingViewState state;

  ClassListingViewModel(this.context, {required this.state})
    : toast = ToastNotifications(context: context);

  // MARK: - Fetch Data

  Future<void> getClasses() async {
    state.isLoading = true;
    final classes = await ClassDAO.getClassesSummary();

    classes.when(
      onOk: (classes) {
        state.classes = classes
            .map(
              (classSumary) => ClassSumary(
                id: classSumary.id,
                name: classSumary.name,
                local: classSumary.localName,
                studentsQuantity: classSumary.studentsQuantity,
              ),
            )
            .toList();
        state.isLoading = false;
      },
      onError: (error) {
        toast.showError(
          title: context.strings.error_fetch_classes_title,
          description: context.strings.error_fetch_classes_description,
        );
        state.hasError = true;
      },
    );
  }

  Future<void> getClassesSummaryByName(String name) async {
    state.isLoading = true;
    final classes = await ClassDAO.getClassesSummaryByName(name);

    classes.when(
      onOk: (classes) {
        state.classes = classes
            .map(
              (classSumary) => ClassSumary(
                id: classSumary.id,
                name: classSumary.name,
                local: classSumary.localName,
                studentsQuantity: classSumary.studentsQuantity,
              ),
            )
            .toList();
        state.isLoading = false;
      },
      onError: (error) {
        toast.showError(
          title: context.strings.error_fetch_classes_title,
          description: context.strings.error_fetch_classes_description,
        );
        state.hasError = true;
      },
    );
  }

  //MARK: - Navigation

  void goToClassDetails(BuildContext context, String classId) {
    NavigationManager.goToAndCallBack(
      context,
      NavigationRoutes.classDetails,
      () {
        getClasses();
      },
      args: {"classId": classId},
    );
  }

  void goToCreateClass(BuildContext context) {
    NavigationManager.goToAndCallBack(
      context,
      NavigationRoutes.createClass,
      () {
        getClasses();
      },
    );
  }
}
