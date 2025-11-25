import "package:ctcl_manager/core/database/mock.database.dart";
import "package:ctcl_manager/core/database/supabase/supabase_service.dart";
import "package:ctcl_manager/core/variables/envs.dart";
import "package:ctcl_manager/src/viewmodels/class_details.viewmodel.dart";
import "package:ctcl_manager/src/viewmodels/class_listing.viewmodel.dart";
import "package:ctcl_manager/src/viewmodels/create_class.viewmodel.dart";
import "package:ctcl_manager/src/viewmodels/students_listing.viewmodel.dart";
import "package:ctcl_manager/src/views/class_details.view.dart";
import "package:ctcl_manager/src/views/class_listing.view.dart";
import "package:ctcl_manager/src/views/create_class.view.dart";
import "package:ctcl_manager/src/views/create_student.view.dart";
import "package:ctcl_manager/src/views/home.view.dart";
import "package:ctcl_manager/src/views/students_listing.view.dart";
import "package:ctcl_manager/src/views/viewstates/class_details.viewstate.dart";
import "package:ctcl_manager/src/views/viewstates/class_listing.viewstate.dart";
import "package:ctcl_manager/src/views/viewstates/create_class.viewstate.dart";
import "package:ctcl_manager/src/views/viewstates/students_listing.viewstate.dart";
import "package:flutter/material.dart";

typedef RouteBuilder = Widget Function(BuildContext context);

enum NavigationRoutes {
  home("/home"),
  createClass("/create_class"),
  createStudent("/create_student"),
  classListing("/class_listing"),
  classDetails("/class_details"),
  studentsListing("/students_listing");

  final String path;

  const NavigationRoutes(this.path);
}

class NavigationManager {
  NavigationManager._internal();

  static String initialRoute = NavigationRoutes.home.path;
  static var _args = <String, dynamic>{};

  static Map<String, RouteBuilder> routesMap() {
    final isProd = Envs.get(key: EnvsKeys.isProd) == "true";
    final databaseClient =
        isProd ? SupabaseService.instance : MockDatabaseClient.instance;

    return {
      NavigationRoutes.home.path: (context) => HomeView(
            databaseClient: databaseClient,
          ),
      NavigationRoutes.classListing.path: (context) => ClassListingView(
            viewModel: ClassListingViewModel(
              context,
              state: ClassListingViewState(classes: []),
              databaseClient: databaseClient,
            ),
          ),
      NavigationRoutes.createClass.path: (context) => CreateClassView(
            viewModel: CreateClassViewModel(
              context,
              state: CreateClassViewState(locals: []),
              databaseClient: databaseClient,
            ),
          ),
      NavigationRoutes.classDetails.path: (context) {
        final classId =
            _args.containsKey("classId") ? _args["classId"] : "falhou";

        return ClassDetailsView(
          classId: classId,
          viewModel: ClassDetailsViewModel(
            context,
            state: ClassDetailsViewState.empty(),
            databaseClient: databaseClient,
          ),
        );
      },
      NavigationRoutes.studentsListing.path: (context) => StudentsListing(
            viewModel: StudentsListingViewModel(
              context,
              state: StudentsListingViewState(students: []),
              databaseClient: databaseClient,
            ),
          ),
      NavigationRoutes.createStudent.path: (context) => CreateStudentView(),
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
