import 'dart:convert';
import 'package:bolsa_projeto/data/preferences.dart';
import 'package:bolsa_projeto/models/game.dart';
import 'package:http/http.dart' as http;

import '../components/card_game.dart';

class JogosDao {
  Future<List<CardGame>> getGames(int pagina, List<CardGame> lista) async {
    String token = await Preferences().getToken();

    var url = Uri.parse("http://206.189.206.44:8080/api/jogo?page=$pagina");
    var header = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var response = await http.get(
      url,
      headers: header,
    );
    if (response.body.isNotEmpty) {
      var bodyJson = jsonDecode(response.body);
      print(bodyJson);
      lista.addAll(_convertToGame(bodyJson));
      return lista;
    } else {
      return lista;
    }
  }

  List<CardGame> _convertToGame(dynamic json) {
    final List<Game> games = [];
    final List items = json['content'];
    for (var item in items) {
      Map mapJson = {
        'imagem': item['urlCapa'],
        'nome': item['nome'],
        'ano': item['ano'].toString()
      };
      games.add(Game.fromMap(mapJson));
    }
    return _convertToCardGame(games);
  }

  List<CardGame> _convertToCardGame(List<Game> games) {
    final List<CardGame> cards = [];
    for (Game game in games) {
      CardGame newCardGame = CardGame(game: game);
      cards.add(newCardGame);
    }
    return cards;
  }
}
