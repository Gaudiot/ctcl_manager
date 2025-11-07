import "package:ctcl_manager/core/database/interface.database.dart";
import "package:ctcl_manager/core/variables/result_type.dart";

abstract interface class BaseDAO<T, E extends Exception> {
  IDatabaseClient get databaseClient;
  String get tableName;

  Future<Result<T, E>> create(T data);
  Future<Result<List<T>, E>> getAll();
  Future<Result<T, E>> getById(String id);
  Future<Result<T, E>> updateById(String id, T data);
  Future<Result<void, E>> deleteById(String id);
}
