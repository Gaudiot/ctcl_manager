import "package:ctcl_manager/base/DAOs/errors/student.dao_error.dart";
import "package:ctcl_manager/base/DAOs/interface.dao.dart";
import "package:ctcl_manager/base/DAOs/models/student.dao_model.dart";
import "package:ctcl_manager/core/database/interface.database.dart";
import "package:ctcl_manager/core/database/table_name.database.dart";
import "package:ctcl_manager/core/variables/result_type.dart";

final class StudentDAO implements BaseDAO<StudentDAOModel, StudentDAOError> {
  @override
  final IDatabaseClient databaseClient;
  @override
  String get tableName => TableNames.v1.students;

  const StudentDAO({required this.databaseClient});

  // MARK: - Create

  @override
  Future<Result<StudentDAOModel, StudentDAOError>> create(
    StudentDAOModel data,
  ) async {
    StudentDAOError? daoError;
    final response = await databaseClient.insert(tableName, {
      "first_name": data.firstName,
      "last_name": data.lastName,
      "phone": data.phone,
      "email_address": data.emailAddress,
      "birthday": data.birthday,
      "instagram": data.instagram,
    }).onError((error, stackTrace) {
      daoError = StudentDAOError(
        message: "Error creating student from Supabase",
        original: error,
      );

      return {};
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(
      StudentDAOModel(
        id: response["id"],
        firstName: response["first_name"],
        lastName: response["last_name"],
        phone: response["phone"],
        emailAddress: response["email_address"],
        birthday: DateTime.parse(response["birthday"]),
        instagram: response["instagram"],
        createdAt: DateTime.parse(response["created_at"]),
        updatedAt: DateTime.parse(response["updated_at"]),
      ),
    );
  }

  // MARK: - Read

  @override
  Future<Result<List<StudentDAOModel>, StudentDAOError>> getAll() async {
    StudentDAOError? daoError;
    final response = await databaseClient.get(tableName).onError((error, _) {
      daoError = StudentDAOError(
        message: "Error fetching students from Supabase",
        original: error,
      );
      return [];
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    final students = response
        .map(
          (data) => StudentDAOModel.fromJson(data),
        )
        .toList();
    return Result.ok(students);
  }

  @override
  Future<Result<StudentDAOModel, StudentDAOError>> getById(String id) async {
    StudentDAOError? daoError;
    final response = await databaseClient.getById(tableName, id).onError(
      (error, stackTrace) {
        daoError = StudentDAOError(
          message: "Error fetching student from Supabase",
          original: error,
        );

        return {};
      },
    );

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(
      StudentDAOModel.fromJson(response),
    );
  }

  Future<Result<List<StudentDAOModel>, StudentDAOError>> getByName(
    String name,
  ) async {
    StudentDAOError? daoError;

    final response = await databaseClient.get(tableName).onError((error, _) {
      daoError = StudentDAOError(
        message: "Error fetching students from Supabase",
        original: error,
      );
      return [];
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    final students =
        response.map((data) => StudentDAOModel.fromJson(data)).toList();
    final filteredStudents = students
        .where(
          (data) => "${data.firstName} ${data.lastName}"
              .toLowerCase()
              .contains(name.toLowerCase()),
        )
        .toList();

    return Result.ok(filteredStudents);
  }

  // MARK: - Update

  @override
  Future<Result<StudentDAOModel, StudentDAOError>> updateById(
    String id,
    StudentDAOModel data,
  ) async {
    StudentDAOError? daoError;
    final response = await databaseClient.updateById(tableName, id, {
      "first_name": data.firstName,
      "last_name": data.lastName,
      "phone": data.phone,
      "email_address": data.emailAddress,
      "birthday": data.birthday,
      "instagram": data.instagram,
      "updated_at": DateTime.now().toIso8601String(),
    }).onError((error, stackTrace) {
      daoError = StudentDAOError(
        message: "Error updating student from Supabase",
        original: error,
      );
      return {};
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(
      StudentDAOModel(
        id: response["id"],
        firstName: response["first_name"],
        lastName: response["last_name"],
        phone: response["phone"],
        emailAddress: response["email_address"],
        birthday: DateTime.parse(response["birthday"]),
        instagram: response["instagram"],
        createdAt: DateTime.parse(response["created_at"]),
        updatedAt: DateTime.parse(response["updated_at"]),
      ),
    );
  }

  // MARK: - Delete

  @override
  Future<Result<void, StudentDAOError>> deleteById(String id) async {
    StudentDAOError? daoError;
    await databaseClient.deleteById(tableName, id).onError(
      (error, stackTrace) {
        daoError = StudentDAOError(
          message: "Error deleting student from Supabase",
          original: error,
        );
      },
    );

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(null);
  }
}
