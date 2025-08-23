import "package:ctcl_manager/src/models/class.viewmodel.dart";
import "package:ctcl_manager/src/views/class.view.dart";
import "package:flutter/material.dart";

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ClassListing(
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
              ClassSumary(
                id: "4",
                name: "Turma 4",
                local: "Local 4",
                studentsQuantity: 10,
              ),
              ClassSumary(
                id: "5",
                name: "Turma 5",
                local: "Local 5",
                studentsQuantity: 20,
              ),
              ClassSumary(
                id: "6",
                name: "Turma 6",
                local: "Local 6",
                studentsQuantity: 30,
              ),
              ClassSumary(
                id: "7",
                name: "Turma 7",
                local: "Local 7",
                studentsQuantity: 10,
              ),
              ClassSumary(
                id: "8",
                name: "Turma 8",
                local: "Local 8",
                studentsQuantity: 20,
              ),
              ClassSumary(
                id: "9",
                name: "Turma 9",
                local: "Local 9",
                studentsQuantity: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
