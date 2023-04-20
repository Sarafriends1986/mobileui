import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobileui/models/userlogin.dart';
import 'package:mobileui/pages/item_detail.dart';
import 'package:snippet_coder_utils/hex_color.dart';
class ClothesItemPage extends StatefulWidget {
  String  username;
  String  email;
  String  accessToken;
  List <Item> clothitems;
  ClothesItemPage({required this.username,required this.email,required this.accessToken,required this.clothitems});
  late TabController _tabController;

  @override
  _ClothesItemPageState createState() => _ClothesItemPageState(username:username,email:email,accessToken:accessToken,clothitems:clothitems);
}

class _ClothesItemPageState extends State<ClothesItemPage> with SingleTickerProviderStateMixin  {
  String  username;
  String  email;
  String  accessToken;
  List <Item> clothitems;
  _ClothesItemPageState({required this.username,required this.email,required this.accessToken,required this.clothitems});
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
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFCFAF8),
        body: GridView.builder(
            itemCount: clothitems.length,
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
                        itemId: clothitems[index].itemId,
                        imagepath: clothitems[index].imagepath,
                        itemtype: clothitems[index].itemtype,
                        itemname: clothitems[index].itemname,
                        description: clothitems[index].description,
                        donorname: clothitems[index].donorname,
                        recievername: clothitems[index].recievername,
                        itemphone: clothitems[index].itemphone,
                        itemaddress: clothitems[index].itemaddress,
                        itemlocation: clothitems[index].itemlocation,
                        adminapproval: clothitems[index].adminapproval,
                        alluser:clothitems[index].alluser
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
                      Text(clothitems[index].itemname,
                          style: TextStyle(
                              color: HexColor("283B71"),
                              fontFamily: 'Varela',
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0)),
                      SizedBox(height: 7.0),
                      Hero(
                          tag: clothitems[index].itemId,
                          child: Container(
                              height: 100.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(clothitems[index].imagepath),
                                      fit: BoxFit.contain)))),
                      SizedBox(height: 7.0),
                      Text(clothitems[index].itemtype,
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
                            Text(clothitems[index].itemtype == 'Donating'? clothitems[index].donorname:clothitems[index].recievername,
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
                            Text(clothitems[index].itemlocation,
                                style: TextStyle(
                                    fontFamily: 'Varela',
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor("#283B71"))),
                            SizedBox(width: 45.0),
                            clothitems[index].alluser.contains(username)?
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