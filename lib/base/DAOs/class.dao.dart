import "package:ctcl_manager/core/database/supabase/supabase_service.dart";
import "package:flutter/material.dart";
import "package:uuid/uuid.dart";

final class ClassSumaryModel {
  final String id;
  final String name;
  final String localName;
  final int studentsQuantity;

  ClassSumaryModel({
    required this.id,
    required this.name,
    required this.localName,
    required this.studentsQuantity,
  });
}

final class ClassDAO {
  ClassDAO._internal();

  static Future<void> addClass({
    required String name,
    required int valueHundred,
    required String localId,
    String? description,
  }) async {
    final id = Uuid().v4();
    final timestamp = DateTime.now().toIso8601String();

    SupabaseService.client
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
          debugPrint("Erro ao criar turma no Supabase:");
          debugPrint("Erro: $error");
          debugPrint("Stack trace: $stackTrace");
        });
  }

  static Future<List<ClassSumaryModel>> getClassesSumary() async {
    final response = await SupabaseService.client
        .from(SupabaseTables.classes.name)
        .select("id, name, local:locals(name), students:students(count)")
        .onError((error, stackTrace) {
          debugPrint("Erro ao buscar locais no Supabase:");
          debugPrint("Erro: $error");
          debugPrint("Stack trace: $stackTrace");
          return [];
        });

    final classes = response
        .map(
          (e) => ClassSumaryModel(
            id: e["id"],
            name: e["name"],
            localName: e["local"]["name"],
            studentsQuantity: e["students"][0]["count"],
          ),
        )
        .toList();

    return classes;
  }
}
