import "package:ctcl_manager/base/DAOs/errors/class.dao_error.dart";
import "package:ctcl_manager/base/DAOs/interface.dao.dart";
import "package:ctcl_manager/base/DAOs/models/class.dao_model.dart";
import "package:ctcl_manager/core/database/interface.database.dart";
import "package:ctcl_manager/core/database/table_name.database.dart";
import "package:ctcl_manager/core/variables/result_type.dart";

final class ClassDAO implements BaseDAO<ClassDAOModel, ClassDAOError> {
  @override
  final IDatabaseClient databaseClient;
  @override
  String get tableName => TableNames.v1.classes;

  const ClassDAO({required this.databaseClient});

  // MARK: - Create

  @override
  Future<Result<ClassDAOModel, ClassDAOError>> create(
    ClassDAOModel data,
  ) async {
    ClassDAOError? daoError;

    final response = await databaseClient.insert(tableName, {
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

    final response = await databaseClient.get(tableName).onError((error, _) {
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

  Future<Result<List<ClassDAOModel>, ClassDAOError>> getAllByName(
    String name,
  ) async {
    ClassDAOError? daoError;

    final response = await databaseClient.get(tableName).onError((error, _) {
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
    final filteredClasses = classes
        .where((data) => data.name.toLowerCase().contains(name.toLowerCase()))
        .toList();

    return Result.ok(filteredClasses);
  }

  @override
  Future<Result<ClassDAOModel, ClassDAOError>> getById(String id) async {
    ClassDAOError? daoError;
    final response =
        await databaseClient.getById(tableName, id).onError((error, _) {
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

    final response = await databaseClient.updateById(tableName, id, {
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
    await databaseClient.deleteById(tableName, id).onError((error, _) {
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
