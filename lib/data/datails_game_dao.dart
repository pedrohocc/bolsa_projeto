import 'dart:convert';
import 'package:bolsa_projeto/data/preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailsGameDao {
  Future<Map> getByIndex(int id) async {
    String token = await Preferences().getToken();
    Map detailsGame;

    var url = Uri.parse('http://206.189.206.44:8080/api/jogo/$id');
    var header = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var response = await http.get(
      url,
      headers: header,
    );
    var bodyJson = jsonDecode(response.body);
    final List mecanicaList = bodyJson['caracteristicas'];
    List<Widget> mecanicas = [];
    int indexElement = 1;

    for (var element in mecanicaList) {
      if (element['tipo'] == 'MECANICA') {
        mecanicas.add(
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Mecanica $indexElement:\n${element['descricao']}'),
          ),
        );
        indexElement++;
      } else {
        continue;
      }
    }

    detailsGame = {
      'capa': bodyJson['urlCapa'],
      'nome': bodyJson['nome'],
      'descricao': bodyJson['descricao'],
      'minimo_jogadores': bodyJson['minimoJogadores'],
      'maximo_jogadores': bodyJson['maximoJogadores'],
      'duracao': bodyJson['duracaoMedia'],
      'ano': bodyJson['ano'],
      'mecanicas': mecanicas,
      'expansao': bodyJson['expansao'],
    };

    return detailsGame;
  }
}
