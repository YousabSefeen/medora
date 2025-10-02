class CreateUserModel {
  final String? id;
  final String name;
  final String email;
  final String phone;

  CreateUserModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory CreateUserModel.fromJson(Map<String, dynamic> json) {
    return CreateUserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
    };
  }
}
