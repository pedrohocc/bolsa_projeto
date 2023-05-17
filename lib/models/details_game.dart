class DetailsGame {
  final String capa;
  final String nome;
  final String ano;
  final String minimo_jogadores;
  final String maximo_jogadores;
  final String duracao;
  final String descricao;
  final Map<String, String> mecanicas;
  final bool isExpansao;

  DetailsGame(
      this.capa,
      this.nome,
      this.ano,
      this.minimo_jogadores,
      this.maximo_jogadores,
      this.duracao,
      this.descricao,
      this.mecanicas,
      this.isExpansao);
}
