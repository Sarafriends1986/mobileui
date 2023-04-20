import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:icon_badge/icon_badge.dart';
import 'package:mobileui/models/NotifyItem.dart';
import 'package:mobileui/models/userlogin.dart';
import 'package:mobileui/navigation_drawer.dart';
import 'package:mobileui/pages/clothes_item_page.dart';
import 'package:mobileui/pages/education_item_page.dart';
import 'package:mobileui/pages/food_item_page.dart';
import 'package:mobileui/pages/homeutils_item_page.dart';
import 'package:http/http.dart' as http;
import 'package:mobileui/pages/notifications.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import 'package:mobileui/config.dart';


class HomePage extends StatefulWidget {
  String username;
  String email;
  String  gender;
  String accessToken;
  List <Item> myitem;
  List <NotificationsItem> notificationsItem;

  HomePage({required this.username,required this.email,required this.gender,
    required this.accessToken,required this.myitem,required this.notificationsItem});

  late TabController _tabController;

  @override
  _HomePageState createState() => _HomePageState(username:username,email:email,gender:gender,
      accessToken:accessToken,myitem:myitem,notificationsItem:notificationsItem);
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin  {
  String  username;
  String  email;
  String  gender;
  String  accessToken;
  List <Item> myitem;
  List <NotificationsItem> notificationsItem;


  _HomePageState({required this.username,required this.email,required this.gender,
    required this.accessToken,required this.myitem,required this.notificationsItem});

  late TabController _tabController;
  List <Item> eduitems=[] ;
  List <Item> clothitems=[] ;
  List <Item> fooditems=[] ;
  List <Item> homeutilsitems=[] ;
  List <NotificationsItem> unreadNotifyItem = [];
  List <NotificationsItem> allNotifyItem = [];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);


    notificationsItem.forEach((element) {
      if(element.status == 'Unread'){
        unreadNotifyItem.add(element);
      }
      allNotifyItem.add(element);
    });

