import 'package:mobileui/models/appusers.dart';

import '../models/userregister.dart';
import 'package:http/http.dart' as http;

class LoginServices {

  Future<List<Appusers>?> getAppUsers() async{

    print(" remote api call init");
    var client = http.Client();
    var uri = Uri.parse('http://192.168.1.6:7000/apidb/dbuser');
    var response = await client.get(uri);
    if (response.statusCode == 200){
      var json = response.body;
      print("remote api call "+ json);
      return appusersFromJson(json);
    }
  }
}