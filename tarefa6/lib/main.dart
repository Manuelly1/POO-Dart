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
  int? _selectedValue = 0;
  bool _toggleValue = false;

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Bora montar a sua rotina?"),
        ),
        body: SingleChildScrollView(
          child: Padding(
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
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selecione por onde deseja começar:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 16),
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
                  ],
                ),
                SizedBox(height: 16),
                CustomToggleButton(
                  value: _toggleValue,
                  onChanged: (bool value) {
                    setState(() {
                      _toggleValue = value;
                    });
                  },
                  trueText: 'Ainda vou ficar off',
                  falseText: 'A rotina está on',
                ),
                SizedBox(height: 16),
                CustomElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Processando o cadastro..."),
                        duration: Duration(seconds: 10),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _selectedValue,
                  itemBuilder: (context, index) => ListTile(
                    title: Text("Atividade ${index + 1}"),
                  ),
                ),
              ],
            ),
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
    return SingleChildScrollView(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: hintText),
      ),
    );
  }
}

class CustomRadioButtons extends StatelessWidget {
  final int value;
  final int? groupValue;
  final Function(int?)? onChanged;
  final String title;

  CustomRadioButtons({required this.value, required this.groupValue, required this.onChanged, required this.title});

  @override
  
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListTile(
        title: Text(title),
        leading: Radio(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
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

class CustomToggleButton extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String trueText;
  final String falseText;

  CustomToggleButton({required this.value, required this.onChanged, required this.trueText, required this.falseText});

  @override

  _CustomToggleButtonState createState() => _CustomToggleButtonState();

}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  late bool _value;

  @override
  
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.falseText),
        Switch(
          value: _value,
          onChanged: (bool value) {
            setState(() {
              _value = value;
            });
            widget.onChanged(value);
          },
        ),
        Text(widget.trueText),
      ],
    );
  }
}


class Rotina extends StatelessWidget {
  final String nome;
  final String email;
  final int selectedValue;
  final bool toggleValue;

  Rotina(this.nome, this.email, this.selectedValue, this.toggleValue);

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tentando ter uma rotina de gente grande"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: selectedValue,
              itemBuilder: (context, index) => ListTile(
                title: Text("Atividade ${index + 1}"),
              ),
            ),
            CustomToggleButton(
              value: toggleValue,
              onChanged: (value) {},
              trueText: "Completo",
              falseText: "Incompleto",
            ),
            CustomElevatedButton(
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}