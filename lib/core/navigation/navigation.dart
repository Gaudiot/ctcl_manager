import "package:ctcl_manager/src/viewmodels/class_listing.viewmodel.dart";
import "package:ctcl_manager/src/views/class_listing.view.dart";
import "package:ctcl_manager/src/views/create_class.view.dart";
import "package:ctcl_manager/src/views/viewstates/class_listing.viewstate.dart";
import "package:flutter/material.dart";

typedef RouteBuilder = Widget Function(BuildContext context);

enum NavigationRoutes {
  createClass("/create_class"),
  classListing("/class_listing"),
  classDetails("/class_details");

  final String path;

  const NavigationRoutes(this.path);
}

class NavigationManager {
  NavigationManager._internal();

  static String initialRoute = NavigationRoutes.classListing.path;

  static Map<String, RouteBuilder> routesMap() {
    return {
      NavigationRoutes.classListing.path: (context) => ClassListing(
        viewModel: ClassListingViewModel(
          state: ClassListingViewState(classes: []),
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

  static void popWithConfirm(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context, true);
    }
  }

  static void goTo(BuildContext context, NavigationRoutes route) {
    Navigator.pushNamed(context, route.path);
  }

  static Future<void> goAndCallBack(
    BuildContext context,
    NavigationRoutes route,
    VoidCallback callback,
  ) async {
    Navigator.pushNamed(context, route.path).then((value) {
      debugPrint("Value: $value");
      if (value != null && value is bool && value) {
        callback();
      }
    });
  }
}
