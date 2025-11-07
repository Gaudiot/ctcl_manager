import "package:ctcl_manager/core/database/interface.database.dart";
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

class SupabaseService implements IDatabaseClient {
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

  // MARK: - INITIALIZE

  @override
  Future<void> start() async {
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

  // MARK: - CREATE

  @override
  Future<Map<String, dynamic>> insert(
    String table,
    Map<String, dynamic> data,
  ) async {
    final response =
        await Supabase.instance.client.from(table).insert(data).select();

    return response[0];
  }

  // MARK: - READ

  @override
  Future<List<Map<String, dynamic>>> get(
    String table, {
    int limit = 100,
    int offset = 0,
  }) async {
    final response = await Supabase.instance.client
        .from(table)
        .select()
        .range(offset * limit, (offset + 1) * limit - 1);

    return response;
  }

  @override
  Future<Map<String, dynamic>> getById(String table, String id) async {
    final response =
        await Supabase.instance.client.from(table).select().eq("id", id);

    return response[0];
  }

  // MARK: - UPDATE

  @override
  Future<Map<String, dynamic>> updateById(
    String table,
    String id,
    Map<String, dynamic> data,
  ) async {
    final response =
        await Supabase.instance.client.from(table).update(data).eq("id", id);

    return response[0];
  }

  // MARK: - DELETE

  @override
  Future<void> deleteById(String table, String id) async {
    await Supabase.instance.client.from(table).delete().eq("id", id);
  }
}
