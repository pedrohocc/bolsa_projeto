import 'package:bolsa_projeto/data/preferences.dart';
import 'package:flutter/material.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/fundo_games.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder(
          future: Preferences().getToken(),
          builder: (context, snapshot) {
            String? token = snapshot.data;
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && token != null) {
                if (token.isNotEmpty) {
                  return Center(
                    child: SizedBox(
                      width: 200,
                      child: Text('token de usuario = $token'),
                    ),
                  );
                } else {
                  return Placeholder();
                }
              } else {
                return Placeholder();
              }
            } else {
              return Placeholder();
            }
          },
        ),
      ),
    );
  }
}
