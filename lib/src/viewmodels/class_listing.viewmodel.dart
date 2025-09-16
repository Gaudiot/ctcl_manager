import "package:ctcl_manager/base/DAOs/class.dao.dart";
import "package:ctcl_manager/core/navigation/navigation.dart";
import "package:ctcl_manager/src/views/viewstates/class_listing.viewstate.dart";
import "package:flutter/material.dart";

class ClassListingViewModel {
  final ClassListingViewState state;

  ClassListingViewModel({required this.state});

  // MARK: - Fetch Data

  Future<void> getClasses() async {
    state.isLoading = true;
    final classes = await ClassDAO.getClassesSumary();

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
        state.hasError = true;
      },
    );
  }

  Future<void> getClassesSumaryByName(String name) async {
    state.isLoading = true;
    final classes = await ClassDAO.getClassesSumaryByName(name);

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
