import "package:ctcl_manager/base/DAOs/errors/local.dao_error.dart";
import "package:ctcl_manager/base/DAOs/models/local.dao_model.dart";
import "package:ctcl_manager/core/database/supabase/supabase_service.dart";
import "package:ctcl_manager/core/variables/result_type.dart";
import "package:uuid/uuid.dart";

final class LocalDAO {
  LocalDAO._internal();

  static Future<Result<LocalSummaryDAOModel, LocalDAOError>> addLocal(
    String name,
  ) async {
    final id = Uuid().v4();
    final timestamp = DateTime.now().toIso8601String();

    LocalDAOError? daoError;

    await SupabaseService.client
        .from(SupabaseTables.locals.name)
        .insert({
          "id": id,
          "name": name,
          "created_at": timestamp,
          "updated_at": timestamp,
        })
        .onError((error, stackTrace) {
          daoError = LocalDAOError(
            message: "Error creating local in Supabase",
            original: error,
          );
        });

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(LocalSummaryDAOModel(id: id, name: name));
  }

  static Future<Result<List<LocalSummaryDAOModel>, LocalDAOError>>
  getLocals() async {
    LocalDAOError? daoError;

    final response = await SupabaseService.client
        .from(SupabaseTables.locals.name)
        .select("id, name")
        .onError((error, stackTrace) {
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
          (local) => LocalSummaryDAOModel(id: local["id"], name: local["name"]),
        )
        .toList();

    return Result.ok(locals);
  }
}
