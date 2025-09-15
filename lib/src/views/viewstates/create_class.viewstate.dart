import "package:ctcl_manager/src/views/viewstates/base_viewstate.dart";

final class LocalSummary {
  final String id;
  final String name;

  const LocalSummary({required this.id, required this.name});
}

class CreateClassFieldState {
  bool isValid;
  final String errorMessage;

  CreateClassFieldState({required this.errorMessage, this.isValid = true});
}

final class CreateClassViewState extends BaseViewState {
  List<LocalSummary> locals;
  CreateClassFieldState nameField = CreateClassFieldState(
    errorMessage: "Nome não pode ser vazio",
  );
  CreateClassFieldState valueField = CreateClassFieldState(
    errorMessage: "Valor não pode ser vazio",
  );
  CreateClassFieldState localField = CreateClassFieldState(
    errorMessage: "Local não pode ser vazio",
  );

  CreateClassViewState({required this.locals});

  void addLocal(LocalSummary local) {
    locals.add(local);
    notifyListeners();
  }
}
