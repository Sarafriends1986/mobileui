import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobileui/config.dart';
import 'package:http/http.dart' as http;
import 'package:mobileui/models/ItemPost.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import 'package:snippet_coder_utils/hex_color.dart';

class UserItemDetail extends StatefulWidget {
  int itemId;
  String accessToken;
  String username;
  String imagepath;
  String itemtype;
  String itemname;
  String description;
  String adminapproval;
  String donorname;
  String recievername;
  String itemphone;
  String itemaddress;
  String itemlocation;

  UserItemDetail ({required this.itemId,required this.accessToken,
    required this.username, required this.imagepath,
    required this.itemtype,required this.itemname,
    required this.description,required this.adminapproval,
    required this.donorname,required this.recievername,required this.itemphone,
    required this.itemaddress,required this.itemlocation,
  });



  @override
  State<UserItemDetail> createState() => _UserItemDetailState(itemId:itemId,accessToken:accessToken,
      username:username,imagepath:imagepath,
      itemtype:itemtype,itemname:itemname,
      description:description ,adminapproval:adminapproval,
      donorname:donorname,recievername:recievername,itemphone:itemphone,
      itemaddress:itemaddress,itemlocation:itemlocation);
}

class _UserItemDetailState extends State<UserItemDetail> {
  int itemId;
  String accessToken;
  String username;
  String imagepath;
  String itemtype;
  String itemname;
  String description;
  String adminapproval;
  String donorname;
  String recievername;
  String itemphone;
  String itemaddress;
  String itemlocation;


  _UserItemDetailState({required this.itemId,required this.accessToken,
    required this.username,required this.imagepath,
    required this.itemtype,required this.itemname,
    required this.description,required this.adminapproval,
  required this.donorname,required this.recievername,required this.itemphone,
  required this.itemaddress,required this.itemlocation,
    });
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("283B71"),
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('My Item Details',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 25.0,
                )),
        actions: <Widget>[/*
          IconButton(
            icon: Icon(Icons.notifications, ),
            onPressed: () {},
          ),*/
        ],
      ),

      body: ListView(
          children: [
            SizedBox(height: 15.0),
            Center(
              child: Text(donorname==username?"Donating":"Recieving",
                  style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: HexColor("#283B71"))),
            ),
            SizedBox(height: 10.0),
            Hero(
                tag: itemId,
                child: Image.asset(imagepath,
                    height: 200.0,
                    width: 200.0,
                    fit: BoxFit.contain
                )
            ),
            SizedBox(height: 10.0),

            Center(
              child: Text(itemname,
                  style: TextStyle(
                      color: HexColor("#283B71"),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Varela',
                      fontSize: 20.0)),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50.0,
                child: Text(description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: HexColor("#283B71"))
                ),
              ),
            ),

            SizedBox(height: 10.0),

            Padding(
              padding: EdgeInsets.only(left: 20.0),

              child: Row(
                children: [
                  Icon(Icons.location_on,
                      color: HexColor("283B71"), size: 30.0),
                  Container(
                    width: MediaQuery.of(context).size.width - 50.0,
                    child: Text(itemaddress+" "+itemlocation,
                        style: TextStyle(
                            fontFamily: 'Varela',
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: HexColor("#283B71"))),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Icon(Icons.add_call,
                      color: HexColor("283B71"), size: 30.0),
                  Text(itemphone,
                      style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: HexColor("#283B71"))),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Icon(Icons.person,
                      color: HexColor("283B71"), size: 30.0),
                  Text("Donor: "+donorname,
                      style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: HexColor("#283B71"))),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Icon(Icons.person,
                      color: HexColor("283B71"), size: 30.0),
                  Text("Reciever: "+recievername,
                      style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: HexColor("#283B71"))),
                ],
              ),
            ),
            SizedBox(height: 15.0),

            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Icon(Icons.admin_panel_settings,
                      color: HexColor("283B71"), size: 30.0),
                  Text(adminapproval,
                      style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: HexColor("#283B71"))),
                ],
              ),
            ),
            SizedBox(height: 15.0),
            InkWell(
              onTap: () async {
                //Api to delete
                String reqtoken = 'Bearer '+accessToken;
                final response = await http.post(
                  //Uri.parse('http://192.168.1.6:7000/apidb/myitempost'),
                  Uri.parse(Config.apiURL+Config.apimyitemdel),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                    'Authorization': reqtoken
                  },
                  body: jsonEncode({
                    "itemId": itemId,
                    "accessToken":accessToken

                  }),
                );
                if (response.statusCode == 200) {
                  print("submitting login response 200" + response.body);
                  ItemPost itemPost = ItemPost.fromJson(
                      jsonDecode(response.body));
                  print("submitting item delete 200" + itemPost.myresult);
                  print("submitting item delete 200" + itemPost.itemname);
                  if (itemPost.myresult == 'Success') {
                    FormHelper.showSimpleAlertDialog(
                      context,
                      Config.appName,
                      itemPost.itemname + " Deleted",
                      "OK",
                          () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        // Navigator.pop(context);

                      },
                    );
                  } else {
                    FormHelper.showSimpleAlertDialog(
                      context,
                      Config.appName,
                      "DB Error",
                      "OK",
                          () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        // Navigator.pop(context);

                      },
                    );
                  }
                }
              },

              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0,8.0,20.0,0.0),
                child: Container(
                    width: MediaQuery.of(context).size.width - 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: HexColor("#283B71")
                    ),
                    child: Center(
                        child: Text('Delete',
                          style: TextStyle(
                              fontFamily: 'Varela',
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        )
                    )

                ),
              ),
            ),


          ]
      ),


    );
  }
}