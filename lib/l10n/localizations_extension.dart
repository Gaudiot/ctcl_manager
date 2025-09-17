import "package:ctcl_manager/l10n/app_localizations.dart";
import "package:flutter/widgets.dart";

extension LocalizationsExtension on BuildContext {
  AppLocalizations get strings => AppLocalizations.of(this)!;
}
