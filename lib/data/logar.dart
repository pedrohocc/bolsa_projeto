import 'dart:convert';
import 'package:bolsa_projeto/data/preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> logar(String email, String senha) async {
  var url = Uri.parse('http://206.189.206.44:8080/loin');
  var header = {'Content-Type': 'application/json'};
  var body = jsonEncode({'email': email, 'senha': senha});
  var response = await http.post(url, headers: header, body: body);

  if (response.statusCode >= 500) {
    return 'Erro no servidor.';
  } else if (response.statusCode >= 400 && response.statusCode < 500) {
    return 'Login invalido!';
  } else if (response.statusCode == 200) {
    Preferences().save(response.body);
    return 'Logado com sucesso';
  } else {
    return 'Erro desconhecido';
  }
}
