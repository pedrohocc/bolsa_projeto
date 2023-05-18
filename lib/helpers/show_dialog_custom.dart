import 'package:bolsa_projeto/data/preferences.dart';
import 'package:flutter/material.dart';

void exibirDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirmação'),
        content: const Text('Deseja mesmo sair?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("NÂO"),
          ),
          TextButton(
            onPressed: () {
              Preferences().delete().then((value) {
                Navigator.of(context).pushReplacementNamed('/');
              }).catchError((e) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: e),
                );
              });
            },
            child: const Text("SIM"),
          )
        ],
      );
    },
  );
}
