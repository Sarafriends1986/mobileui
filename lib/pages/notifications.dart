import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileui/config.dart';
import 'package:mobileui/models/NotifyItem.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:http/http.dart' as http;

class Notifications extends StatefulWidget {
  String username;
  String email;
  String  gender;
  String accessToken;
  List <NotificationsItem> allNotifyItem;

  Notifications({ required this.username,required this.email,required this.gender,
    required this.accessToken,required this.allNotifyItem});

  @override
  State<Notifications> createState() => _NotificationsState(username:username,email:email,gender:gender,
      accessToken:accessToken,allNotifyItem:allNotifyItem);
}

class _NotificationsState extends State<Notifications> {
  String username;
  String email;
  String  gender;
  String accessToken;
  List <NotificationsItem> allNotifyItem;

  List <NotificationsItem> localNotifyItem = [];
  _NotificationsState({ required this.username,required this.email,required this.gender,
    required this.accessToken,required this.allNotifyItem});

  List items = [
    {
      "item_id": 17,
      "itemname": "Shirt",
      "itemtype": "Requesting",
      "mcat": "HomeUtils",
      "scat": "Shirt",
      "description": "Shirt for men",
      "imagepath": "assets/images/cookiemint.jpg",
      "donorname": "NA",
      "recievername": "sara333",
      "itemaddress": "Rivervale Crescent rumbia lrt",
      "itemlocation": "rumbia",
      "itemphone": "9111111",
      "alluser": "sara111,sara123,sara222",
      "adminapproval": "Rejected"
    },

  ];



  @override
  void initState() {
    super.initState();
    localNotifyItem = allNotifyItem;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:Text("Notifications"),
        centerTitle: true,
        backgroundColor: HexColor("283B71"),
      ),
      body: ListView.builder(
          itemCount: localNotifyItem.length,
          itemBuilder: (BuildContext context,int index){
            return Padding(
              padding: const EdgeInsets.all(1.0),
              child: ListTile(
                  leading: Image(
                    fit: BoxFit.fill,
                    alignment: Alignment.center,
                    image: AssetImage(localNotifyItem[index].imagepath),
                  ),
                  trailing: localNotifyItem[index].adminapproval == 'Rejected'?
                  Text(localNotifyItem[index].adminapproval,
                    style: TextStyle(
                        color: Colors.red,fontSize: 15),):
                  Text(localNotifyItem[index].adminapproval,
                  style: TextStyle(
                        color: Colors.green,fontSize: 15),),


                  title:Text(localNotifyItem[index].itemname),
                  subtitle: Text(localNotifyItem[index].donorname == username ? "Donor: "+username +'  :  '+ allNotifyItem[index].status : "Reciever: "+ username + '  :  '+ allNotifyItem[index].status),
                onTap: () async {
                  //db call for read
                  localNotifyItem[index].status = "Read";
                  print("submitting notification response " );
                    int notifyId = localNotifyItem[index].notifyId;
                  String reqtoken = 'Bearer '+accessToken;
                  final notifyresponse = await http.post(
                    // Uri.parse('http://192.168.1.6:7000/apidb/mylogin'),
                    Uri.parse( Config.apiURL+Config.apimynotifyread),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                      'authorization': reqtoken
                    },
                    body: jsonEncode({
                      "username": username,
                      "notifyId":notifyId

                    }),
                  );
                  if (notifyresponse.statusCode == 200) {
                    print("submitting notification response 200 " +
                        notifyresponse.body);
                    NotifyItem notifyItem = NotifyItem.fromJson(
                        jsonDecode(notifyresponse.body));
                    setState(() {

                      allNotifyItem.clear();

                      allNotifyItem = notifyItem.notificationsItem;
                      localNotifyItem = allNotifyItem;

                    });


                  }
                },
                //tileColor: Colors.red,
              ),
            );
          }
      ),
    );
  }
}