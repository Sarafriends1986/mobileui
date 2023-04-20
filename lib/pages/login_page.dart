import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobileui/models/userlogin.dart';
import 'package:mobileui/pages/home_page.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:http/http.dart' as http;
import 'package:mobileui/config.dart';

import 'package:mobileui/models/NotifyItem.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? email;
  String? password;


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    UserLogin userlogin;
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#283B71"),
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _loginUI(context),
          ),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }
   String lmyemail='';
   String lmypass='';
  Widget _loginUI(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5.2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.only(
                //topLeft: Radius.circular(100),
                //topRight: Radius.circular(150),
                bottomRight: Radius.circular(100),
                bottomLeft: Radius.circular(100),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Padding(
                //   padding: const EdgeInsets.only(top: 20),
                //   child: Center(
                //     child: Text(
                //       "Shopping App",
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         fontSize: 40,
                //         color: HexColor("#283B71"),
                //       ),
                //     ),
                //   ),
                //),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/HHlogo.png",
                    fit: BoxFit.contain,
                    //width: 150,
                    height: MediaQuery.of(context).size.height / 5.8,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 30, top: 50),
            child: Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FormHelper.inputFieldWidget(
              context,

              "Email",
              "Email",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Email can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                email = onSavedVal,
                lmyemail=email!.trim(),
                print("lmyemail Pressed" + email!.trim())
              },
              initialValue: "",
              obscureText: false,
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: true,
              prefixIcon: Icon(Icons.person_outline),

            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FormHelper.inputFieldWidget(
              context,

              "Password",
              "Password",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Password can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                password = onSavedVal,
                lmypass = password!.trim(),
              print("password Pressed" + password!.trim())
              },
              initialValue: "",
              obscureText: hidePassword,
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: true,
              prefixIcon: Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                color: Colors.white.withOpacity(0.7),
                icon: Icon(
                  hidePassword ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 25,
              ),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.grey, fontSize: 14.0),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Forget Password ?',
                      style: const TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/reset',
                              (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Login",
              () async {
                   validateAndSave();
                  print("email mypass login response 200" +lmyemail +"sara chk" + lmypass);
                if (lmyemail.trim() != "" && lmypass.trim() != "") {
                  print("submitting login");
                  final response = await http.post(
                   // Uri.parse('http://192.168.1.6:7000/apidb/mylogin'),
                      Uri.parse( Config.apiURL+Config.apimylogin),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(<String, String>{
                      "email": lmyemail,
                      "password": lmypass
                    }),
                  );

                  if (response.statusCode == 200) {
                    // If the server did return a 201 CREATED response,
                    // then parse the JSON.
                    print(response.statusCode);
                    print("submitting login response "  + response.body);
                    UserLogin userlogin = UserLogin.fromJson(jsonDecode(response.body));
                    print("submitting login response " + userlogin.myresult);
                    print("submitting login response " + userlogin.username);
                    print("submitting login response " + userlogin.email);
                    print("submitting login response " + userlogin.gender);
                    print("submitting login response " + userlogin.accessToken);
                    print("submitting login response " );
                    //userToken.token='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNhcmExMjNAZ21haWwuY29tIiwiaWF0IjoxNjUwNTQ0ODk4LCJleHAiOjE2NTA1NDg0OTh9.vAMp_1PGFt2AbNswtd9RKL5Rhbl2BSowVUohC8snUDg';

                    List <Item> myitem = userlogin.items;
                    List <Item> eduitems=[] ;
                    List <Item> clothitems=[] ;
                    List <Item> fooditems=[] ;
                    List <Item> homeutilsitems=[] ;
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
                            if (userlogin.myresult.contains('Authenticated') ) {
                              print("submitting notification response " );
                              String reqtoken = 'Bearer '+userlogin.accessToken;
                              final response = await http.post(
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

                              if (response.statusCode == 200) {
                                print("submitting notification response " +
                                    response.body);
                                NotifyItem notifyItem = NotifyItem.fromJson(
                                    jsonDecode(response.body));
                                List <NotificationsItem> notificationsItem = notifyItem
                                    .notificationsItem;


                                print(
                                    "submitting login response Authenticated ");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HomePage(username: userlogin.username,
                                            email: userlogin.email,
                                            gender: userlogin.gender,
                                            accessToken: userlogin.accessToken,
                                            myitem: myitem,
                                            notificationsItem: notificationsItem),
                                  ),
                                );
                              } //if chk for notify status 200
                            } else {
                              print("submitting login response Not Authenticated " );
                               FormHelper.showSimpleAlertDialog(
                                context,
                                Config.appName,
                                userlogin.myresult,
                                "OK",
                                    () {
                                 Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/',
                                        (route) => false,
                                  );

                                },
                              );
                            }
                  } else {
                    print("submitting login error 200");
                    // If the server did not return a 201 CREATED response,
                    // then throw an exception.
                   // throw Exception('Failed to create album.');
                    FormHelper.showSimpleAlertDialog(
                      context,
                      Config.appName,
                      "Server Error",
                      "OK",
                          () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/',
                                  (route) => false,
                            );
                          },
                    );
                  }// response 200
                }// main if not null string chk

              },
              btnColor: HexColor("283B71"),
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 10,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              "OR",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 25,
              ),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.white, fontSize: 14.0),
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Dont have an account? ',
                    ),
                    TextSpan(
                      text: 'Sign up',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(
                            context,
                            '/register',
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
