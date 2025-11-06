final class StudentDAOModel {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String emailAddress;
  final DateTime birthday;
  final String instagram;
  final DateTime createdAt;
  final DateTime updatedAt;

  StudentDAOModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.emailAddress,
    required this.birthday,
    required this.instagram,
    required this.createdAt,
    required this.updatedAt,
  });
}
