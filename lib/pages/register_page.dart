import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobileui/models/userregister.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:mobileui/config.dart';
import 'package:http/http.dart' as http;


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}
enum SingingCharacter { lafayette, jefferson }
class _RegisterState extends State<Register> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? userName;
  String? email;
  String? password;
  String? cpassword;


  @override
  void initState() {
    super.initState();
  }
  SingingCharacter? _character = SingingCharacter.lafayette;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#283B71"),
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _registerUI(context),
          ),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }
  String rmyuser='';
  String rmyemail='';
  String rmypass='';
  String rmycpass='';
  String _selectedGender = 'male';
  String rmygender = 'male';

  Widget _registerUI(BuildContext context) {
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
                bottomRight: Radius.circular(100),
                bottomLeft: Radius.circular(100),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
            padding: EdgeInsets.only(left: 20, bottom: 20, top: 20),
            child: Text(
              "Register",
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

              "Username",
              "Username",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Username can\'t be empty.';
                }

                return null;
              },
                  (onSavedVal) => {
                userName = onSavedVal,
                rmyuser = userName!.trim()
              },
              initialValue: "",
              obscureText: false,
              borderFocusColor: Colors.white,
              showPrefixIcon: true,
              prefixIcon: Icon(Icons.person_outline),
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
            ),
          ),

          Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListTile(
                  leading: Radio<String>(
                    value: 'male',
                    activeColor: Colors.white,
                    focusColor: Colors.white,
                    hoverColor: Colors.white,
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                  ),
                  title: const Text('Male',
                    style: TextStyle(
                    color: Colors.white,)
                      )
                ),
              ),
            Expanded(
                child: ListTile(
                leading: Radio<String>(
                  activeColor: Colors.white,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  value: 'female',
                  groupValue: _selectedGender,

                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                      rmygender = _selectedGender;
                    });
                  },
                ),
                title: const Text('Female',
                    style: TextStyle(
                      color: Colors.white,)
                )
              ),
            ),
             // Text(_selectedGender == 'male' ? 'Hello gentlement!' : 'Hi lady!')

            ],
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
                rmyemail=email!.trim()
              },
              initialValue: "",
              borderFocusColor: Colors.white,
              showPrefixIcon: true,
              prefixIcon: Icon(Icons.mail_outline),
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
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
                rmypass=password!.trim()
              },
              initialValue: "",
              obscureText: hidePassword,
              borderFocusColor: Colors.white,
              showPrefixIcon: true,
              prefixIcon: Icon(Icons.lock_outline),
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
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
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FormHelper.inputFieldWidget(
              context,

              "Confirm Password",
              "Confirm Password",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Password can\'t be empty.';
                }

                return null;
              },
                  (onSavedVal) => {
                cpassword = onSavedVal,
                rmycpass=cpassword!.trim()
              },
              initialValue: "",
              obscureText: hidePassword,
              borderFocusColor: Colors.white,
              showPrefixIcon: true,
              prefixIcon: Icon(Icons.lock_outline),
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
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

          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Register",
                  ()  async {

                    validateAndSave();

                    print("myuser mypass mycpass myemail "+rmyuser+"dsd" +rmypass +"sara "+rmyemail+"chk" + rmycpass);
              if (rmyuser.trim() != "" && rmypass.trim() != "" && rmyemail.trim() != ""&& rmycpass.trim() != "") {

                if (rmycpass.trim() != rmypass.trim()){
                  FormHelper.showSimpleAlertDialog(
                    context,
                    Config.appName,
                    "Password Mismatch",
                    "OK",
                        () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, "/register");
                        },
                  );
                }//end if
                print("submitting login");
                final response = await http.post(
                  //Uri.parse('http://192.168.1.6:7000/apidb/mysignup'),
                  Uri.parse(Config.apiURL+Config.apimysignup),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{
                    "name":rmyuser,
                    "gender":rmygender,
                    "email": rmyemail,
                    "password":rmypass,
                    "confirmpassword":rmycpass
                  }),
                );

                if (response.statusCode == 200) {
                  // If the server did return a 201 CREATED response,
                  // then parse the JSON.
                  print("submitting login response 200" + response.body);
                  UserRegister userregister = UserRegister.fromJson(jsonDecode(response.body));
                  print("submitting login response 200" + userregister.myresult);

                  if (userregister.myresult.contains('success') ) {
                    FormHelper.showSimpleAlertDialog(
                      context,
                      Config.appName,
                      userregister.myresult,
                      "OK",
                          () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/',
                                  (route) => false,
                            );

                      },
                    );
                  } else {
                    FormHelper.showSimpleAlertDialog(
                      context,
                      Config.appName,
                      userregister.myresult,
                      "OK",
                          () {
                        Navigator.pop(context);

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





              }// if "" chk

              },//button fn
              btnColor: HexColor("283B71"),
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 10,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "OR",
              style:TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 25),
              child: RichText(
                text: TextSpan(
                    style: const TextStyle(
                        color: Colors.white, fontSize: 14.0
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Already have an Account? ',),
                      TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,

                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            print("Login Pressed");
                            Navigator.pushNamed(context, "/login");
                          }
                      )
                    ]
                ),
              ),
            ),
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