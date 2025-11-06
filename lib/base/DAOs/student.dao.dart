import "package:ctcl_manager/base/DAOs/errors/student.dao_error.dart";
import "package:ctcl_manager/base/DAOs/models/student.dao_model.dart";
import "package:ctcl_manager/core/database/supabase/supabase_service.dart";
import "package:ctcl_manager/core/variables/result_type.dart";
import "package:uuid/uuid.dart";

final class StudentDAO {
  StudentDAO._internal();

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
}
