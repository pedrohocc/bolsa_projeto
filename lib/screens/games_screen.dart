import 'package:bolsa_projeto/components/card_game.dart';
import 'package:bolsa_projeto/data/jogos_dao.dart';
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
  ScrollController _scrollController = ScrollController();
  bool refresh = false;

  @override
  Widget build(BuildContext context) {
    print('pagina $_pagina');
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de jogos"),
        centerTitle: true,
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
              WidgetsBinding.instance?.addPostFrameCallback((_) {
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
                      if (index + 1 == cards.length) {
                        return Column(
                          children: [
                            ZoomTapAnimation(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("index do item: $index"),
                                    ),
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
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("index do item: $index"),
                                      ),
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
                  return Text('empty');
                }
              } else {
                return Text('null or notHasData');
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
              ));
            }
          },
        ),
      ),
    );
  }
}
