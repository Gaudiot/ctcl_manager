import "package:ctcl_manager/base/uicolors.dart";
import "package:ctcl_manager/core/design/components/debounce_text_field.dart";
import "package:ctcl_manager/l10n/localizations_extension.dart";
import "package:ctcl_manager/src/viewmodels/class_listing.viewmodel.dart";
import "package:flutter/material.dart";

class ClassListingView extends StatefulWidget {
  final ClassListingViewModel viewModel;

  const ClassListingView({required this.viewModel, super.key});

  @override
  State<ClassListingView> createState() => _ClassListingViewState();
}

class _ClassListingViewState extends State<ClassListingView> {
  @override
  void initState() {
    widget.viewModel.getClasses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.strings.classes,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        backgroundColor: UIColors.primaryOrangeLighter,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: UIColors.primaryOrangeLighter,
                  padding: const EdgeInsets.all(16),
                  child: DebounceTextField(
                    debouceTimeInMilliseconds: 300,
                    onDebounce: widget.viewModel.getClassesSumaryByName,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        UIColors.primaryOrangeLighter,
                        UIColors.primaryYellowLighter,
                      ],
                    ),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: UIColors.primaryOrange,
                      foregroundColor: UIColors.primaryWhite,
                      shape: StadiumBorder(),
                    ),
                    onPressed: () => widget.viewModel.goToCreateClass(context),
                    child: Text(context.strings.new_class),
                  ),
                ),
              ],
            ),
            ListenableBuilder(
              listenable: widget.viewModel.state,
              builder: (context, snapshot) {
                final state = widget.viewModel.state;

                if (state.isLoading) {
                  return _ClassListingLoading();
                }

                if (state.hasError) {
                  return _ClassListingError();
                }

                return Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.classes.length,
                    itemBuilder: (_, index) => _ClassSummaryCard(
                      classId: state.classes[index].id,
                      className: state.classes[index].name,
                      local: state.classes[index].local,
                      studentsQuantity: state.classes[index].studentsQuantity,
                      onTap: () => widget.viewModel.goToClassDetails(
                        context,
                        state.classes[index].id,
                      ),
                    ),
                    separatorBuilder: (_, _) => SizedBox(height: 8),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//MARK: - Components

final class _ClassSummaryCard extends StatelessWidget {
  final String classId;
  final String className;
  final String local;
  final int studentsQuantity;
  final VoidCallback onTap;

  const _ClassSummaryCard({
    required this.classId,
    required this.className,
    required this.local,
    required this.studentsQuantity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(className, style: TextStyle(fontSize: 24)),
                  SizedBox(height: 8),
                  Text(local, style: TextStyle(fontSize: 16)),
                ],
              ),
              Spacer(),
              Icon(Icons.person, size: 16),
              SizedBox(width: 4),
              Text("$studentsQuantity", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

//MARK: - State Components

final class _ClassListingLoading extends StatelessWidget {
  const _ClassListingLoading();

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Center(child: CircularProgressIndicator()));
  }
}

final class _ClassListingError extends StatelessWidget {
  const _ClassListingError();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(child: Text(context.strings.classes_loading_error)),
    );
  }
}
