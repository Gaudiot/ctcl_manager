final class StudentDAOModel {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String? emailAddress;
  final DateTime? birthday;
  final String? instagram;
  final String? classId;
  final DateTime createdAt;
  final DateTime updatedAt;

  StudentDAOModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    this.emailAddress,
    this.birthday,
    this.instagram,
    this.classId,
  });

  factory StudentDAOModel.fromJson(Map<String, dynamic> json) {
    return StudentDAOModel(
      id: json["id"] as String,
      firstName: json["first_name"] as String,
      lastName: json["last_name"] as String,
      phone: json["phone"] as String,
      emailAddress: json["email_address"] as String?,
      birthday: json.containsKey("birthday")
          ? DateTime.parse(json["birthday"] as String)
          : null,
      instagram: json["instagram"] as String?,
      classId: json["class_id"] as String?,
      createdAt: DateTime.parse(json["created_at"] as String),
      updatedAt: DateTime.parse(json["updated_at"] as String),
    );
  }
}
