import "dart:math";

import "package:ctcl_manager/core/database/interface.database.dart";

final class MockDatabaseClient implements IDatabaseClient {
  static final MockDatabaseClient _instance = MockDatabaseClient._internal();

  MockDatabaseClient._internal();

  static MockDatabaseClient get instance => _instance;

  final Map<String, List<DatabaseClientEntity>> _data = {};

  // MARK: - Initialize

  @override
  Future<void> start() async {
    _data.clear();
  }

  // MARK: - Create

  @override
  Future<DatabaseClientEntity> insert(
    String table,
    dynamic data,
  ) async {
    String key;
    do {
      key = "${table}_${Random().nextInt(1000000)}";
    } while (_data.containsKey(key));

    final timestamp = DateTime.now().toIso8601String();
    data["id"] = key;
    data["created_at"] = timestamp;
    data["updated_at"] = timestamp;

    _data[table] = [...(_data[table] ?? []), data];

    return data;
  }

  // MARK: - Read

  @override
  Future<List<DatabaseClientEntity>> get(
    String table, {
    int limit = 100,
    int offset = 0,
  }) async {
    final tableData = _data[table] ?? [];
    final data = tableData.skip(offset * limit).take(limit).toList();
    return data;
  }

  @override
  Future<DatabaseClientEntity> getById(String table, String id) async {
    final tableData = _data[table] ?? [];
    final data = tableData.firstWhere((element) => element["id"] == id);
    return data;
  }

  // MARK: - Update

  @override
  Future<Map<String, dynamic>> updateById(
    String table,
    String id,
    Map<String, dynamic> data,
  ) async {
    final tableData = _data[table] ?? [];
    final currentData = tableData.firstWhere(
      (element) => element["id"] == id,
      orElse: () => DatabaseClientEntity(),
    );

    if (data.isEmpty) {
      return {};
    }

    data.forEach((key, value) {
      currentData[key] = value;
    });
    currentData["updated_at"] = DateTime.now().toIso8601String();

    return currentData;
  }

  // MARK: - Delete

  @override
  Future<void> deleteById(String table, String id) async {
    final tableData = _data[table] ?? [];
    final dataIndex = tableData.indexWhere((element) => element["id"] == id);

    if (dataIndex == -1) {
      return;
    }

    tableData.removeAt(dataIndex);
    _data[table] = tableData;
  }
}
