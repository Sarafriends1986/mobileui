// To parse this JSON data, do
//
//     final userLogin = userLoginFromJson(jsonString);

import 'dart:convert';

UserLogin userLoginFromJson(String str) => UserLogin.fromJson(json.decode(str));

String userLoginToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin {
  UserLogin({
    required this.myresult,
    required this.username,
    required this.email,
    required this.gender,
    required this.accessToken,
    required this.items,
  });

  String myresult;
  String username;
  String email;
  String gender;
  String accessToken;
  List<Item> items;

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
    myresult: json["myresult"],
    username: json["username"],
    email: json["email"],
    gender: json["gender"],
    accessToken: json["accessToken"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "myresult": myresult,
    "username": username,
    "email": email,
    "gender": gender,
    "accessToken": accessToken,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    required this.itemId,
    required this.itemname,
    required this.itemtype,
    required this.mcat,
    required this.scat,
    required this.description,
    required this.imagepath,
    required this.donorname,
    required this.recievername,
    required this.itemaddress,
    required this.itemlocation,
    required this.itemphone,
    required this.alluser,
    required this.adminapproval,
  });

  int itemId;
  String itemname;
  String itemtype;
  String mcat;
  String scat;
  String description;
  String imagepath;
  String donorname;
  String recievername;
  String itemaddress;
  String itemlocation;
  String itemphone;
  String alluser;
  String adminapproval;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    itemId: json["item_id"],
    itemname: json["itemname"],
    itemtype: json["itemtype"],
    mcat: json["mcat"],
    scat: json["scat"],
    description: json["description"],
    imagepath: json["imagepath"],
    donorname: json["donorname"],
    recievername: json["recievername"],
    itemaddress: json["itemaddress"],
    itemlocation: json["itemlocation"],
    itemphone: json["itemphone"],
    alluser: json["alluser"],
    adminapproval: json["adminapproval"],
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId,
    "itemname": itemname,
    "itemtype": itemtype,
    "mcat": mcat,
    "scat": scat,
    "description": description,
    "imagepath": imagepath,
    "donorname": donorname,
    "recievername": recievername,
    "itemaddress": itemaddress,
    "itemlocation": itemlocation,
    "itemphone": itemphone,
    "alluser": alluser,
    "adminapproval": adminapproval,
  };
}
