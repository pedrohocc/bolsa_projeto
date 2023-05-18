import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Future<void> save(String token) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
    } catch (e) {
      throw Exception('erro ao salvar');
    }
  }

  Future<void> delete() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
    } catch (e) {
      throw Exception('erro ao sair');
    }
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.get('token').toString();
    return token;
  }
}
