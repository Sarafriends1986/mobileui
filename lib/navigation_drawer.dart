import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobileui/config.dart';
import 'package:mobileui/drawer_item.dart';
import 'package:mobileui/models/userlogin.dart';
import 'package:mobileui/pages/mydonationlist.dart';
import 'package:mobileui/pages/myrequestlist.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:http/http.dart' as http;

class NavigationDrawer extends StatefulWidget {
  String username;
  String email;
  String gender;
  String accessToken;
  NavigationDrawer({required this.username,required this.email,required this.gender,required this.accessToken});
  //const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState(username: username,email:email,gender:gender,accessToken:accessToken);
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  String username;
  String email;
  String gender;
  String accessToken;
  _NavigationDrawerState({required this.username,required this.email,required this.gender,required this.accessToken});

  @override
  initState(){
    
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: HexColor("283B71"),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
          child: Column(
            children: [
              headerWidget(),
              const SizedBox(height: 30,),
              const Divider(thickness: 1, height: 10, color: Colors.white,),
              const SizedBox(height: 30,),

              InkWell(
                onTap: ()=>{onItemPressed(context, index: 0)
                },
                child: DrawerItem(
                  name: 'My Donations',
                  icon: Icons.volunteer_activism,
                  onPressed: ()=> onItemPressed(context, index: 0),
                ),
              ),
              const SizedBox(height: 30,),
              InkWell(
                onTap: ()=> {onItemPressed(context, index: 1)
                },
                child: DrawerItem(
                    name: 'My Request',
                    icon: Icons.volunteer_activism,
                    onPressed: ()=> onItemPressed(context, index: 1)
                ),
              ),

              const SizedBox(height: 30,),

              const Divider(thickness: 1, height: 10, color: Colors.white,),
              const SizedBox(height: 30,),

              InkWell(
                onTap: ()=> {onItemPressed(context, index: 2)
                },
                child: DrawerItem(
                    name: 'Log out',
                    icon: Icons.logout,
                    onPressed: ()=> onItemPressed(context, index: 2)
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> onItemPressed(BuildContext context, {required int index}) async {
    Navigator.pop(context);
    List <Item> myitem=[];
    List <Item> myreqitem=[];
    List <Item> mydonitem=[];

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

          setState(() {


          myitem = userlogin.items;
          if(userlogin.items.length > 0){
            myreqitem = [];
            mydonitem = [];

            myitem.forEach((element)  {
              if(element.recievername == username){
                print("Adding  request item ");
                myreqitem.add(element);
              }
              if(element.donorname == username ){
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


          });

        }



    switch(index){
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyDonationList(username:username,email:email,gender:gender,accessToken:accessToken,myitem:mydonitem)));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyRequestList(username:username,email:email,gender:gender,accessToken:accessToken,myitem:myreqitem)));
        break;
      case 2:

        Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
              (route) => false,
        );
        break;

    }
  }

  Widget headerWidget() {
    const url = 'https://media.istockphoto.com/photos/learn-to-love-yourself-first-picture-id1291208214?b=1&k=20&m=1291208214&s=170667a&w=0&h=sAq9SonSuefj3d4WKy4KzJvUiLERXge9VgZO-oqKUOo=';
    String profileimgstr = 'assets/images/profile.png';
    if(gender == 'male'){
       profileimgstr = 'assets/images/male.png';
    }else if (gender == 'female'){
       profileimgstr = 'assets/images/female.png';
    }else{
       profileimgstr = 'assets/images/profile.png';
    }


    return Row(
      children: [
        Hero(
            tag: profileimgstr,
            child: Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(profileimgstr),
                        fit: BoxFit.contain)))),
        const SizedBox(width: 20,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username, style: TextStyle(fontSize: 14, color: Colors.white)),
              SizedBox(height: 10,),
              Text(email,
                    overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                    style: TextStyle(fontSize: 14, color: Colors.white)),

            ],
          ),
        )
      ],
    );

  }
}

class _imageToShow {
}



