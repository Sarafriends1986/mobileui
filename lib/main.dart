import 'package:flutter/material.dart';
import 'package:mobileui/pages/passwordreset_page.dart';
import 'package:mobileui/services/shared_service.dart';
import 'package:mobileui/pages/login_page.dart';
import 'package:mobileui/pages/register_page.dart';

Widget _defaultHome = const Login();
//Widget _defaultHome =  HomePage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get result of the login function.
  bool _result = await SharedService.isLoggedIn();
  if (_result) {
    _defaultHome = const Login();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const LoginPage(),
      routes: {
        '/': (context) => _defaultHome,
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/reset': (context) => const PasswordReset(),
      },
    );
  }
}
