import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Bora montar a sua rotina?"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(hintText: "Digite seu nome:"),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(hintText: "Digite seu email:"),
              ),
              TextField(
                controller: _senhaController,
                decoration: InputDecoration(hintText: "Digite sua senha:"),
              ),
              // Adicionar aqui os demais componentes do formulário, como radio buttons,
              // toggle button, slide etc.
              ElevatedButton(
                child: Text("Cadastrar"),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar( //dúvida sobre isso
                    SnackBar(
                      content: Text("Processando o cadastro..."),
                      duration: Duration(seconds: 5),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class Rotina {
  final String nome;
  final String email;
  final String senha;

  Rotina(this.nome, this.email, this.senha);

}