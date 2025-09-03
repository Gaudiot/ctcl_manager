import "package:ctcl_manager/core/database/supabase/supabase_service.dart";
import "package:ctcl_manager/core/navigation/navigation.dart";
import "package:ctcl_manager/core/variables/envs.dart";
import "package:flutter/material.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Envs.initialize();
  await SupabaseService.initialize();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: NavigationManager.initialRoute,
      routes: NavigationManager.routesMap(),
    );
  }
}
