import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobileui/pages/item_detail.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import 'package:mobileui/models/userlogin.dart';

class EducationItemPage extends StatefulWidget {
  String  username;
  String  email;
  String  accessToken;
  List <Item> eduitems;
  EducationItemPage({required this.username,required this.email,required this.accessToken,required this.eduitems});
  late TabController _tabController;

  @override
  _EducationItemPageState createState() => _EducationItemPageState(username:username,email:email,accessToken:accessToken,eduitems:eduitems);
}

class _EducationItemPageState extends State<EducationItemPage> with SingleTickerProviderStateMixin  {
  String  username;
  String  email;
  String  accessToken;
  List <Item> eduitems;
  _EducationItemPageState({required this.username,required this.email,required this.accessToken,required this.eduitems});

  @override
  void initState() {
    super.initState();



  }
  /*
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
      "adminapproval": "pending"
    },
  ];
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFCFAF8),
        body: GridView.builder(
            itemCount: eduitems.length,
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
                    MaterialPageRoute(builder: (context) => ItemDetail(
                        username:username,
                        accessToken:accessToken,
                        itemId: eduitems[index].itemId,
                        imagepath: eduitems[index].imagepath,
                        itemtype: eduitems[index].itemtype,
                        itemname: eduitems[index].itemname,
                        description: eduitems[index].description,
                        donorname: eduitems[index].donorname,
                        recievername: eduitems[index].recievername,
                        itemphone: eduitems[index].itemphone,
                        itemaddress: eduitems[index].itemaddress,
                        itemlocation: eduitems[index].itemlocation,
                        adminapproval: eduitems[index].adminapproval,
                        alluser:eduitems[index].alluser
                    )));
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,8,20,8),
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
                      Text(eduitems[index].itemname,
                          style: TextStyle(
                              color: HexColor("283B71"),
                              fontFamily: 'Varela',
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0)),
                      SizedBox(height: 7.0),
                      Hero(
                          tag: eduitems[index].itemId,
                          child: Container(
                              height: 100.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(eduitems[index].imagepath),
                                      fit: BoxFit.contain)))),
                      SizedBox(height: 7.0),
                      Text(eduitems[index].itemtype,
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
                            Text(eduitems[index].itemtype == 'Donating'? eduitems[index].donorname:eduitems[index].recievername,
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
                            Icon(Icons.location_on,
                                color: HexColor("283B71"), size: 10.0),
                            SizedBox(height: 7.0),
                            Text(eduitems[index].itemlocation,
                                style: TextStyle(
                                    fontFamily: 'Varela',
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor("#283B71"))),
                            SizedBox(width: 45.0),
                            eduitems[index].alluser.contains(username)?
                            Icon(Icons.thumb_up,
                                color: HexColor("283B71"), size: 20.0):
                            Icon(Icons.thumb_up_alt_outlined,
                                color: HexColor("283B71"), size: 20.0),
                            SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    ])),
              ),
            )));
  }
}