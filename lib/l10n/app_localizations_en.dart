// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get class_title => 'Class';

  @override
  String get classes => 'Classes';

  @override
  String get new_class => '+ Class';

  @override
  String get classes_loading_error => 'Error loading classes';

  @override
  String get class_name => 'Class name';

  @override
  String get class_description => 'Class description';

  @override
  String get create_class => 'Create Class';

  @override
  String get delete_class => 'Delete Class';

  @override
  String get invalid_class_name_empty => 'Class name cannot be empty';

  @override
  String get invalid_class_value_empty => 'Class value cannot be empty';

  @override
  String get invalid_class_local_empty => 'Class local cannot be empty';

  @override
  String get confirm_edit => 'Confirm Edit';

  @override
  String get create_local => 'Create Local';

  @override
  String get local_field_title => 'Local name (*)';

  @override
  String get value_field_title => 'Value';

  @override
  String get search_field_placeholder => 'Search';

  @override
  String get select_local => 'Select a local';
}
