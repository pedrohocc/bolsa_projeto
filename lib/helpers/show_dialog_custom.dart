import 'package:bolsa_projeto/data/preferences.dart';
import 'package:flutter/material.dart';

void exibirDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Confirmação'),
        content: Text('Deseja mesmo sair?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("NÂO"),
          ),
          TextButton(
            onPressed: () {
              Preferences().delete().then((value) {
                Navigator.of(context).pushReplacementNamed('/');
              });
            },
            child: Text("SIM"),
          )
        ],
      );
    },
  );
}
