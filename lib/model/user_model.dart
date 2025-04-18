class UserModel {
  final String email;
  String name;
  String phone;
  UserModel({
    required this.email,
    this.name = "",
    this.phone = "",
  });

  factory UserModel.fromMap(Map<String, dynamic> m) {
    return UserModel(
      email: m['email'],
      name: m['name'] ?? "",
      phone: m['phone'] ?? "",
    );
  }
}
