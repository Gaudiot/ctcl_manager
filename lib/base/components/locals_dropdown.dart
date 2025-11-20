import "package:ctcl_manager/base/DAOs/local.dao.dart";
import "package:ctcl_manager/base/DAOs/models/local.dao_model.dart";
import "package:ctcl_manager/base/uicolors.dart";
import "package:ctcl_manager/l10n/localizations_extension.dart";
import "package:ctcl_manager/src/views/bottomsheets/create_local.bottomsheet.dart";
import "package:flutter/material.dart";

// MARK: - State

final class LocalsDropdownState with ChangeNotifier {
  bool _isLoading = false;
  List<LocalSummaryDAOModel> _locals = [];

  LocalsDropdownState();

  set isLoading(bool value) {
    if (value == _isLoading) {
      return;
    }
    _isLoading = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set locals(List<LocalSummaryDAOModel> newLocals) {
    _locals = [
      LocalSummaryDAOModel(id: "new_local", name: "Novo Local"),
      ...newLocals,
    ];
    notifyListeners();
  }

  List<LocalSummaryDAOModel> get locals => _locals;

  void addLocal({required String id, required String name}) {
    _locals.add(LocalSummaryDAOModel(id: id, name: name));
    notifyListeners();
  }
}

// MARK: - Component

class LocalsDropdown extends StatefulWidget {
  final String? errorMessage;
  final ValueNotifier<String?>? controller;
  final LocalDAO localDAO;

  const LocalsDropdown({
    required this.localDAO,
    this.errorMessage,
    this.controller,
    super.key,
  });

  @override
  State<LocalsDropdown> createState() => _LocalsDropdownState();
}

class _LocalsDropdownState extends State<LocalsDropdown> {
  final LocalsDropdownState state = LocalsDropdownState();

  bool get hasError => widget.errorMessage?.isNotEmpty ?? false;

  @override
  void initState() {
    _fetchLocals();
    widget.controller?.addListener(_onControllerValueChanged);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onControllerValueChanged);
    super.dispose();
  }

  void _onControllerValueChanged() {
    setState(() {});
  }

  Future<void> _fetchLocals() async {
    state.isLoading = true;
    final localsResult = await widget.localDAO.getAll();

    localsResult.when(
      onOk: (locals) {
        state.locals = locals
            .map(
              (local) => LocalSummaryDAOModel(id: local.id, name: local.name),
            )
            .toList();
        state.isLoading = false;
      },
      onError: (error) {
        state.isLoading = false;
      },
    );
  }

  void _openCreateLocalBottomSheet(ValueChanged<String> onLocalCreated) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CreateLocalBottomSheet(
          databaseClient: widget.localDAO.databaseClient,
          onCreateLocal: ({required id, required name}) {
            state.addLocal(id: id, name: name);
            onLocalCreated(id);
          },
        );
      },
    );
  }

  void _onNewLocalSelected() {
    widget.controller?.value = null;
    _openCreateLocalBottomSheet((localId) {
      widget.controller?.value = localId;
    });

    setState(() {});
  }

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
              color:
                  hasError ? UIColors.primaryRed : UIColors.primaryGreyDarker,
            ),
          ),
          child: ListenableBuilder(
            listenable: state,
            builder: (context, _) {
              if (state.isLoading) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: widget.controller?.value,
                  hint: Text(context.strings.select_local),
                  items: state.locals
                      .map(
                        (local) => DropdownMenuItem(
                          value: local.id,
                          child: Text(local.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == "new_local") {
                      _onNewLocalSelected();
                      return;
                    }
                    widget.controller?.value = value;
                    setState(() {});
                  },
                ),
              );
            },
          ),
        ),
        if (hasError)
          Text(widget.errorMessage!, style: TextStyle(color: Colors.red)),
      ],
    );
  }
}
