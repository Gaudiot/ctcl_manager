import "package:ctcl_manager/base/uicolors.dart";
import "package:ctcl_manager/core/database/interface.database.dart";
import "package:ctcl_manager/l10n/localizations_extension.dart";
import "package:ctcl_manager/src/viewmodels/class_listing.viewmodel.dart";
import "package:ctcl_manager/src/viewmodels/students_listing.viewmodel.dart";
import "package:ctcl_manager/src/views/class_listing.view.dart";
import "package:ctcl_manager/src/views/students_listing.view.dart";
import "package:ctcl_manager/src/views/viewstates/class_listing.viewstate.dart";
import "package:ctcl_manager/src/views/viewstates/students_listing.viewstate.dart";
import "package:flutter/material.dart";

class HomeView extends StatefulWidget {
  final IDatabaseClient databaseClient;

  const HomeView({
    required this.databaseClient,
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  List<Widget> getPages(BuildContext context) {
    return [
      ClassListingView(
        viewModel: ClassListingViewModel(
          context,
          state: ClassListingViewState(classes: []),
          databaseClient: widget.databaseClient,
        ),
      ),
      StudentsListing(
        viewModel: StudentsListingViewModel(
          context,
          state: StudentsListingViewState(students: []),
          databaseClient: widget.databaseClient,
        ),
      ),
    ];
  }

  List<BottomNavigationBarItem> getNavigationItems(BuildContext context) {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.sports_volleyball),
        label: context.strings.classes,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.people),
        label: context.strings.students,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final pages = getPages(context);

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: UIColors.primaryWhiteDarker,
        selectedItemColor: UIColors.primaryOrangeLightest,
        items: getNavigationItems(context),
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
