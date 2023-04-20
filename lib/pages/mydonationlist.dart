import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobileui/config.dart';
import 'package:mobileui/models/userlogin.dart';
import 'package:mobileui/pages/item_detail.dart';
import 'package:mobileui/pages/donorupload_item.dart';
import 'package:mobileui/pages/user_item_detail.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:http/http.dart' as http;

class MyDonationList extends StatefulWidget {
  String username;
  String email;
  String gender;
  String accessToken;
  List <Item> myitem;
  MyDonationList ({required this.username,required this.email,required this.gender,required this.accessToken,required this.myitem});



  @override
  State<MyDonationList> createState() => _MyDonationListState(username:username,email:email,gender:gender,accessToken:accessToken,myitem:myitem);
}

class _MyDonationListState extends State<MyDonationList> {

  String  username;
  String  email;
  String gender;
  String  accessToken;
  List <Item> myitem;
  //List <Item> myitem=[];
  List <Item> myreqitem=[];
  List <Item> mydonitem=[];

  _MyDonationListState({required this.username,required this.email,required this.gender,
    required this.accessToken,required this.myitem});
  @override
  void initState() {
    super.initState();
    myreqitem.clear();
    mydonitem.clear();
    myitem.forEach((element)  {
      if(element.recievername == username){
        print("Adding  request item ");
        myreqitem.add(element);
      }
      if(element.donorname == username){
        print("Adding  Donate item ");
        mydonitem.add(element);
      }

    });

    myitem = mydonitem;

  }
  List items = [
    {
      "item_id": 1,
      "itemname": "Shirt",
      "itemtype": "Requesting",
      "mcat": "Cloths",
      "scat": "Shirt",
      "description": "Shirt for men",
      "imagepath": "assets/images/cookiemint.jpg",
      "donorname": "NA",
      "recievername": "sara333",
      "itemaddress": "Rivervale Crescent rumbia lrt",
      "itemlocation": "rumbia",
      "itemphone": "9111111",
      "alluser": "sara111,sara123,sara222",
      "adminapproval": "pending"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:Text("My Donation List"),
          centerTitle: true,
          backgroundColor: HexColor("283B71"),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: InkWell(
                    onTap: () async {


                      String reqtoken = 'Bearer '+accessToken;
                      final response = await http.post(
                        //Uri.parse('http://192.168.1.6:7000/apidb/mydrawer'),
                        Uri.parse(Config.apiURL+ Config.apimydrawer),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                          'Authorization': reqtoken
                        },
                        body: jsonEncode(<String, String>{
                          "email": email,
                          "username": username,
                          "gender": gender
                        }),
                      );
                      if (response.statusCode == 200) {
                        // If the server did return a 201 CREATED response,
                        // then parse the JSON.
                        print("submitting drawer response 200" + response.body);
                        UserLogin userlogin = UserLogin.fromJson(jsonDecode(response.body));
                        print("submitting drawer response 200" + userlogin.myresult);
                        print( userlogin.items.length);
                        myitem.clear();
                        myreqitem.clear();
                        mydonitem.clear();


                        myitem = userlogin.items;
                        if(userlogin.items.length > 0){
                          myreqitem = [];
                          mydonitem = [];

                          myitem.forEach((element)  {
                            if(element.recievername == username){
                              print("Adding  request item ");
                              myreqitem.add(element);
                            }
                            if(element.donorname == username){
                              print("Adding  Donate item ");
                              mydonitem.add(element);
                            }

                          });
                        }else{
                          print("else blk ");
                          myitem = userlogin.items;
                          myreqitem = userlogin.items;
                          mydonitem = userlogin.items;
                        }


                        print("request item");
                        print( myreqitem.length);
                        print("donated item");
                        print( mydonitem.length);


                      }
                      setState(() {
                        myitem = mydonitem;
                      });


                    },
                    child: Icon(
                      Icons.refresh,
                      size: 26.0,
                      color: Colors.white,
                    ),
                  )
              ),
            ]
        ),
        backgroundColor: Color(0xFFFCFAF8),
        body: GridView.builder(
            itemCount: myitem.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              mainAxisExtent: 225,


            ),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => UserItemDetail(
                        itemId: myitem[index].itemId,
                        accessToken:accessToken,
                        username:username,
                        imagepath: myitem[index].imagepath,
                        itemtype: myitem[index].itemtype,
                        itemname: myitem[index].itemname,
                        description: myitem[index].description,
                        donorname: myitem[index].donorname,
                        recievername: myitem[index].recievername,
                        itemphone: myitem[index].itemphone,
                        itemaddress: myitem[index].itemaddress,
                        itemlocation: myitem[index].itemlocation,
                        adminapproval: myitem[index].adminapproval
                    )));
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4,8,4,0),
                child: Container(
                  //height: 6000,
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3.0,
                              blurRadius: 5.0)
                        ],
                        color: Colors.white),
                    child: Column(children: [
                      SizedBox(height: 7.0),
                      Text(myitem[index].itemname,
                          style: TextStyle(
                              color: HexColor("283B71"),
                              fontFamily: 'Varela',
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0)),
                      SizedBox(height: 7.0),
                      Hero(
                          tag: myitem[index].itemId,
                          child: Container(
                              height: 100.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(myitem[index].imagepath),
                                      fit: BoxFit.contain)))),
                      SizedBox(height: 7.0),
                      Text(myitem[index].donorname == username?"Donating":"Recieving",
                          style: TextStyle(
                              color: HexColor("283B71"),
                              fontFamily: 'Varela',
                              fontSize: 14.0)),

                      Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Row(
                          children: [
                            Icon(Icons.person,
                                color: HexColor("283B71"), size: 10.0),
                            SizedBox(height: 7.0),
                            Text(myitem[index].recievername,
                                style: TextStyle(
                                    fontFamily: 'Varela',
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor("#283B71"))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Row(
                          children: [
                            Icon(Icons.admin_panel_settings,
                                color: HexColor("283B71"), size: 10.0),
                            SizedBox(height: 7.0),
                            Text(myitem[index].adminapproval,
                                style: TextStyle(
                                    fontFamily: 'Varela',
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor("#283B71"))),
                          ],
                        ),
                      ),
                    ])),
              ),
            )
        ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
        backgroundColor: HexColor("#283B71"),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Donoruploaditem(username:username,email:email,gender:gender,accessToken:accessToken),
            ),
          );

        },
        child: const Icon(
          Icons.add_circle_outline,
          color: Colors.white,
        ),
    ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}