import "package:ctcl_manager/base/uicolors.dart";
import "package:ctcl_manager/core/design/components/monetary_text_field.dart";
import "package:ctcl_manager/core/design/components/ui_dropdown.dart";
import "package:ctcl_manager/src/viewmodels/class_details.viewmodel.dart";
import "package:flutter/material.dart";

class ClassDetailsView extends StatelessWidget {
  final String classId;
  final classNameController = TextEditingController();
  final classDescriptionController = TextEditingController();
  final ClassDetailsViewModel viewModel;

  ClassDetailsView({required this.classId, required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Turma",
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
                      labelText: "Nome da turma",
                      hintText: "Nome da turma",
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
                      labelText: "Descrição da turma",
                      hintText: "Descrição da turma",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  MonetaryTextField(),
                  SizedBox(height: 16),
                  UIDropdown(placeholderText: "Selecione um local", items: []),
                  SizedBox(height: 16),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: UIColors.primaryOrange,
                      foregroundColor: UIColors.primaryWhite,
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      // viewModel.updateClass(
                      //   classId: classId,
                      //   name: classNameController.text,
                      //   description: classDescriptionController.text,
                      //   valueHundred: classValueController.value,
                      //   localId: classLocalController.value ?? "",
                      // );
                    },
                    child: Text("Confirmar Edição"),
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
                      viewModel.deleteClass(classId);
                    },
                    child: Text(
                      "Apagar Turma",
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
