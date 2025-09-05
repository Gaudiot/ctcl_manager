import "dart:async";

import "package:ctcl_manager/base/DAOs/class.dao.dart";
import "package:ctcl_manager/base/uicolors.dart";
import "package:ctcl_manager/core/navigation/navigation.dart";
import "package:ctcl_manager/src/models/class.viewmodel.dart";
import "package:flutter/material.dart";

class ClassListing extends StatefulWidget {
  final ClassViewModel viewModel;

  const ClassListing({required this.viewModel, super.key});

  @override
  State<ClassListing> createState() => _ClassListingState();
}

class _ClassListingState extends State<ClassListing> {
  String _searchText = '';
  List<ClassSumary> _allClasses = [];
  List<ClassSumary> _filteredClasses = [];

  Future<void> _addClass() async {
    await NavigationManager.goAndCallBack(
      context,
      NavigationRoutes.createClass,
      () {
        debugPrint("Callback called");
        _getClassesSumary();
      },
    );
  }

  Future<void> _getClassesSumary() async {
    final classesSumary = await ClassDAO.getClassesSumary();
    setState(() {
      _allClasses = classesSumary
          .map(
            (e) => ClassSumary(
              id: e.id,
              name: e.name,
              local: e.localName,
              studentsQuantity: e.studentsQuantity,
            ),
          )
          .toList();
      _filterClasses();
    });
  }

  void _filterClasses() {
    if (_searchText.isEmpty) {
      _filteredClasses = List.from(_allClasses);
    } else {
      _filteredClasses = _allClasses
          .where(
            (classItem) => classItem.name.toLowerCase().contains(
              _searchText.toLowerCase(),
            ),
          )
          .toList();
    }
    widget.viewModel.classes = _filteredClasses;
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchText = value;
      _filterClasses();
    });
  }

  @override
  void initState() {
    _getClassesSumary();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClassViewHeader(
              onAddClass: _addClass,
              onSearchChanged: _onSearchChanged,
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: _filteredClasses.length,
                itemBuilder: (context, index) {
                  final classSumary = _filteredClasses[index];
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
      ),
    );
  }
}

class ClassViewHeader extends StatelessWidget {
  final VoidCallback onAddClass;
  final Function(String) onSearchChanged;

  const ClassViewHeader({
    required this.onAddClass,
    required this.onSearchChanged,
    super.key,
  });

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
          AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "Turmas",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16),
          SearchTextField(onSearch: onSearchChanged, searchTimeout: 100),
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
