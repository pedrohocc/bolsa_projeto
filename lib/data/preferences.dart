import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Future<void> save(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.get('token').toString();
    return token;
  }
}
