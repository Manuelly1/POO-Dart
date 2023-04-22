import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  
  @override
  
  State<StatefulWidget> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  int? _selectedValue = 0; 

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
              CustomTextField(
                controller: _nomeController,
                hintText: "Digite seu nome:",
              ),
              CustomTextField(
                controller: _emailController,
                hintText: "Digite seu email:",
              ),
              CustomTextField(
                controller: _senhaController,
                hintText: "Digite sua senha:",
              ),
              CustomRadioButtons(
                value: 1,
                groupValue: _selectedValue,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                },
                title: "Organizar dias úteis da semana",
              ),
              CustomRadioButtons(
                value: 2,
                groupValue: _selectedValue,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                },
                title: "Organizar o fim de semana",
              ),
              CustomElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Processando o cadastro..."),
                      duration: Duration(seconds: 5),
                      backgroundColor: Colors.red,
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => 
                        Rotina(_nomeController.text, _emailController.text, _senhaController.text, _selectedValue!,

                      ),
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


class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  CustomTextField({required this.controller, required this.hintText});

  @override

  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),

    );
  }
}


class CustomRadioButtons extends StatelessWidget {
  final int value;
  final int? groupValue;
  final Function(int?)? onChanged;
  final String title;

  CustomRadioButtons({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
  });

  @override
  
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Radio(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
  
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;

  CustomElevatedButton({required this.onPressed});

  @override
  
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text("Acessar"),
  
    );
  }
}

class Rotina extends StatelessWidget {
  final String nome;
  final String email;
  final String senha;
  final int selectedValue;

  Rotina(this.nome, this.email, this.senha, this.selectedValue);

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tentando ter uma rotina de gente grande"),
      ),
      body: ListView(
        children: List.generate(
          selectedValue,
          (index) => ListTile(
            title: Text("Atividade ${index + 1}"),
  
          ),
        ),
      ),
    );
  }
}