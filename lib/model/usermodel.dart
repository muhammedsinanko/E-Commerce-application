class UserModel {
  String name;
  String phone;
  String address;
  String username;

  UserModel({
    required this.name,
    required this.phone,
    required this.address,
    required this.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "address": address,
        "username": username,
      };
}
