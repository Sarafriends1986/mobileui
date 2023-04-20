// To parse this JSON data, do
//
//     final itemPost = itemPostFromJson(jsonString);

import 'dart:convert';

ItemPost itemPostFromJson(String str) => ItemPost.fromJson(json.decode(str));

String itemPostToJson(ItemPost data) => json.encode(data.toJson());

class ItemPost {
  ItemPost({
    required this.myresult,
    required this.itemname,
  });

  String myresult;
  String itemname;

  factory ItemPost.fromJson(Map<String, dynamic> json) => ItemPost(
    myresult: json["myresult"],
    itemname: json["itemname"],
  );

  Map<String, dynamic> toJson() => {
    "myresult": myresult,
    "itemname": itemname,
  };
}
