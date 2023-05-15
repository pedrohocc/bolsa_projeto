class Game {
  String _imagem;
  String _nome;
  String _ano;

  Game(this._imagem, this._nome, this._ano);

  Game.empty()
      : _imagem = '',
        _ano = '',
        _nome = '';

  Game.fromMap(Map map)
      : _imagem = map['imagem'],
        _nome = map['nome'],
        _ano = map['ano'];

  String getImagem() {
    return _imagem;
  }

  String getNome() {
    return _nome;
  }

  String getAno() {
    return _ano;
  }

  void setImagem(String url) {
    _imagem = url;
  }

  void setNome(String nome) {
    _nome = nome;
  }

  void setAno(String ano) {
    _ano = ano;
  }
}
