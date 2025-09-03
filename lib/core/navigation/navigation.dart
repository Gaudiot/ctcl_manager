import "package:ctcl_manager/src/models/class.viewmodel.dart";
import "package:ctcl_manager/src/views/class.view.dart";
import "package:ctcl_manager/src/views/create_class.view.dart";
import "package:flutter/material.dart";

typedef RouteBuilder = Widget Function(BuildContext context);

enum NavigationRoutes {
  createClass("/create_class"),
  classListing("/class_listing");

  final String path;

  const NavigationRoutes(this.path);
}

class NavigationManager {
  NavigationManager._internal();

  static String initialRoute = NavigationRoutes.classListing.path;

  static Map<String, RouteBuilder> routesMap() {
    return {
      NavigationRoutes.classListing.path: (context) => ClassListing(
        viewModel: ClassViewModel(
          classes: [
            ClassSumary(
              id: "1",
              name: "Turma 1",
              local: "Local 1",
              studentsQuantity: 10,
            ),
            ClassSumary(
              id: "2",
              name: "Turma 2",
              local: "Local 2",
              studentsQuantity: 20,
            ),
            ClassSumary(
              id: "3",
              name: "Turma 3",
              local: "Local 3",
              studentsQuantity: 30,
            ),
          ],
        ),
      ),
      NavigationRoutes.createClass.path: (context) => CreateClassView(),
    };
  }

  static void pop(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  static void goTo(BuildContext context, NavigationRoutes route) {
    Navigator.pushNamed(context, route.path);
  }
}
