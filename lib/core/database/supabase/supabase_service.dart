import "package:ctcl_manager/core/variables/envs.dart";
import "package:supabase_flutter/supabase_flutter.dart";

enum SupabaseTables {
  classes("classes"),
  students("students"),
  locals("locals"),
  lessons("lessons"),
  lessonsStudents("lessons_students");

  final String _name;

  const SupabaseTables(this._name);

  String get name => _name;
}

class SupabaseService {
  SupabaseService._internal();

  static Future<void> initialize() async {
    final supabaseUrl = Envs.get(
      key: EnvsKeys.supabaseUrl,
      fallback: "SUA_SUPABASE_URL_AQUI",
    );
    final supabaseAnonKey = Envs.get(
      key: EnvsKeys.supabaseAnonKey,
      fallback: "SUA_SUPABASE_ANON_KEY_AQUI",
    );

    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  }

  static SupabaseClient get client {
    return Supabase.instance.client;
  }

  static void getTable(
    SupabaseTables table, {
    int limit = 100,
    int offset = 0,
  }) {
    client
        .from(table.name)
        .select()
        .range(offset * limit, (offset + 1) * limit - 1);
  }
}
