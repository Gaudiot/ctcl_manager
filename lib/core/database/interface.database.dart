typedef DatabaseClientEntity = Map<String, dynamic>;

abstract interface class IDatabaseClient {
  Future<void> start();
  Future<List<DatabaseClientEntity>> get(
    String table, {
    int limit = 100,
    int offset = 0,
  });
  Future<DatabaseClientEntity> insert(String table, DatabaseClientEntity data);
  Future<DatabaseClientEntity> updateById(
    String table,
    String id,
    DatabaseClientEntity data,
  );
  Future<DatabaseClientEntity> getById(String table, String id);
  Future<void> deleteById(String table, String id);
}
