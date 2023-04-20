import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobileui/config.dart';
import 'package:http/http.dart' as http;
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class ItemDetail extends StatefulWidget {

  String username;
  String  accessToken;
  int itemId;
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
  String alluser;

  ItemDetail ({required this.username,required this.accessToken,required this.itemId,required this.imagepath,required this.itemtype,required this.itemname,
    required this.description,required this.adminapproval,
    required this.donorname,required this.recievername,required this.itemphone,
    required this.itemaddress,required this.itemlocation,required this.alluser,
  });



  @override
  State<ItemDetail> createState() => _ItemDetailState(username:username,accessToken:accessToken,
      itemId:itemId,imagepath:imagepath,itemtype:itemtype,itemname:itemname,
      description:description ,adminapproval:adminapproval,
      donorname:donorname,recievername:recievername,itemphone:itemphone,
      itemaddress:itemaddress,itemlocation:itemlocation,alluser:alluser);
}

class _ItemDetailState extends State<ItemDetail> {

  String username;
  String accessToken;
  int itemId;
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
  String alluser;

  _ItemDetailState({required this.username,required this.accessToken,
    required this.itemId,required this.imagepath,required this.itemtype,required this.itemname,
    required this.description,required this.adminapproval,
    required this.donorname,required this.recievername,required this.itemphone,
    required this.itemaddress,required this.itemlocation,required this.alluser,
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
        title: Text('Details',
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
              child: Text(itemtype,
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
                      fontSize: 24.0)),
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

            SizedBox(height: 15.0),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Icon(Icons.person,
                        color: HexColor("283B71"), size: 30.0),
                  Text(itemtype == 'Donating'?donorname:recievername,
                      style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 22.0,
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
                  Icon(Icons.location_on,
                      color: HexColor("283B71"), size: 30.0),
                  Container(
                    width: MediaQuery.of(context).size.width - 50.0,
                    child: Text(itemaddress+"  "+itemlocation,
                        style: TextStyle(
                            fontFamily: 'Varela',
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: HexColor("#283B71"))),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Icon(Icons.add_call,
                      color: HexColor("283B71"), size: 30.0),
                  Text("987653452",
                      style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: HexColor("#283B71"))),
                ],
              ),
            ),
            SizedBox(height: 20.0),

            Center(
                child: alluser.contains(username)? Container(
                    width: MediaQuery.of(context).size.width - 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: HexColor("#283B71")
                    ),
                    child: Center(
                        child: Text("Interest Sent",
                          style: TextStyle(
                              fontFamily: 'Varela',
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        )
                    )

                ) :
                Container(
                    width: MediaQuery.of(context).size.width - 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: HexColor("#283B71")
                    ),
                    child: InkWell(
                      onTap: () async {
                        //send interest to DB
                        if(alluser.trim().contains(username)){
                          //ignore
                          print("submitting alluser item api ignore ");
                        }else{
                          print("submitting alluser item api: " +alluser);
                          alluser = alluser.isEmpty?username.trim():alluser.trim()+','+username.trim();

                          print('${alluser[0]}');
                          print("submitting alluser item api: " +alluser);
                          // Api call to update item
                          String reqtoken = 'Bearer '+accessToken;
                          final response = await http.post(
                            //Uri.parse('http://192.168.1.6:7000/apidb/myhome'),
                            Uri.parse(Config.apiURL+Config.apimyitemalluser),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                              'Authorization': reqtoken
                            },
                            body: jsonEncode({

                              "itemId": itemId,
                              "alluser": alluser
                            }),
                          );
                          if (response.statusCode == 200) {
                            print("submitting notification response " +
                                response.body);
                            FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                                "Interest Sent",
                              "OK",
                                  () {
                                Navigator.pop(context);
                                Navigator.pop(context);


                              },
                            );

                          }else{
                            FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Error Try Again",
                              "OK",
                                  () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);


                              },
                            );
                          }


                        }
                      },
                      child: Center(
                          child: Text(itemtype == 'Donating'?"Request":"Donate",
                            style: TextStyle(
                                fontFamily: 'Varela',
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          )
                      ),
                    )

                )
            ),


          ]
      ),


    );
  }
}