import "package:ctcl_manager/base/DAOs/errors/class.dao_error.dart";
import "package:ctcl_manager/base/DAOs/interface.dao.dart";
import "package:ctcl_manager/base/DAOs/models/class.dao_model.dart";
import "package:ctcl_manager/core/database/supabase/supabase_service.dart";
import "package:ctcl_manager/core/variables/result_type.dart";
import "package:supabase_flutter/supabase_flutter.dart";
import "package:uuid/uuid.dart";

final class ClassDAO implements BaseDAO<ClassDAOModel, ClassDAOError> {
  @override
  final SupabaseClient databaseClient;

  const ClassDAO(this.databaseClient);

  // MARK: - Create

  static Future<Result<void, ClassDAOError>> addClass({
    required String name,
    required int valueHundred,
    required String localId,
    String? description,
  }) async {
    final id = Uuid().v4();
    final timestamp = DateTime.now().toIso8601String();

    ClassDAOError? daoError;

    await SupabaseService.client.from(SupabaseTables.classes.name).insert({
      "id": id,
      "name": name,
      "description": description,
      "value_hundred": valueHundred,
      "local_id": localId,
      "created_at": timestamp,
      "updated_at": timestamp,
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
      ClassDAOModel(
        id: response[0]["id"],
        name: response[0]["name"],
        description: response[0]["description"],
        valueHundred: response[0]["value_hundred"],
        localId: response[0]["local_id"],
        localName: response[0]["local"]["name"],
      ),
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

    final response =
        await databaseClient.from(SupabaseTables.classes.name).insert({
      "name": data.name,
      "description": data.description,
      "value_hundred": data.valueHundred,
      "local_id": data.localId,
    }).onError((error, stackTrace) {
      daoError = ClassDAOError(
        message: "Error creating class in Supabase",
        original: error,
      );
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(
      ClassDAOModel(
        id: response[0]["id"],
        name: response[0]["name"],
        description: response[0]["description"],
        valueHundred: response[0]["value_hundred"],
        localId: response[0]["local_id"],
        localName: response[0]["local"]["name"],
      ),
    );
  }

  // MARK: - Read

  @override
  Future<Result<ClassDAOModel, ClassDAOError>> getById(String id) async {
    ClassDAOError? daoError;
    final response = await databaseClient
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
      ClassDAOModel(
        id: response[0]["id"],
        name: response[0]["name"],
        description: response[0]["description"],
        valueHundred: response[0]["value_hundred"],
        localId: response[0]["local_id"],
        localName: response[0]["local"]["name"],
      ),
    );
  }

  // MARK: - Update

  @override
  Future<Result<ClassDAOModel, ClassDAOError>> updateById(
      String id, ClassDAOModel data) async {
    ClassDAOError? daoError;

    final response = await databaseClient
        .from(SupabaseTables.classes.name)
        .update({
          "name": data.name,
          "description": data.description,
          "value_hundred": data.valueHundred,
          "local_id": data.localId,
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

    return Result.ok(
      ClassDAOModel(
        id: response[0]["id"],
        name: response[0]["name"],
        description: response[0]["description"],
        valueHundred: response[0]["value_hundred"],
        localId: response[0]["local_id"],
        localName: response[0]["local"]["name"],
      ),
    );
  }

  // MARK: - Delete

  @override
  Future<Result<void, ClassDAOError>> deleteById(String id) async {
    ClassDAOError? daoError;
    await databaseClient
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
}
