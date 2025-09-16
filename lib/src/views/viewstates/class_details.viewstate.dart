import "package:ctcl_manager/src/views/viewstates/base_viewstate.dart";

final class LocalSummary {
  final String id;
  final String name;

  const LocalSummary({required this.id, required this.name});
}

final class ClassDetailsViewState extends BaseViewState {
  final String id;
  String name;
  String description;
  String localId;
  int valueHundred;
  List<LocalSummary> locals;

  ClassDetailsViewState({
    required this.id,
    required this.name,
    required this.description,
    required this.localId,
    required this.valueHundred,
    required this.locals,
  });

  ClassDetailsViewState.empty()
    : id = "",
      name = "",
      description = "",
      localId = "",
      valueHundred = 0,
      locals = [];
}
