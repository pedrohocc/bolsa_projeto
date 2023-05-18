import 'package:flutter/material.dart';

class DetailsGame {
  final String? capa;
  final String nome;
  final int ano;
  final int minimoJogadores;
  final int maximoJogadores;
  final int duracao;
  final String descricao;
  final List<Widget> mecanicas;
  final String isExpansao;

  DetailsGame(
    this.capa,
    this.nome,
    this.ano,
    this.duracao,
    this.descricao,
    this.mecanicas,
    this.isExpansao,
    this.minimoJogadores,
    this.maximoJogadores,
  );

  DetailsGame.fromMap(Map map)
      : capa = map['capa'],
        nome = map['nome'],
        descricao = map['descricao'],
        minimoJogadores = map['minimo_jogadores'],
        maximoJogadores = map['maximo_jogadores'],
        duracao = map['duracao'],
        ano = map['ano'],
        mecanicas = map['mecanicas'],
        isExpansao = map['expansao'];
}
