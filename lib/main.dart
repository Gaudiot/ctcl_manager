import "package:ctcl_manager/src/models/class.viewmodel.dart";
import "package:ctcl_manager/src/views/class.view.dart";
import "package:ctcl_manager/src/views/create_class.view.dart";
import "package:flutter/material.dart";

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: CreateClassView()));
    // return MaterialApp(
    //   home: Scaffold(
    //     body: ClassListing(
    //       viewModel: ClassViewModel(
    //         classes: [
    //           ClassSumary(
    //             id: "1",
    //             name: "Turma 1",
    //             local: "Local 1",
    //             studentsQuantity: 10,
    //           ),
    //           ClassSumary(
    //             id: "2",
    //             name: "Turma 2",
    //             local: "Local 2",
    //             studentsQuantity: 20,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
