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
  String get students => 'Students';

  @override
  String get new_student => '+ Student';

  @override
  String get class_name => 'Class name';

  @override
  String get class_description => 'Class description';

  @override
  String get create_class => 'Create Class';

  @override
  String get create_student => 'Create Student';

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

  @override
  String get delete_class_error => 'Error deleting class';

  @override
  String get delete_class_error_description =>
      'There was an error deleting the class. Please try again later.';

  @override
  String get update_class_error => 'Error updating class';

  @override
  String get update_class_error_description =>
      'There was an error updating the class. Please try again later.';

  @override
  String get error_fetch_class_title => 'Error fetching class';

  @override
  String get error_fetch_class_description =>
      'There was an error fetching the class. Please try again later.';

  @override
  String get error_fetch_classes_title => 'Error fetching classes';

  @override
  String get error_fetch_classes_description =>
      'There was an error fetching the classes. Please try again later.';

  @override
  String get error_fetch_students_title => 'Error fetching students';

  @override
  String get error_fetch_students_description =>
      'There was an error fetching the students. Please try again later.';

  @override
  String get error_fetch_locals_title => 'Error fetching locals';

  @override
  String get error_fetch_locals_description =>
      'There was an error fetching the locals. Please try again later.';

  @override
  String get error_create_class_title => 'Error creating class';

  @override
  String get error_create_class_description =>
      'There was an error creating the class. Please try again later.';

  @override
  String get field_required => 'This field is required';

  @override
  String get invalid_date => 'Invalid date';

  @override
  String get invalid_instagram => 'Invalid Instagram';

  @override
  String get invalid_email => 'Invalid email address';

  @override
  String get invalid_name => 'Invalid name';
}
