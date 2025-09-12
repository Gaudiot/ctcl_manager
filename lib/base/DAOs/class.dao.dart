import "package:ctcl_manager/base/DAOs/errors/class.dao_error.dart";
import "package:ctcl_manager/base/DAOs/models/class.dao_model.dart";
import "package:ctcl_manager/core/database/supabase/supabase_service.dart";
import "package:ctcl_manager/core/variables/result_type.dart";
import "package:uuid/uuid.dart";

final class ClassDAO {
  ClassDAO._internal();

  static Future<Result<void, ClassDAOError>> addClass({
    required String name,
    required int valueHundred,
    required String localId,
    String? description,
  }) async {
    final id = Uuid().v4();
    final timestamp = DateTime.now().toIso8601String();

    ClassDAOError? daoError;

    await SupabaseService.client
        .from(SupabaseTables.classes.name)
        .insert({
          "id": id,
          "name": name,
          "description": description,
          "value_hundred": valueHundred,
          "local_id": localId,
          "created_at": timestamp,
          "updated_at": timestamp,
        })
        .onError((error, stackTrace) {
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

  static Future<Result<List<ClassSummaryDAOModel>, ClassDAOError>>
  getClassesSumary() async {
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
  getClassesSumaryByName(String name) async {
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
}
