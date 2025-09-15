import "package:ctcl_manager/base/DAOs/class.dao.dart";

final class ClassDetailsViewModel {
  // MARK: - Fetch Data

  Future<void> getClassById(String id) async {
    final classResult = await ClassDAO.getClassById(id);

    classResult.when(onOk: (classData) {});
  }

  // MARK: - Data

  Future<void> deleteClass(String classId) async {
    final response = await ClassDAO.delete(classId);
    response.when(onError: (error) {});
  }

  Future<void> updateClass({
    required String classId,
    required String name,
    required String description,
    required int valueHundred,
    required String localId,
  }) async {
    final response = await ClassDAO.update(
      classId,
      name,
      description,
      valueHundred,
      localId,
    );
    response.when(onError: (error) {});
  }
}
