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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            controller: _emailController,
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
                            controller: _senhaController,
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
              SizedBox(
                width: 120,
                height: 40,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        logar(_emailController.text, _senhaController.text)
                            .then((value) {
                          if (value == 'Logado com sucesso') {
                            FocusScope.of(context).requestFocus(FocusNode());
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                                  const SnackBar(
                                    duration: Duration(milliseconds: 500),
                                    content: Text("Logado com sucesso"),
                                  ),
                                )
                                .closed
                                .then((value) => {
                                      Navigator.of(context)
                                          .pushReplacementNamed('/games')
                                    });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(value),
                              ),
                            );
                          }
                        }).catchError((e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e),
                            ),
                          );
                        });
                      }
                    },
                    child: const Text(
                      "ENTRAR",
                      style: TextStyle(color: Colors.white),
                    )),
              )
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
