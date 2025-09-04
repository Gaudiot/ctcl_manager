import "package:ctcl_manager/core/database/supabase/supabase_service.dart";
import "package:flutter/widgets.dart";
import "package:uuid/uuid.dart";

final class LocalModel {
  final String id;
  final String name;

  LocalModel({required this.id, required this.name});
}

final class LocalDAO {
  Future<void> addLocal(String name) async {
    final id = Uuid().v4();
    final timestamp = DateTime.now().toIso8601String();

    debugPrint("Adding local to supabase: $name");

    final response = await SupabaseService.client
        .from(SupabaseTables.locals.name)
        .insert({
          "id": id,
          "name": name,
          "created_at": timestamp,
          "updated_at": timestamp,
        })
        .select()
        .onError((error, stackTrace) {
          debugPrint("Erro ao adicionar local no Supabase:");
          debugPrint("Erro: $error");
          debugPrint("Stack trace: $stackTrace");
          return [];
        });

    debugPrint("Local adicionado com sucesso: $response");
  }

  Future<List<LocalModel>> getLocals() async {
    final response = await SupabaseService.client
        .from(SupabaseTables.locals.name)
        .select("id, name")
        .onError((error, stackTrace) {
          debugPrint("Erro ao buscar locais no Supabase:");
          debugPrint("Erro: $error");
          debugPrint("Stack trace: $stackTrace");
          return [];
        });

    final locals = response
        .map((e) => LocalModel(id: e["id"], name: e["name"]))
        .toList();

    return locals;
  }
}
