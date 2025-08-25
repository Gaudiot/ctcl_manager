import "dart:async";

import "package:ctcl_manager/base/uicolors.dart";
import "package:ctcl_manager/src/models/class.viewmodel.dart";
import "package:flutter/material.dart";

class ClassListing extends StatefulWidget {
  final ClassViewModel viewModel;

  const ClassListing({required this.viewModel, super.key});

  @override
  State<ClassListing> createState() => _ClassListingState();
}

class _ClassListingState extends State<ClassListing> {
  void _addClass() {
    setState(() {
      widget.viewModel.classes.add(
        ClassSumary(
          id: "x",
          name: "Turma x",
          local: "Local x",
          studentsQuantity: 10,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClassViewHeader(onAddClass: _addClass),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: widget.viewModel.classes.length,
              itemBuilder: (context, index) {
                final classSumary = widget.viewModel.classes[index];
                return ClassCard(
                  classId: classSumary.id,
                  className: classSumary.name,
                  local: classSumary.local,
                  studentsQuantity: classSumary.studentsQuantity,
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 8);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ClassViewHeader extends StatelessWidget {
  final VoidCallback onAddClass;

  const ClassViewHeader({required this.onAddClass, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            UIColors.primaryOrangeLighter,
            UIColors.primaryYellowLighter,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Turmas",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          SearchTextField(
            onSearch: (value) {
              print(value);
            },
            searchTimeout: 300,
          ),
          SizedBox(height: 8),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: UIColors.primaryOrange,
              foregroundColor: UIColors.primaryWhite,
              shape: StadiumBorder(),
            ),
            onPressed: onAddClass,
            child: const Text("+ Turma"),
          ),
        ],
      ),
    );
  }
}

final class SearchTextField extends StatefulWidget {
  final Function(String) onSearch;
  final int? searchTimeout;

  const SearchTextField({
    required this.onSearch,
    super.key,
    this.searchTimeout,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  Timer? _debounceTimer;

  void _onSearch(String value) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    _debounceTimer = Timer(
      Duration(milliseconds: widget.searchTimeout!),
      () => widget.onSearch(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: _onSearch,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.search),
        fillColor: UIColors.primaryWhiteSemiDark,
        filled: true,
        hintText: "Nome da turma",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: UIColors.primaryBlack),
        ),
      ),
    );
  }
}

class ClassCard extends StatelessWidget {
  final String classId;
  final String className;
  final String local;
  final int studentsQuantity;

  const ClassCard({
    required this.classId,
    required this.className,
    required this.local,
    required this.studentsQuantity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
