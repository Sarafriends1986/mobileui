import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobileui/models/userlogin.dart';
import 'package:mobileui/pages/item_detail.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class HomeUtilsItemPage extends StatefulWidget {
  String  username;
  String  email;
  String  accessToken;
  List <Item> homeutilsitems;
  HomeUtilsItemPage({required this.username,required this.email,required this.accessToken,required this.homeutilsitems});
  late TabController _tabController;

  @override
  _HomeUtilsItemPageState createState() => _HomeUtilsItemPageState(username:username,email:email,accessToken:accessToken,homeutilsitems:homeutilsitems);
}

class _HomeUtilsItemPageState extends State<HomeUtilsItemPage> with SingleTickerProviderStateMixin  {
  String  username;
  String  email;
  String  accessToken;
  List <Item> homeutilsitems;
  _HomeUtilsItemPageState({required this.username,required this.email,required this.accessToken,required this.homeutilsitems});

  @override
  void initState() {
    super.initState();

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
        backgroundColor: Color(0xFFFCFAF8),
        body: GridView.builder(
            itemCount: homeutilsitems.length,
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
                        itemId: homeutilsitems[index].itemId,
                        imagepath: homeutilsitems[index].imagepath,
                        itemtype: homeutilsitems[index].itemtype,
                        itemname: homeutilsitems[index].itemname,
                        description: homeutilsitems[index].description,
                        donorname: homeutilsitems[index].donorname,
                        recievername: homeutilsitems[index].recievername,
                        itemphone: homeutilsitems[index].itemphone,
                        itemaddress: homeutilsitems[index].itemaddress,
                        itemlocation: homeutilsitems[index].itemlocation,
                        adminapproval: homeutilsitems[index].adminapproval,
                        alluser: homeutilsitems[index].alluser
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
                      Text(homeutilsitems[index].itemname,
                          style: TextStyle(
                              color: HexColor("283B71"),
                              fontFamily: 'Varela',
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0)),
                      SizedBox(height: 7.0),
                      Hero(
                          tag: homeutilsitems[index].itemId,
                          child: Container(
                              height: 100.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(homeutilsitems[index].imagepath),
                                      fit: BoxFit.contain)))),
                      SizedBox(height: 7.0),
                      Text(homeutilsitems[index].itemtype,
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
                                color: HexColor("283B71"), size: 15.0),
                            SizedBox(height: 7.0),
                            Text(homeutilsitems[index].itemtype == 'Donating'? homeutilsitems[index].donorname:homeutilsitems[index].recievername,
                                style: TextStyle(
                                    fontFamily: 'Varela',
                                    fontSize: 14.0,
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
                                color: HexColor("283B71"), size: 15.0),
                            SizedBox(height: 7.0),
                            Text(homeutilsitems[index].itemlocation,
                                style: TextStyle(
                                    fontFamily: 'Varela',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor("#283B71"))),
                            SizedBox(width: 45.0),
                            homeutilsitems[index].alluser.contains(username)?
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