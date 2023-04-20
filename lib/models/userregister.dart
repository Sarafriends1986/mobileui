import 'dart:convert';

UserRegister userRegisterFromJson(String str) => UserRegister.fromJson(json.decode(str));

String userRegisterToJson(UserRegister data) => json.encode(data.toJson());

class UserRegister {
  UserRegister({
    required this.myresult,
  });

  String myresult;

  factory UserRegister.fromJson(Map<String, dynamic> json) => UserRegister(
    myresult: json["myresult"],
  );

  Map<String, dynamic> toJson() => {
    "myresult": myresult,
  };
}