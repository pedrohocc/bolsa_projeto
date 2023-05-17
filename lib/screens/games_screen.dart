import 'package:bolsa_projeto/components/card_game.dart';
import 'package:bolsa_projeto/data/games_dao.dart';
import 'package:bolsa_projeto/data/preferences.dart';
import 'package:bolsa_projeto/helpers/show_dialog_custom.dart';
import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  int _pagina = 1;
  List<CardGame> gameList = [];
  final ScrollController _scrollController = ScrollController();
  bool refresh = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jogos"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                exibirDialog(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/fundo_games.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder(
          future: JogosDao().getGames(_pagina, gameList),
          builder: (context, snapshot) {
            if (refresh) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_scrollController.hasClients) {
                  _scrollController.jumpTo(
                    _scrollController.position.maxScrollExtent,
                  );
                }
              });
            }
            List<CardGame>? cards = snapshot.data;
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && cards != null) {
                if (cards.isNotEmpty) {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      final CardGame card = cards[index];
                      Map parametros = {
                        'id': card.game.getID(),
                        'nome': card.game.getNome()
                      };
                      if (index + 1 == cards.length) {
                        return Column(
                          children: [
                            ZoomTapAnimation(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/details',
                                    arguments: (parametros),
                                  );
                                },
                                child: card),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: SizedBox(
                                width: 120,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _pagina++;
                                      refresh = true;
                                    });
                                  },
                                  child: Text(
                                    'Carregar mais',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        return SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ZoomTapAnimation(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/details',
                                      arguments: (parametros),
                                    );
                                  },
                                  child: card),
                            ],
                          ),
                        );
                      }
                    },
                  );
                } else {
                  return Center(child: Text('Sem jogos!'));
                }
              } else {
                return Center(
                    child: Text('Não foi possivel carregar os jogos!'));
              }
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('Carregando...'),
                    ),
                    CircularProgressIndicator(color: Colors.deepPurple),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
