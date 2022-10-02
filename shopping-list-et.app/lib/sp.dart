import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getAccessToken() async{
  var sp = await SharedPreferences.getInstance();

  return sp.getString("token");
}

Future<bool> setAccessToken(String value) async{
  var sp = await SharedPreferences.getInstance();

  return sp.setString("token", value);
}