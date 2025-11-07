import "package:ctcl_manager/core/database/supabase/supabase_service.dart";
import "package:ctcl_manager/core/navigation/navigation.dart";
import "package:ctcl_manager/core/variables/envs.dart";
import "package:ctcl_manager/l10n/app_localizations.dart";
import "package:flutter/material.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Envs.initialize();
  await SupabaseService.instance.start();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: NavigationManager.initialRoute,
      routes: NavigationManager.routesMap(),
    );
  }
}
