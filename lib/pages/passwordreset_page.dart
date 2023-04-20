import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobileui/config.dart';
import 'package:mobileui/models/passwordreset.dart';
import 'package:mobileui/models/userlogin.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:flutter/src/widgets/icon.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({Key? key}) : super(key: key);

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {

  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  String? username;
  String? newpassword;
  String? confirmpassword;
  String? email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: HexColor("#283B71"),
            body: ProgressHUD(
              child: Form(
                key: globalFormKey,
                child: _loginUI(context),
              ),
              inAsyncCall: isAPIcallProcess,
              key: UniqueKey(),
            )

        )
    );
  }
  String rsmyemail='';
  String rsmypass='';
  String rsmycpass='';

  Widget _loginUI(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/5.2,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end:  Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white,
                    ]),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/HHlogo.png",
                      //width: 150,
                      height: MediaQuery.of(context).size.height / 5.8,
                      fit: BoxFit.contain,
                    )
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              bottom: 30,
              top: 50,
            ),

            child: Text("Password Reset",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              //Icon(Icons.person_outline),
              //const Icon(Icons.person_outline),
              //prefixIcon: ,
              "email",
              "E-Mail",

                  (onValidateVal){
                if(onValidateVal.isEmpty) {
                  return "E-Mail can\'t be empty";
                }
                return null;
              },
                  (onSavedVal){
                    email = onSavedVal;
                rsmyemail=email!.trim();
              },
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: true,
              prefixIcon: Icon(Icons.mail_outline),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              //Icon(Icons.person_outline),
              //const Icon(Icons.person_outline),
              "newpassword",
              "New Password",

                  (onValidateVal){
                if(onValidateVal.isEmpty) {
                  return "Password can\'t be empty";
                }
                return null;
              },
                  (onSavedVal){
                newpassword = onSavedVal;
                rsmypass=newpassword!.trim();

              },
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
              obscureText: hidePassword,
              suffixIcon: IconButton(
                onPressed: (){
                  setState(() {
                    hidePassword = !hidePassword;
                  });

                },
                color: Colors.white.withOpacity(0.7),
                icon: Icon(
                  hidePassword ? Icons.visibility_off : Icons.visibility,

                ),
              ),
              showPrefixIcon: true,
              prefixIcon: Icon(Icons.lock_outline),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              //Icon(Icons.person_outline),
              //const Icon(Icons.person_outline),
              "confirmpassword",
              "Confirm Password",

                  (onValidateVal){
                if(onValidateVal.isEmpty) {
                  return "Password can\'t be empty";
                }
                return null;
              },
                  (onSavedVal){
                confirmpassword = onSavedVal;
                rsmycpass=confirmpassword!.trim();
              },
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
              obscureText: hidePassword,
              suffixIcon: IconButton(
                onPressed: (){
                  setState(() {
                    hidePassword = !hidePassword;
                  });

                },
                color: Colors.white.withOpacity(0.7),
                icon: Icon(
                  hidePassword ? Icons.visibility_off : Icons.visibility,

                ),
              ),
              showPrefixIcon: true,
              prefixIcon: Icon(Icons.lock_outline),
            ),
          ),

          SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton("Reset",
                  () async {
                    validateAndSave();
                    print("rss mypass mycpass myemail "+rsmycpass+"dsd" +rsmypass +"sara "+rsmyemail+"chk");

              if (rsmyemail.trim() != "" && rsmypass.trim() != "" && rsmycpass.trim() != "") {

                if (rsmypass.trim() != rsmycpass.trim()){
                  FormHelper.showSimpleAlertDialog(
                    context,
                    Config.appName,
                    "Password Mismatch",
                    "OK",
                        () {
                      Navigator.pop(context);
                      //Navigator.pushNamed(context, "/reset");
                    },
                  );
                }else {



                print("submitting login");
               final UserLogin userlogin;
                final response = await http.post(
                  //Uri.parse('http://192.168.1.6:7000/apidb/myreset'),
                  Uri.parse(Config.apiURL+Config.apimyreset),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{
                    "email":rsmyemail,
                    "password":rsmypass,
                    "cpassword":rsmycpass
                  }),
                );

                if (response.statusCode == 200) {
                  // If the server did return a 201 CREATED response,
                  // then parse the JSON.
                  print("submitting login response 200" + response.body);
                  PasswordResetApi passwordresetapi = PasswordResetApi.fromJson(jsonDecode(response.body));
                  print("submitting login response 200" + passwordresetapi.myresult);
                  if (passwordresetapi.myresult.contains('success') ) {
                    FormHelper.showSimpleAlertDialog(
                      context,
                      Config.appName,
                      passwordresetapi.myresult,
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
                      passwordresetapi.myresult,
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
                          Navigator.pop(context);

                        },
                  );
                }

                }// if password mismatch
              }// if chk ""


                  },
              btnColor: HexColor("#283B71"),
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 10,

            ),
          ),
          SizedBox(
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
                        text: 'Don\'t have an Account? ',),
                      TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,

                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            print("SignUp Pressed");
                            Navigator.pushNamed(context, "/register");
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
