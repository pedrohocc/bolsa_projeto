import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

import '../models/game.dart';

class CardGame extends StatelessWidget {
  final Game game;
  const CardGame({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: 300,
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(119, 155, 48, 255),
                borderRadius: BorderRadius.circular(10)),
            child: SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ImageNetwork(
                    image: game.getImagem() ?? '',
                    onError: const Icon(Icons.no_photography_outlined),
                    height: 100,
                    width: 100,
                    fitWeb: BoxFitWeb.fill,
                    fitAndroidIos: BoxFit.fill,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                  ),
                  SizedBox(
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Jogo: ${game.getNome()}',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Ano: ${game.getAno()}',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Text(
                          'Clique para ver mais',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10,
                              color: Color.fromARGB(107, 255, 255, 255)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
