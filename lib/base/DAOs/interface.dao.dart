import "package:ctcl_manager/core/variables/result_type.dart";
import "package:supabase_flutter/supabase_flutter.dart";

abstract interface class BaseDAO<T, E extends Exception> {
  SupabaseClient get databaseClient;

  Future<Result<T, E>> create(T data);
  Future<Result<T, E>> getById(String id);
  Future<Result<T, E>> updateById(String id, T data);
  Future<Result<void, E>> deleteById(String id);
}
