import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileui/config.dart';
import 'package:mobileui/models/ItemPost.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:http/http.dart' as http;

class Donoruploaditem extends StatefulWidget {
  String username;
  String email;
  String gender;
  String accessToken;
  Donoruploaditem({required this.username,required this.email,required this.gender,required this.accessToken});


  @override
  _DonoruploaditemState createState() => _DonoruploaditemState(username:username,email:email,gender:gender,accessToken:accessToken);
}

class _DonoruploaditemState extends State<Donoruploaditem> {
  String  username;
  String  email;
  String  gender;
  String  accessToken;

  _DonoruploaditemState({required this.username,required this.email,required this.gender,required this.accessToken});

  String dropdownvalue = 'MainCategory';
  String sdropdownvalue = 'SubCategory';

  var items =  ['MainCategory','Education','Food','HomeUtils','Clothes'];

  var subitems = ['SubCategory'];

  TextEditingController nameController = TextEditingController();

  TextEditingController _DescController = TextEditingController();
  TextEditingController _PhoneController = TextEditingController();
  TextEditingController _AddressController = TextEditingController();
  TextEditingController _CityController = TextEditingController();
  String NAuser='NotAssigned';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Donate Item'),
          centerTitle: true,
          backgroundColor: HexColor("283B71"),
    ),
      body: SingleChildScrollView(
        child: Column(
            children: <Widget>[
            Padding(
            padding: EdgeInsets.fromLTRB(20,20,20,0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Item Name',
                ),
              ),
            ),
              Padding(
                padding: EdgeInsets.fromLTRB(20,20,20,0),
                child: Center(

                  child: Row(
                    children: [
                      DropdownButton(
                        value: dropdownvalue,

                        icon: Icon(Icons.keyboard_arrow_down),

                        items:items.map((String items) {
                          return DropdownMenuItem(
                              value: items,
                              child: Text(items,
                                overflow: TextOverflow.ellipsis,
                              )
                          );
                        }
                        ).toList(),
                        onChanged: (newValue){
                          setState(() {
                            dropdownvalue = newValue.toString();
                            print("inside drop down "+dropdownvalue);
                            if (dropdownvalue == 'Education'){
                              subitems=['Books','SchoolBag','StudyTable','PencilBox','Laptop'];
                              sdropdownvalue = 'Books';
                              print("inside sub drop down "+ subitems.first);
                            }
                            if (dropdownvalue == 'Food'){
                              subitems = ['Briyani','Chapathi','Dosa','Idly','VegMeals'];
                              sdropdownvalue = 'Briyani';
                              print("inside sub drop down "+ subitems.first);
                            }
                            if (dropdownvalue == 'HomeUtils'){
                              subitems = ['LEDTv','Sofa','DiningTable','Wardrobe','Bed'];
                              sdropdownvalue = 'LEDTv';
                              print("inside sub drop down "+ subitems.first);
                            }
                            if (dropdownvalue == 'Clothes'){
                              subitems = ['MenDress','WomenDress','KidsDress','BabyDress','ElderlyDress'];
                              sdropdownvalue = 'MenDress';
                              print("inside sub drop down "+ subitems.first);
                            }
                          });
                        },

                      ),
                      SizedBox(width: 100.0),
                      DropdownButton(
                        value: sdropdownvalue,

                        icon: Icon(Icons.keyboard_arrow_down),

                        items:subitems.map((String subitems) {
                          return DropdownMenuItem(
                              value: subitems,
                              child: Text(subitems,
                                overflow: TextOverflow.ellipsis,
                              )
                          );
                        }
                        ).toList(),
                        onChanged: (newValue){
                          setState(() {
                            sdropdownvalue = newValue.toString();

                          });
                        },

                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20,20,20,0),
                child: TextField(
                  controller: _DescController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),

                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20,20,20,0),
                child: TextField(
                  controller: _PhoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20,20,20,0),
                child: TextField(
                  controller: _AddressController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                  ),

                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20,20,20,0),
                child: TextField(
                  controller: _CityController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'City/Landmark',
                  ),
                ),
              ),



              SizedBox(height: 20.0),
              Center(
                  child: InkWell(
                      onTap: () async {
                        print("inside the submit button");
                        if( nameController.text.trim() == '' ||
                            dropdownvalue.trim() == 'MainCategory' ||
                            _DescController.text.trim() == '' ||
                            _PhoneController.text.trim() == '' ||
                            _AddressController.text.trim() == '' ||
                            _CityController.text.trim() == ''){
                          print("inside the if chk ");
                          FormHelper.showSimpleAlertDialog(
                            context,
                            Config.appName,
                            "Please fill all Fields",
                            "OK",
                                () {
                              Navigator.pop(context);

                              // Navigator.pop(context);

                            },
                          );

                        }else {
                          print(nameController.text.trim());
                          print(dropdownvalue.trim());
                          print(sdropdownvalue.trim());
                          print(_DescController.text.trim());
                          print(_PhoneController.text.trim());
                          print(_AddressController.text.trim());
                          print(_CityController.text.trim());
                          String reqtoken = 'Bearer '+accessToken;
                          final response = await http.post(
                            //Uri.parse('http://192.168.1.6:7000/apidb/myitempost'),
                            Uri.parse(Config.apiURL+Config.apimyitempost),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                              'Authorization': reqtoken
                            },
                            body: jsonEncode(<String, String>{
                              "email": email,
                              "username": username,
                              "itemname":nameController.text.trim(),
                              "itemtype":"Donating",
                              "mcat":dropdownvalue.trim(),
                              "scat":sdropdownvalue.trim(),
                              "description":_DescController.text.trim(),
                              "imagepath":"assets/images/"+sdropdownvalue.trim()+".jpg",
                              "donorname":username,
                              "recievername":NAuser,
                              "itemaddress":_AddressController.text.trim(),
                              "itemlocation":_CityController.text.trim(),
                              "itemphone":_PhoneController.text.trim(),
                              "alluser":NAuser,
                              "adminapproval":"Pending"



                            }),
                          );

                          if (response.statusCode == 200) {
                            print("submitting login response 200" + response.body);
                            ItemPost itemPost = ItemPost.fromJson(jsonDecode(response.body));
                            print("submitting login response 200" + itemPost.myresult);
                            print("submitting login response 200" + itemPost.itemname);
                            FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              itemPost.itemname +" Listed",
                              "OK",
                                  () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                // Navigator.pop(context);

                              },
                            );
                          }else{
                            FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "DB Error",
                              "OK",
                                  () {
                                Navigator.pop(context);
                                //Navigator.pop(context);
                                // Navigator.pop(context);

                              },
                            );
                          }



                        }
                      },
                    child: Container(
                        width: MediaQuery.of(context).size.width - 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: HexColor("#283B71")
                        ),
                        child: Center(
                            child: Text('Donate',
                              style: TextStyle(
                                  fontFamily: 'Varela',
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            )
                        )

                    ),
                  )
              ),

            ]
    ),
      )
    );
  }
}
