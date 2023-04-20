import 'dart:convert';

PasswordResetApi passwordResetApiFromJson(String str) => PasswordResetApi.fromJson(json.decode(str));

String passwordResetApiToJson(PasswordResetApi data) => json.encode(data.toJson());

class PasswordResetApi {
  PasswordResetApi({
    required this.myresult,
  });

  String myresult;

  factory PasswordResetApi.fromJson(Map<String, dynamic> json) => PasswordResetApi(
    myresult: json["myresult"],
  );

  Map<String, dynamic> toJson() => {
    "myresult": myresult,
  };
}