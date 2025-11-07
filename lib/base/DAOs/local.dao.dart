import "package:ctcl_manager/base/DAOs/errors/local.dao_error.dart";
import "package:ctcl_manager/base/DAOs/interface.dao.dart";
import "package:ctcl_manager/base/DAOs/models/local.dao_model.dart";
import "package:ctcl_manager/core/database/interface.database.dart";
import "package:ctcl_manager/core/database/supabase/supabase_service.dart";
import "package:ctcl_manager/core/variables/result_type.dart";

final class LocalDAO implements BaseDAO<LocalDAOModel, LocalDAOError> {
  @override
  final IDatabaseClient databaseClient;

  const LocalDAO(this.databaseClient);

  // MARK: - Create

  @override
  Future<Result<LocalDAOModel, LocalDAOError>> create(
    LocalDAOModel data,
  ) async {
    LocalDAOError? daoError;
    final response = await databaseClient.insert(SupabaseTables.locals.name, {
      "name": data.name,
    }).onError((error, _) {
      daoError = LocalDAOError(
        message: "Error creating local from Supabase",
        original: error,
      );
      return {};
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(
      LocalDAOModel.fromJson(response),
    );
  }

  // MARK: - Read

  @override
  Future<Result<List<LocalDAOModel>, LocalDAOError>> getAll() async {
    LocalDAOError? daoError;
    final response = await databaseClient
        .get(SupabaseTables.locals.name)
        .onError((error, _) {
      daoError = LocalDAOError(
        message: "Error fetching locals from Supabase",
        original: error,
      );
      return [];
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    final locals = response
        .map(
          (data) => LocalDAOModel.fromJson(data),
        )
        .toList();

    return Result.ok(locals);
  }

  @override
  Future<Result<LocalDAOModel, LocalDAOError>> getById(String id) async {
    LocalDAOError? daoError;
    final response = await databaseClient
        .getById(SupabaseTables.locals.name, id)
        .onError((error, _) {
      daoError = LocalDAOError(
        message: "Error fetching local from database",
        original: error,
      );
      return {};
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(LocalDAOModel.fromJson(response));
  }

  // MARK: - Update

  @override
  Future<Result<LocalDAOModel, LocalDAOError>> updateById(
    String id,
    LocalDAOModel data,
  ) async {
    LocalDAOError? daoError;
    final response =
        await databaseClient.updateById(SupabaseTables.locals.name, id, {
      "name": data.name,
    }).onError((error, _) {
      daoError = LocalDAOError(
        message: "Error updating local from Supabase",
        original: error,
      );
      return {};
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(
      LocalDAOModel(
        id: response["id"],
        name: response["name"],
        createdAt: DateTime.parse(response["created_at"]),
        updatedAt: DateTime.parse(response["updated_at"]),
      ),
    );
  }

  // MARK: - Delete

  @override
  Future<Result<void, LocalDAOError>> deleteById(String id) async {
    LocalDAOError? daoError;
    await databaseClient
        .deleteById(SupabaseTables.locals.name, id)
        .onError((error, _) {
      daoError = LocalDAOError(
        message: "Error deleting local from Supabase",
        original: error,
      );
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(null);
  }
}
