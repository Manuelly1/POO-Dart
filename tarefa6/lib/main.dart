import 'package:flutter/material.dart';

// faltam: radio buttons, toggle button, slide etc. Não se preocupe em o formulário
// "fazer sentido", apenas em montá-lo e seja criativo (não quero formulários só com campos de texto)
// Ponha ao menos um botáo nesse formulário. Quando o botão for acionado, o app deve exibir apenas
// um snack bar com uma mensagem indicando que o formulário está sendo processado


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
                decoration: InputDecoration(hintText: 'Digite seu nome:'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(hintText: 'Digite seu email:'),
              ),
              TextField(
                controller: _senhaController,
                decoration: InputDecoration(hintText: 'Digite sua senha:'),
              ),
              // Adicione aqui os demais componentes do formulário, como radio buttons,
              // toggle button, slide etc.
              ElevatedButton(
                child: Text("Cadastrar"),
                onPressed: () {
                  // Exibe o snackbar indicando que o formulário está sendo processado
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Processando cadastro...'),
                      duration: Duration(seconds: 5),
                    ),
                  );

                  // Lógica para lidar com o pressionamento do botão aqui.
                  String nome = _nomeController.text;
                  String email = _emailController.text;
                  String senha = _senhaController.text;
                  Rotina rotina = Rotina(nome, email, senha);
                },
              )
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