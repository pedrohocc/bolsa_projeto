import 'package:bolsa_projeto/data/datails_game_dao.dart';
import 'package:bolsa_projeto/helpers/show_dialog_custom.dart';
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
              icon: Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder(
        future: DetailsGameDao().getByIndex(widget.valores['id']),
        builder: (context, snapshot) {
          Map? mapDetailsGame = snapshot.data;
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && mapDetailsGame != null) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
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
                                image: mapDetailsGame['capa'] ?? '',
                                onError: Icon(Icons.no_photography_outlined),
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
                                padding: const EdgeInsets.only(bottom: 10),
                                child: SizedBox(
                                  width: 180,
                                  height: 50,
                                  child: FittedBox(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${mapDetailsGame['nome']}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 28),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.calendar_month),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "${mapDetailsGame['ano']}",
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.people_sharp),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                        "${mapDetailsGame['minimo_jogadores']} a ${mapDetailsGame['maximo_jogadores']} jogadores"),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.hourglass_bottom,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child:
                                        Text("${mapDetailsGame['duracao']}min"),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            'Descrição do jogo:',
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              width: 300,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 1)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('${mapDetailsGame['descricao']}'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            'Mecanicas:',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, top: 10),
                          child: SizedBox(
                            width: 300,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, width: 1)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: mapDetailsGame['mecanicas'],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.info),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: mapDetailsGame['expansao'] == true
                                    ? Text('Esse jogo é uma expansão')
                                    : Text('Esse jogo NÃO é uma expansão'),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]),
              );
            } else {
              return Center(
                child: Text('Sem dados'),
              );
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
    );
  }
}
