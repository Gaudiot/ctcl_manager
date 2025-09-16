import "package:ctcl_manager/src/viewmodels/class_details.viewmodel.dart";
import "package:ctcl_manager/src/viewmodels/class_listing.viewmodel.dart";
import "package:ctcl_manager/src/viewmodels/create_class.viewmodel.dart";
import "package:ctcl_manager/src/views/class_details.view.dart";
import "package:ctcl_manager/src/views/class_listing.view.dart";
import "package:ctcl_manager/src/views/create_class.view.dart";
import "package:ctcl_manager/src/views/viewstates/class_details.viewstate.dart";
import "package:ctcl_manager/src/views/viewstates/class_listing.viewstate.dart";
import "package:ctcl_manager/src/views/viewstates/create_class.viewstate.dart";
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
  static var _args = <String, dynamic>{};

  static Map<String, RouteBuilder> routesMap() {
    return {
      NavigationRoutes.classListing.path: (context) => ClassListingView(
        viewModel: ClassListingViewModel(
          state: ClassListingViewState(classes: []),
        ),
      ),
      NavigationRoutes.createClass.path: (context) => CreateClassView(
        viewModel: CreateClassViewModel(
          state: CreateClassViewState(locals: []),
        ),
      ),
      NavigationRoutes.classDetails.path: (context) {
        final classId = _args.containsKey("classId")
            ? _args["classId"]
            : "falhou";

        return ClassDetailsView(
          classId: classId,
          viewModel: ClassDetailsViewModel(
            state: ClassDetailsViewState.empty(),
          ),
        );
      },
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

  static void goTo(
    BuildContext context,
    NavigationRoutes route, {
    Map<String, String>? args,
  }) {
    _args = args ?? {};
    Navigator.pushNamed(context, route.path);
  }

  static Future<void> goToAndCallBack(
    BuildContext context,
    NavigationRoutes route,
    VoidCallback callback, {
    Map<String, String>? args,
  }) async {
    _args = args ?? {};
    Navigator.pushNamed(context, route.path).then((value) {
      if (value != null && value is bool && value) {
        callback();
      }
    });
  }
}
