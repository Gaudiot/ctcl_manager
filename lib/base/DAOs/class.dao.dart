import "package:ctcl_manager/base/DAOs/errors/class.dao_error.dart";
import "package:ctcl_manager/base/DAOs/interface.dao.dart";
import "package:ctcl_manager/base/DAOs/models/class.dao_model.dart";
import "package:ctcl_manager/core/database/interface.database.dart";
import "package:ctcl_manager/core/database/supabase/supabase_service.dart";
import "package:ctcl_manager/core/variables/result_type.dart";

final class ClassDAO implements BaseDAO<ClassDAOModel, ClassDAOError> {
  @override
  final IDatabaseClient databaseClient;

  const ClassDAO(this.databaseClient);

  // MARK: - Create

  static Future<Result<void, ClassDAOError>> addClass({
    required String name,
    required int valueHundred,
    required String localId,
    String? description,
  }) async {
    ClassDAOError? daoError;

    await SupabaseService.client.from(SupabaseTables.classes.name).insert({
      "name": name,
      "description": description,
      "value_hundred": valueHundred,
      "local_id": localId,
    }).onError((error, stackTrace) {
      daoError = ClassDAOError(
        message: "Error creating class in Supabase",
        original: error,
      );
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(null);
  }

  // MARK: - Read

  static Future<Result<List<ClassSummaryDAOModel>, ClassDAOError>>
      getClassesSummary() async {
    ClassDAOError? daoError;
    final response = await SupabaseService.client
        .from(SupabaseTables.classes.name)
        .select("id, name, local:locals(name), students:students(count)")
        .onError((error, _) {
      daoError = ClassDAOError(
        message: "Error fetching classes from Supabase",
        original: error,
      );
      return [];
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    final classes = response
        .map(
          (e) => ClassSummaryDAOModel(
            id: e["id"],
            name: e["name"],
            localName: e["local"]["name"],
            studentsQuantity: e["students"][0]["count"],
          ),
        )
        .toList();

    return Result.ok(classes);
  }

  static Future<Result<List<ClassSummaryDAOModel>, ClassDAOError>>
      getClassesSummaryByName(String name) async {
    ClassDAOError? daoError;
    final response = await SupabaseService.client
        .from(SupabaseTables.classes.name)
        .select("id, name, local:locals(name), students:students(count)")
        .ilike("name", "%$name%")
        .onError((error, _) {
      daoError = ClassDAOError(
        message: "Error fetching classes by name $name from Supabase",
        original: error,
      );
      return [];
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    final classes = response
        .map(
          (e) => ClassSummaryDAOModel(
            id: e["id"],
            name: e["name"],
            localName: e["local"]["name"],
            studentsQuantity: e["students"][0]["count"],
          ),
        )
        .toList();

    return Result.ok(classes);
  }

  static Future<Result<ClassDAOModel, ClassDAOError>> getClassById(
    String id,
  ) async {
    ClassDAOError? daoError;
    final response = await SupabaseService.client
        .from(SupabaseTables.classes.name)
        .select(
          "id, name, description, value_hundred, local_id, local:locals(name)",
        )
        .eq("id", id)
        .onError((error, _) {
      daoError = ClassDAOError(
        message: "Error fetching class from Supabase",
        original: error,
      );
      return [];
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(
      ClassDAOModel.fromJson(response[0]),
    );
  }

  // MARK: - Update

  static Future<Result<void, ClassDAOError>> update(
    String id,
    String name,
    String description,
    int valueHundred,
    String localId,
  ) async {
    ClassDAOError? daoError;

    await SupabaseService.client
        .from(SupabaseTables.classes.name)
        .update({
          "name": name,
          "description": description,
          "value_hundred": valueHundred,
          "local_id": localId,
        })
        .eq("id", id)
        .onError((error, _) {
          daoError = ClassDAOError(
            message: "Error updating class from Supabase",
            original: error,
          );
        });

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(null);
  }

  // MARK: - Delete

  static Future<Result<void, ClassDAOError>> delete(String id) async {
    ClassDAOError? daoError;
    await SupabaseService.client
        .from(SupabaseTables.classes.name)
        .delete()
        .eq("id", id)
        .onError((error, _) {
      daoError = ClassDAOError(
        message: "Error deleting class from Supabase",
        original: error,
      );
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(null);
  }

  // MARK: - Create

  @override
  Future<Result<ClassDAOModel, ClassDAOError>> create(
    ClassDAOModel data,
  ) async {
    ClassDAOError? daoError;

    final response = await databaseClient.insert(SupabaseTables.classes.name, {
      "name": data.name,
      "description": data.description,
      "value_hundred": data.valueHundred,
      "local_id": data.localId,
    }).onError((error, stackTrace) {
      daoError = ClassDAOError(
        message: "Error creating class in Supabase",
        original: error,
      );

      return {};
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(
      ClassDAOModel.fromJson(response),
    );
  }

  // MARK: - Read

  @override
  Future<Result<List<ClassDAOModel>, ClassDAOError>> getAll() async {
    ClassDAOError? daoError;
    final response = await databaseClient
        .get(SupabaseTables.classes.name)
        .onError((error, _) {
      daoError = ClassDAOError(
        message: "Error fetching classes from Supabase",
        original: error,
      );
      return [];
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    final classes =
        response.map((data) => ClassDAOModel.fromJson(data)).toList();

    return Result.ok(classes);
  }

  @override
  Future<Result<ClassDAOModel, ClassDAOError>> getById(String id) async {
    ClassDAOError? daoError;
    final response = await databaseClient
        .getById(SupabaseTables.classes.name, id)
        .onError((error, _) {
      daoError = ClassDAOError(
        message: "Error fetching class from Supabase",
        original: error,
      );
      return {};
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(
      ClassDAOModel.fromJson(response),
    );
  }

  // MARK: - Update

  @override
  Future<Result<ClassDAOModel, ClassDAOError>> updateById(
    String id,
    ClassDAOModel data,
  ) async {
    ClassDAOError? daoError;

    final response =
        await databaseClient.updateById(SupabaseTables.classes.name, id, {
      "name": data.name,
      "description": data.description,
      "value_hundred": data.valueHundred,
      "local_id": data.localId,
    }).onError((error, _) {
      daoError = ClassDAOError(
        message: "Error updating class from Supabase",
        original: error,
      );

      return {};
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(
      ClassDAOModel.fromJson(response),
    );
  }

  // MARK: - Delete

  @override
  Future<Result<void, ClassDAOError>> deleteById(String id) async {
    ClassDAOError? daoError;
    await databaseClient
        .deleteById(SupabaseTables.classes.name, id)
        .onError((error, _) {
      daoError = ClassDAOError(
        message: "Error deleting class from Supabase",
        original: error,
      );
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(null);
  }
}
