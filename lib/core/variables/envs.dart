import "package:flutter_dotenv/flutter_dotenv.dart";

enum EnvsKeys {
  supabaseUrl("SUPABASE_URL"),
  supabaseAnonKey("SUPABASE_ANON_KEY");

  final String _name;

  const EnvsKeys(this._name);

  String get name => _name;
}

class Envs {
  Envs._();

  static Future<void> initialize() async {
    try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      throw Exception("Error loading envs: $e");
    }
  }

  static String get({required EnvsKeys key, String fallback = ""}) {
    if (!dotenv.isInitialized) {
      throw Exception("Enviroment is not initialized");
    }
    return dotenv.env[key.name] ?? fallback;
  }
}
