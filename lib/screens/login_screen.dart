import 'package:bolsa_projeto/data/logar.dart';
import 'package:flutter/material.dart';
import 'package:bolsa_projeto/helpers/is_null_or_empty.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GamesApp"),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "images/fundo_login.jpg",
              ),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 30),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: 250,
                          height: 60,
                          child: TextFormField(
                            validator: (value) {
                              if (isNullOrEmpty(value)) {
                                return 'Insira um valor';
                              } else {
                                return null;
                              }
                            },
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              label: Text("Email"),
                              hintText: "Insira seu email",
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: 250,
                          height: 60,
                          child: TextFormField(
                            validator: (value) {
                              if (isNullOrEmpty(value)) {
                                return 'Insira um valor';
                              } else {
                                return null;
                              }
                            },
                            controller: _senha,
                            keyboardType: TextInputType.text,
                            obscureText: _isObscure,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    _mudarObscure();
                                  },
                                  icon: const Icon(Icons.remove_red_eye)),
                              label: const Text("Senha"),
                              hintText: "Insira sua senha",
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      postLogin(_email.text, _senha.text).then((value) {
                        if (value == 'Logado com sucesso') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 1),
                                  content: Text("Logado com sucesso"),
                                ),
                              )
                              .closed
                              .then((value) => {
                                    Navigator.pushReplacementNamed(
                                        context, '/games')
                                  });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(value),
                            ),
                          );
                        }
                      });
                    }
                  },
                  child: const Text(
                    "ENTRAR",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _mudarObscure() {
    setState(() {
      _isObscure == true ? _isObscure = false : _isObscure = true;
    });
  }
}
