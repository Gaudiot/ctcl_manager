import "package:ctcl_manager/base/DAOs/errors/student.dao_error.dart";
import "package:ctcl_manager/base/DAOs/interface.dao.dart";
import "package:ctcl_manager/base/DAOs/models/student.dao_model.dart";
import "package:ctcl_manager/core/database/supabase/supabase_service.dart";
import "package:ctcl_manager/core/variables/result_type.dart";
import "package:supabase_flutter/supabase_flutter.dart";
import "package:uuid/uuid.dart";

final class StudentDAO implements BaseDAO<StudentDAOModel, StudentDAOError> {
  @override
  final SupabaseClient databaseClient;

  const StudentDAO(this.databaseClient);

  // MARK: - Create

  static Future<Result<StudentDAOModel, StudentDAOError>> addStudent({
    required String firstName,
    required String lastName,
    required String phone,
    required String emailAddress,
    required DateTime birthday,
    required String instagram,
  }) async {
    final id = Uuid().v4();
    final timestamp = DateTime.now().toIso8601String();

    StudentDAOError? daoError;

    await SupabaseService.client.from(SupabaseTables.students.name).insert({
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
      "email_address": emailAddress,
      "birthday": birthday,
      "instagram": instagram,
      "created_at": timestamp,
      "updated_at": timestamp,
    }).onError((error, stackTrace) {
      daoError = StudentDAOError(
        message: "Error creating student in Supabase",
        original: error,
      );
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(
      StudentDAOModel(
        id: id,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        emailAddress: emailAddress,
        birthday: birthday,
        instagram: instagram,
        createdAt: DateTime.parse(timestamp),
        updatedAt: DateTime.parse(timestamp),
      ),
    );
  }

  // MARK: - Read

  static Future<Result<StudentDAOModel, StudentDAOError>> getStudentById(
      String id) async {
    StudentDAOError? daoError;

    final response = await SupabaseService.client
        .from(SupabaseTables.locals.name)
        .select("id, name")
        .eq("id", id)
        .onError(
      (error, _) {
        daoError = StudentDAOError(
          message: "Error fetching student from Supabase",
          original: error,
        );
        return [];
      },
    );

    if (daoError != null) {
      return Result.error(daoError);
    }

    if (response.isEmpty) {
      return Result.ok(null);
    }

    final studentData = response[0];
    final student = StudentDAOModel(
      id: studentData["id"],
      firstName: studentData["first_name"],
      lastName: studentData["last_name"],
      phone: studentData["phone"],
      emailAddress: studentData["email_address"],
      birthday: DateTime.parse(studentData["birthday"]),
      instagram: studentData["instagram"],
      createdAt: DateTime.parse(studentData["created_at"]),
      updatedAt: DateTime.parse(studentData["updated_at"]),
    );

    return Result.ok(student);
  }

  // MARK: - Update

  static Future<Result<void, StudentDAOError>> updateStudent({
    required String id,
    required String firstName,
    required String lastName,
    required String phone,
    required String emailAddress,
    required DateTime birthday,
    required String instagram,
  }) async {
    StudentDAOError? daoError;
    final timestamp = DateTime.now().toIso8601String();

    await SupabaseService.client
        .from(SupabaseTables.students.name)
        .update({
          "first_name": firstName,
          "last_name": lastName,
          "phone": phone,
          "email_address": emailAddress,
          "birthday": birthday,
          "instagram": instagram,
          "updated_at": timestamp,
        })
        .eq("id", id)
        .onError((error, stackTrace) {
          daoError = StudentDAOError(
            message: "Error updating student from Supabase",
            original: error,
          );
        });

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(null);
  }

  // MARK: - Delete

  static Future<Result<void, StudentDAOError>> deleteStudentById(
      String id) async {
    StudentDAOError? daoError;

    await SupabaseService.client
        .from(SupabaseTables.students.name)
        .delete()
        .eq("id", id)
        .onError((error, stackTrace) {
      daoError = StudentDAOError(
        message: "Error deleting student from Supabase",
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
  Future<Result<StudentDAOModel, StudentDAOError>> create(
    StudentDAOModel data,
  ) async {
    StudentDAOError? daoError;
    final response =
        await databaseClient.from(SupabaseTables.students.name).insert({
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
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(
      StudentDAOModel(
        id: response[0]["id"],
        firstName: response[0]["first_name"],
        lastName: response[0]["last_name"],
        phone: response[0]["phone"],
        emailAddress: response[0]["email_address"],
        birthday: DateTime.parse(response[0]["birthday"]),
        instagram: response[0]["instagram"],
        createdAt: DateTime.parse(response[0]["created_at"]),
        updatedAt: DateTime.parse(response[0]["updated_at"]),
      ),
    );
  }

  // MARK: - Read

  @override
  Future<Result<StudentDAOModel, StudentDAOError>> getById(String id) async {
    StudentDAOError? daoError;
    final response = await databaseClient
        .from(SupabaseTables.students.name)
        .select(
          "id, first_name, last_name, phone, email_address, birthday, instagram, created_at, updated_at",
        )
        .eq("id", id)
        .onError((error, stackTrace) {
      daoError = StudentDAOError(
        message: "Error fetching student from Supabase",
        original: error,
      );
      return [];
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(
      StudentDAOModel(
        id: response[0]["id"],
        firstName: response[0]["first_name"],
        lastName: response[0]["last_name"],
        phone: response[0]["phone"],
        emailAddress: response[0]["email_address"],
        birthday: DateTime.parse(response[0]["birthday"]),
        instagram: response[0]["instagram"],
        createdAt: DateTime.parse(response[0]["created_at"]),
        updatedAt: DateTime.parse(response[0]["updated_at"]),
      ),
    );
  }

  // MARK: - Update

  @override
  Future<Result<StudentDAOModel, StudentDAOError>> updateById(
    String id,
    StudentDAOModel data,
  ) async {
    StudentDAOError? daoError;
    final response = await databaseClient
        .from(SupabaseTables.students.name)
        .update({
          "first_name": data.firstName,
          "last_name": data.lastName,
          "phone": data.phone,
          "email_address": data.emailAddress,
          "birthday": data.birthday,
          "instagram": data.instagram,
          "updated_at": DateTime.now().toIso8601String(),
        })
        .eq("id", id)
        .onError((error, stackTrace) {
          daoError = StudentDAOError(
            message: "Error updating student from Supabase",
            original: error,
          );
          return [];
        });

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(
      StudentDAOModel(
        id: response[0]["id"],
        firstName: response[0]["first_name"],
        lastName: response[0]["last_name"],
        phone: response[0]["phone"],
        emailAddress: response[0]["email_address"],
        birthday: DateTime.parse(response[0]["birthday"]),
        instagram: response[0]["instagram"],
        createdAt: DateTime.parse(response[0]["created_at"]),
        updatedAt: DateTime.parse(response[0]["updated_at"]),
      ),
    );
  }

  // MARK: - Delete

  @override
  Future<Result<void, StudentDAOError>> deleteById(String id) async {
    StudentDAOError? daoError;
    await databaseClient
        .from(SupabaseTables.students.name)
        .delete()
        .eq("id", id)
        .onError((error, stackTrace) {
      daoError = StudentDAOError(
        message: "Error deleting student from Supabase",
        original: error,
      );
    });

    if (daoError != null) {
      return Result.error(daoError);
    }

    return Result.ok(null);
  }
}
