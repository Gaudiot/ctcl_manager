import "package:ctcl_manager/base/components/locals_dropdown.dart";
import "package:ctcl_manager/base/uicolors.dart";
import "package:ctcl_manager/core/design/components/monetary_text_field.dart";
import "package:ctcl_manager/l10n/localizations_extension.dart";
import "package:ctcl_manager/src/viewmodels/class_details.viewmodel.dart";
import "package:flutter/material.dart";

final class ClassDetailsView extends StatefulWidget {
  final String classId;
  final ClassDetailsViewModel viewModel;

  const ClassDetailsView({
    required this.classId,
    required this.viewModel,
    super.key,
  });

  @override
  State<ClassDetailsView> createState() => _ClassDetailsViewState();
}

class _ClassDetailsViewState extends State<ClassDetailsView> {
  final classNameController = TextEditingController();
  final classDescriptionController = TextEditingController();
  final classValueController = MonetaryValueController();
  final classLocalController = ValueNotifier<String?>(null);

  @override
  void initState() {
    widget.viewModel.init(widget.classId).then((_) {
      classNameController.text = widget.viewModel.state.name;
      classDescriptionController.text = widget.viewModel.state.description;
      classValueController.valueInHundred = widget.viewModel.state.valueHundred
          .toString();
      classLocalController.value = widget.viewModel.state.localId;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.strings.class_title,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        backgroundColor: UIColors.primaryOrangeLighter,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 30,
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
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  TextField(
                    controller: classNameController,
                    decoration: InputDecoration(
                      labelText: context.strings.class_name,
                      hintText: context.strings.class_name,
                      border: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: UIColors.primaryRed),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: classDescriptionController,
                    minLines: 3,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: context.strings.class_description,
                      hintText: context.strings.class_description,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  MonetaryTextField(controller: classValueController),
                  SizedBox(height: 16),
                  LocalsDropdown(controller: classLocalController),
                  SizedBox(height: 16),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: UIColors.primaryOrange,
                      foregroundColor: UIColors.primaryWhite,
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      widget.viewModel.updateClass(
                        context,
                        classId: widget.classId,
                        name: classNameController.text,
                        description: classDescriptionController.text,
                        valueHundred: classValueController.value,
                        localId: classLocalController.value ?? "",
                      );
                    },
                    child: Text(context.strings.confirm_edit),
                  ),
                  SizedBox(height: 4),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: UIColors.primaryWhite,
                      foregroundColor: UIColors.primaryRed,
                      shape: StadiumBorder(),
                      side: BorderSide(color: UIColors.primaryRed),
                    ),
                    onPressed: () {
                      widget.viewModel.deleteClass(context, widget.classId);
                    },
                    child: Text(
                      context.strings.delete_class,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
