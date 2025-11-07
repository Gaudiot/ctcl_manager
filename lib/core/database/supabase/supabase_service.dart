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

final class SupabaseService implements IDatabaseClient {
  SupabaseService._internal();

  static final SupabaseService _instance = SupabaseService._internal();

  static SupabaseService get instance => _instance;

  SupabaseClient get _client {
    return Supabase.instance.client;
  }

  // MARK: - Initialize

  @override
  Future<void> start() async {
    final supabaseUrl = Envs.get(
      key: EnvsKeys.supabaseUrl,
      fallback: "YOUR_SUPABASE_URL",
    );
    final supabaseAnonKey = Envs.get(
      key: EnvsKeys.supabaseAnonKey,
      fallback: "YOUR_SUPABASE_ANON_KEY",
    );

    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  }

  // MARK: - Create

  @override
  Future<Map<String, dynamic>> insert(
    String table,
    Map<String, dynamic> data,
  ) async {
    final response = await _client.from(table).insert(data).select();

    return response[0];
  }

  // MARK: - Read

  @override
  Future<List<Map<String, dynamic>>> get(
    String table, {
    int limit = 100,
    int offset = 0,
  }) async {
    final response = await _client
        .from(table)
        .select()
        .range(offset * limit, (offset + 1) * limit - 1);

    return response;
  }

  @override
  Future<Map<String, dynamic>> getById(String table, String id) async {
    final response = await _client.from(table).select().eq("id", id);

    return response[0];
  }

  // MARK: - Update

  @override
  Future<Map<String, dynamic>> updateById(
    String table,
    String id,
    Map<String, dynamic> data,
  ) async {
    final response =
        await _client.from(table).update(data).eq("id", id).select().single();

    return response;
  }

  // MARK: - Delete

  @override
  Future<void> deleteById(String table, String id) async {
    await _client.from(table).delete().eq("id", id);
  }
}
