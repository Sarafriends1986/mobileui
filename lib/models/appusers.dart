import 'dart:convert';

List<Appusers> appusersFromJson(String str) => List<Appusers>.from(json.decode(str).map((x) => Appusers.fromJson(x)));

String appusersToJson(List<Appusers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Appusers {
  Appusers({
    required this.userId,
    required this.userName,
    required this.email,
    required this.password,
  });

  int userId;
  String userName;
  String email;
  String password;

  factory Appusers.fromJson(Map<String, dynamic> json) => Appusers(
    userId: json["userId"],
    userName: json["userName"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "userName": userName,
    "email": email,
    "password": password,
  };
}
