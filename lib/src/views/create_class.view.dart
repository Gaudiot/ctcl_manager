import "package:ctcl_manager/base/DAOs/local.dao.dart";
import "package:ctcl_manager/base/components/ctcl_textfield.component.dart";
import "package:ctcl_manager/base/components/locals_dropdown.dart";
import "package:ctcl_manager/base/uicolors.dart";
import "package:ctcl_manager/core/design/components/input_formatter/input_formatter.dart";
import "package:ctcl_manager/core/design/components/monetary_text_field.dart";
import "package:ctcl_manager/l10n/localizations_extension.dart";
import "package:ctcl_manager/src/viewmodels/create_class.viewmodel.dart";
import "package:flutter/material.dart";

class CreateClassView extends StatefulWidget {
  final CreateClassViewModel viewModel;

  const CreateClassView({required this.viewModel, super.key});

  @override
  State<CreateClassView> createState() => _CreateClassViewState();
}

class _CreateClassViewState extends State<CreateClassView> {
  final classNameController = TextEditingController();
  final classDescriptionController = TextEditingController();
  final classValueController = MonetaryValueController();
  final classLocalController = ValueNotifier<String?>(null);

  @override
  void initState() {
    widget.viewModel.getLocals();
    super.initState();
  }

  @override
  void dispose() {
    classNameController.dispose();
    classDescriptionController.dispose();
    classLocalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.strings.create_class,
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
              child: ListenableBuilder(
                listenable: widget.viewModel.state,
                builder: (context, snapshot) {
                  return ListView(
                    padding: EdgeInsets.all(16),
                    children: [
                      CtclTextField.required(
                        controller: classNameController,
                        labelText: context.strings.class_name,
                        hintText: context.strings.class_name,
                      ),
                      SizedBox(height: 16),
                      CtclTextField.required(
                        controller: classDescriptionController,
                        labelText: context.strings.class_description,
                        hintText: context.strings.class_description,
                        maxLines: 3,
                      ),
                      SizedBox(height: 16),
                      CtclTextField.required(
                        labelText: "Value",
                        inputFormatter: InputFormatter.currency,
                      ),
                      SizedBox(height: 16),
                      LocalsDropdown(
                        localDAO: LocalDAO(
                          databaseClient: widget.viewModel.databaseClient,
                        ),
                        controller: classLocalController,
                        errorMessage:
                            widget.viewModel.state.localField.errorMessage,
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: 300,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: UIColors.primaryOrange,
                            foregroundColor: UIColors.primaryWhite,
                            shape: StadiumBorder(),
                          ),
                          onPressed: () {
                            widget.viewModel.createClass(
                              context: context,
                              name: classNameController.text,
                              description: classDescriptionController.text,
                              valueHundred: classValueController.value,
                              localId: classLocalController.value ?? "",
                            );
                          },
                          child: Text(context.strings.create_class),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
