// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get class_title => 'Turma';

  @override
  String get classes => 'Turmas';

  @override
  String get new_class => '+ Turma';

  @override
  String get classes_loading_error => 'Erro ao carregar turmas';

  @override
  String get class_name => 'Nome da turma';

  @override
  String get class_description => 'Descrição da turma';

  @override
  String get create_class => 'Criar Turma';

  @override
  String get delete_class => 'Apagar Turma';

  @override
  String get invalid_class_name_empty => 'Nome não pode ser vazio';

  @override
  String get invalid_class_value_empty => 'Valor não pode ser vazio';

  @override
  String get invalid_class_local_empty => 'Local não pode ser vazio';

  @override
  String get confirm_edit => 'Confirmar Edição';

  @override
  String get create_local => 'Criar Local';

  @override
  String get local_field_title => 'Nome do local (*)';

  @override
  String get value_field_title => 'Valor';

  @override
  String get search_field_placeholder => 'Pesquisar';

  @override
  String get select_local => 'Selecione um local';
}