    myitem.forEach((element) {
      if(element.mcat == 'Education'){
        eduitems.add(element);
      }
      if(element.mcat == 'Clothes'){
        clothitems.add(element);
      }
      if(element.mcat == 'Food'){
        fooditems.add(element);
      }
      if(element.mcat == 'HomeUtils'){
        homeutilsitems.add(element);
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        drawer: NavigationDrawer(username: username,email:email,gender:gender,accessToken:accessToken),
        appBar: AppBar(
          title: const Text('Helping Hands'),
          centerTitle: true,
         backgroundColor: HexColor("283B71"),
          //backgroundColor: Color(0xFFC88D67),
          actions: <Widget>[

            IconBadge(
              icon: Icon(Icons.notifications,
              size: 28,),
              itemCount: unreadNotifyItem.length,

              badgeColor: Colors.red,
              itemColor: Colors.white,
              maxCount: 22,//unread count from DB
              hideZero: true,
              onTap: ()  {
                //api mark all notify is read
                print("myuser mypass mycpass myemail");
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Notifications(username: username,email:email,gender:gender,accessToken:accessToken,allNotifyItem: allNotifyItem),
                  ),
                );
                print("myuser mypass mycpass myemail");
              },
            ),


          ],
        ),
        body: ListView(
          padding: EdgeInsets.only(left: 20.0),
          children: <Widget>[
            SizedBox(height: 15.0),
            Row(
              children: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.home,
                    size:28,
                    color:HexColor("283B71") ,
                    ),
                  ),
                  onTap: () async {
                    String reqtoken = 'Bearer '+accessToken;
                    final response = await http.post(
                      //Uri.parse('http://192.168.1.6:7000/apidb/myhome'),
                      Uri.parse(Config.apiURL+Config.apimyhome),
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
                      print("submitting api home response 200");
                      // print("submitting login response 200" + response.body);
                      UserLogin userlogin = UserLogin.fromJson(jsonDecode(response.body));
                      print("submitting login response 200" + userlogin.myresult);
                      print( userlogin.items.length);
                      setState(() {
                        myitem = userlogin.items;
                        eduitems.clear();
                        clothitems.clear();
                        fooditems.clear();
                        homeutilsitems.clear();
                        myitem.forEach((element) {
                          if(element.mcat == 'Education'){
                            eduitems.add(element);
                          }
                          if(element.mcat == 'Clothes'){
                            clothitems.add(element);
                          }
                          if(element.mcat == 'Food'){
                            fooditems.add(element);
                          }
                          if(element.mcat == 'HomeUtils'){
                            homeutilsitems.add(element);
                          }
                        });
                      });

                      //Notification
                      print("submitting notification response " );
                      String reqtoken = 'Bearer '+accessToken;
                      final notifyresponse = await http.post(
                        // Uri.parse('http://192.168.1.6:7000/apidb/mylogin'),
                        Uri.parse( Config.apiURL+Config.apimynotify),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                          'authorization': reqtoken
                        },
                        body: jsonEncode(<String, String>{
                          "username": userlogin.username,


                        }),
                      );
                      if (notifyresponse.statusCode == 200) {
                        print("submitting notification response 200 " +
                            notifyresponse.body);
                        NotifyItem notifyItem = NotifyItem.fromJson(
                            jsonDecode(notifyresponse.body));
                        setState(() {
                          notificationsItem.clear();
                          allNotifyItem.clear();
                          unreadNotifyItem.clear();
                          notificationsItem = notifyItem.notificationsItem;
                          notificationsItem.forEach((element) {
                            if(element.status == 'Unread'){
                              unreadNotifyItem.add(element);
                            }
                            allNotifyItem.add(element);
                          });
                        });


                      }


                    }//if 200 chk

                  },
                ),
                Text('Categories',
                    style: TextStyle(
                        color: HexColor("283B71"),
                        fontFamily: 'Varela',
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold)),
                /* home page notify
                Padding(
                  padding: const EdgeInsets.fromLTRB(120.0, 0.0, 0.0, 0.0),
                  child: IconBadge(
                    icon: Icon(Icons.notifications,
                      size: 30,
                      color:HexColor("283B71") ,),
                    itemCount: unreadNotifyItem.length,

                    badgeColor: Colors.red,
                    itemColor: Colors.white,
                    maxCount: 22,//unread count from DB
                    hideZero: true,
                    onTap: ()  {
                      //api mark all notify is read
                      print("myuser mypass mycpass myemail");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Notifications(allNotifyItem: allNotifyItem),
                        ),
                      );
                      print("myuser mypass mycpass myemail");
                    },
                  ),
                ),
                */
              ],
            ),
            SizedBox(height: 15.0),
            TabBar(
                controller: _tabController,
                indicatorColor: Colors.transparent,
                labelColor: HexColor("283B71"),
                isScrollable: true,
                labelPadding: EdgeInsets.only(right: 45.0),
                unselectedLabelColor: HexColor("283B71"),
                tabs: [
                  Tab(
                    child: Text('Education',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 21.0,
                        )),
                  ),
                  Tab(
                    child: Text('Food',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 21.0,
                        )),
                  ),
                  Tab(
                    child: Text('HomeUtils',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 21.0,
                        )),
                  ),
                  Tab(
                    child: Text('Clothes',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 21.0,
                        )),
                  )
                ]),
            Container(
                height: MediaQuery.of(context).size.height - 50.0,
                width: double.infinity,
                child: TabBarView(
                    controller: _tabController,
                    children: [
                      EducationItemPage(username:username,email:email,accessToken:accessToken,eduitems:eduitems),
                      FoodItemPage(username:username,email:email,accessToken:accessToken,fooditems:fooditems),
                      HomeUtilsItemPage(username:username,email:email,accessToken:accessToken,homeutilsitems:homeutilsitems),
                      ClothesItemPage(username:username,email:email,accessToken:accessToken,clothitems:clothitems),
                    ]
                )
            )
          ],
        ),


    );
  }
}