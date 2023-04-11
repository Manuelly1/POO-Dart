// interface gráfica
import 'package:flutter/material.dart';

class NewNavBar extends StatelessWidget {
  List<Icon> icons;
  NewNavBar({this.icons = const []});
  
  void botaoFoiTocado(int index) {
    print("Tocaram no botão $index");
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar (
      onTap: botaoFoiTocado,
      items: icons.map((obj) => BottomNavigationBarItem(icon: obj, label: "Label")
      ).toList());   
  }
}

class NewScaffold extends StatelessWidget {
  NewScaffold();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Expanded(
            child: Text("La Fin Du Monde - Bock - 65 ibu"),
          ),
          Expanded(
            child: Text("Sapporo Premiume - Sour Ale - 54 ibu"),
          ),
          Expanded(
            child: Text("Duvel - Pilsner - 82 ibu"),
          ),
        ],
      ),
    );
  }
}

class NewAppBar extends StatelessWidget {
  NewAppBar();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dicas de bebidas',
      color: Colors.blue,
    );
  }
}

class MyApp extends StatelessWidget {
  final List<Icon> icons = [
    Icon(Icons.home),
    Icon(Icons.search),
    Icon(Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dicas',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dicas'),
        ),
        body: NewScaffold(),
        bottomNavigationBar: NewNavBar(icons: icons),
      ),
    );
  }
}
