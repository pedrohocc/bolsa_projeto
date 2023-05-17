class Game {
  final String? _imagem;
  final String _nome;
  final String _ano;
  final int _id;

  Game(this._imagem, this._nome, this._ano, this._id);

  Game.empty()
      : _imagem = '',
        _ano = '',
        _nome = '',
        _id = 0;

  Game.fromMap(Map map)
      : _imagem = map['imagem'],
        _nome = map['nome'],
        _ano = map['ano'],
        _id = map['id'];

  String? getImagem() {
    return _imagem;
  }

  String getNome() {
    return _nome;
  }

  String getAno() {
    return _ano;
  }

  int getID() {
    return _id;
  }
}
