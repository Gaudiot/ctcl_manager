import "package:ctcl_manager/base/uicolors.dart";
import "package:ctcl_manager/core/design/components/monetary_text_field.dart";
import "package:ctcl_manager/src/viewmodels/create_class.viewmodel.dart";
import "package:ctcl_manager/src/views/viewstates/create_class.viewstate.dart";
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
  final classValueController = MonetaryValueObserver();
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
      body: SafeArea(
        child: Column(
          children: [
            AppBar(
              title: Text(
                "Criar Turma",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              backgroundColor: UIColors.primaryOrangeLighter,
            ),
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
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListenableBuilder(
                  listenable: widget.viewModel.state,
                  builder: (context, snapshot) {
                    return ListView(
                      children: [
                        TextField(
                          controller: classNameController,
                          decoration: InputDecoration(
                            labelText: "Nome da turma",
                            hintText: "Nome da turma",
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: UIColors.primaryRed,
                              ),
                            ),
                            errorText: widget.viewModel.state.nameField.isValid
                                ? null
                                : widget.viewModel.state.nameField.errorMessage,
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: classDescriptionController,
                          minLines: 3,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: "Descrição da turma",
                            hintText: "Descrição da turma",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 16),
                        MonetaryTextField(valueObserver: classValueController),
                        SizedBox(height: 16),
                        _LocalDropdown(
                          locals: widget.viewModel.state.locals,
                          controller: classLocalController,
                          hasError: !widget.viewModel.state.localField.isValid,
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
                            child: const Text("Criar Turma"),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//MARK: - Components

class _LocalDropdown extends StatefulWidget {
  final List<LocalSumary> locals;
  final ValueNotifier<String?> controller;
  final bool hasError;
  final String errorMessage;

  const _LocalDropdown({
    required this.locals,
    required this.controller,
    required this.hasError,
    required this.errorMessage,
  });

  @override
  State<_LocalDropdown> createState() => _LocalDropdownState();
}

class _LocalDropdownState extends State<_LocalDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: widget.hasError
                  ? UIColors.primaryRed
                  : UIColors.primaryGreyDarker,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: widget.controller.value,
              hint: Text("Selecione um local"),
              items: widget.locals
                  .map(
                    (local) => DropdownMenuItem(
                      value: local.id,
                      child: Text(local.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                widget.controller.value = value;
                setState(() {});
              },
            ),
          ),
        ),
        if (widget.hasError)
          Text(widget.errorMessage, style: TextStyle(color: Colors.red)),
      ],
    );
  }
}
