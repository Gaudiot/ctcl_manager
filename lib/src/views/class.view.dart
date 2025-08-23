import "dart:async";

import "package:ctcl_manager/base/uicolors.dart";
import "package:flutter/material.dart";

class ClassListing extends StatelessWidget {
  const ClassListing({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClassViewHeader(),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: 20,
              itemBuilder: (context, index) {
                return ClassCard(
                  classId: "$index",
                  className: "Class $index",
                  local: "Local $index",
                  studentsQuantity: index * 10,
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
  const ClassViewHeader({super.key});

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
            onPressed: () {
              print("+ Turma");
            },
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
