import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

import '../models/game.dart';

class CardGame extends StatelessWidget {
  final Game game;
  const CardGame({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            width: 300,
            child: Container(
              color: Color.fromARGB(85, 255, 255, 255),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ImageNetwork(
                      image: game.getImagem(),
                      height: 100,
                      width: 100,
                      fitWeb: BoxFitWeb.fill,
                      fitAndroidIos: BoxFit.fill),
                  SizedBox(
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          game.getNome(),
                          textAlign: TextAlign.center,
                        ),
                        Text(game.getAno()),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
