// To parse this JSON data, do
//
//     final notifyItem = notifyItemFromJson(jsonString);

import 'dart:convert';

NotifyItem notifyItemFromJson(String str) => NotifyItem.fromJson(json.decode(str));

String notifyItemToJson(NotifyItem data) => json.encode(data.toJson());

class NotifyItem {
  NotifyItem({
    required this.myresult,
    required this.notificationsItem,
  });

  String myresult;
  List<NotificationsItem> notificationsItem;

  factory NotifyItem.fromJson(Map<String, dynamic> json) => NotifyItem(
    myresult: json["myresult"],
    notificationsItem: List<NotificationsItem>.from(json["notificationsItem"].map((x) => NotificationsItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "myresult": myresult,
    "notificationsItem": List<dynamic>.from(notificationsItem.map((x) => x.toJson())),
  };
}

class NotificationsItem {
  NotificationsItem({
    required this.notifyId,
    required this.donorname,
    required this.recievername,
    required this.itemname,
    required this.imagepath,
    required this.adminapproval,
    required this.status,
  });

  int notifyId;
  String donorname;
  String recievername;
  String itemname;
  String imagepath;
  String adminapproval;
  String status;

  factory NotificationsItem.fromJson(Map<String, dynamic> json) => NotificationsItem(
    notifyId: json["notify_id"],
    donorname: json["donorname"],
    recievername: json["recievername"],
    itemname: json["itemname"],
    imagepath: json["imagepath"],
    adminapproval: json["adminapproval"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "notify_id": notifyId,
    "donorname": donorname,
    "recievername": recievername,
    "itemname": itemname,
    "imagepath": imagepath,
    "adminapproval": adminapproval,
    "status": status,
  };
}
