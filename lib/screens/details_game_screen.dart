import 'package:bolsa_projeto/data/datails_game_dao.dart';
import 'package:bolsa_projeto/helpers/show_dialog_custom.dart';
import 'package:bolsa_projeto/models/details_game.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

class DetailsGameScreen extends StatefulWidget {
  final Map valores;
  const DetailsGameScreen({super.key, required this.valores});

  @override
  State<DetailsGameScreen> createState() => _DetailsGameScreenState();
}

class _DetailsGameScreenState extends State<DetailsGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.valores['nome']),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                exibirDialog(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder(
        future: DetailsGameDao().getByIndex(widget.valores['id']),
        builder: (context, snapshot) {
          DetailsGame? details = snapshot.data;
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasError) {
              if (snapshot.hasData && details != null) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: SizedBox(
                      width: 400,
                      child: ListView(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: SizedBox(
                            height: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: ImageNetwork(
                                      image: details.capa ?? '',
                                      onError: const Icon(
                                          Icons.no_photography_outlined),
                                      height: 200,
                                      width: 100,
                                      fitAndroidIos: BoxFit.fill,
                                      fitWeb: BoxFitWeb.fill),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: SizedBox(
                                        width: 180,
                                        height: 50,
                                        child: FittedBox(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            details.nome,
                                            textAlign: TextAlign.left,
                                            style:
                                                const TextStyle(fontSize: 28),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_month),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            "${details.ano}",
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.people_sharp),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                              "${details.minimoJogadores} a ${details.maximoJogadores} jogadores"),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.hourglass_bottom,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text("${details.duracao}min"),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 30, bottom: 10),
                                child: Text(
                                  'Descrição do jogo:',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: SizedBox(
                                  width: 300,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 1)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(details.descricao),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 30, top: 30),
                                child: Text(
                                  'Mecanicas:',
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, top: 10),
                                child: SizedBox(
                                  width: 300,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 1)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: details.mecanicas,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.info,
                                      color: Colors.blue,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Esse jogo ',
                                          children: [
                                            TextSpan(
                                              text: details.isExpansao,
                                              style: const TextStyle(
                                                  color: Colors.blue),
                                            ),
                                            const TextSpan(
                                                text: ' uma expansão')
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Text('Sem dados'),
                );
              }
            } else {
              return const Center(
                child: Text('Erro ao comunicar com o servidor!'),
              );
            }
          } else {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text('Carregando...'),
                  ),
                  CircularProgressIndicator(color: Colors.deepPurple),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
