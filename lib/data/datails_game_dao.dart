import 'dart:convert';
import 'package:bolsa_projeto/data/preferences.dart';
import 'package:bolsa_projeto/models/details_game.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class DetailsGameDao {
  Future<DetailsGame> getByIndex(int id) async {
    final String token = await Preferences().getToken();
    Map detailsGameMap;
    var url = Uri.parse('http://206.189.206.44:8080/api/jogo/$id');
    var header = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    try {
      var response = await http.get(
        url,
        headers: header,
      );
      var bodyJson = jsonDecode(response.body);
      final List mecanicaList = bodyJson['caracteristicas'];
      final List<Widget> mecanicas = getMecanicas(mecanicaList);
      final String expansao = bodyJson['expansao'] == true ? 'É' : 'Não é';
      detailsGameMap = {
        'capa': bodyJson['urlCapa'],
        'nome': bodyJson['nome'],
        'descricao': bodyJson['descricao'],
        'minimo_jogadores': bodyJson['minimoJogadores'],
        'maximo_jogadores': bodyJson['maximoJogadores'],
        'duracao': bodyJson['duracaoMedia'],
        'ano': bodyJson['ano'],
        'mecanicas': mecanicas,
        'expansao': expansao,
      };
      return toDetailsGame(detailsGameMap);
    } catch (e) {
      throw Exception('erro $e');
    }
  }

  List<Widget> getMecanicas(List mecanicaList) {
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
    return mecanicas;
  }

  DetailsGame toDetailsGame(Map map) {
    return DetailsGame.fromMap(map);
  }
}
