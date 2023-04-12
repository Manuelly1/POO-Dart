import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: NewAppBar(),              
        body: DataBodyWidget(
          objects: [
            "La Fin Du Monde - Bock - 65 ibu",
            "Sapporo Premiume - Sour Ale - 54 ibu",
            "Duvel - Pilsner - 82 ibu"
          ]
        ),
        bottomNavigationBar: NewNavBar(
          icons: [
            Icon(Icons.home),
            Icon(Icons.local_drink),
            Icon(Icons.settings)
          ],
        ),
      ),
    );
  }
}

class NewAppBar extends StatelessWidget implements PreferredSizeWidget{
  NewAppBar();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Dicas de bebidas"),
      backgroundColor: Colors.blue,
      actions: [
        PopupMenuButton<Color>(
          onSelected: (Color color) {
                  // como fará para lidar com a escolha da cor
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<Color>(
                child: Text('Pink'),
                value: Colors.pink,
              ),
              PopupMenuItem<Color>(
                  child: Text('Black'),
                  value: Colors.black,
              ),
              PopupMenuItem<Color>(
                child: Text('Green'),
                value: Colors.green,
              ),
            ];
          }
        )
      ]
    );
  }
}

class NewNavBar extends StatelessWidget {
  List<Icon> icons;

  NewNavBar({this.icons = const []});

  void botaoFoiTocado(int index) {
    print("Tocaram no botão $index");
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: botaoFoiTocado,
        items: icons.map(
              (obj) => BottomNavigationBarItem(icon: obj, label: "Label"))
            .toList());
  }
}

class DataBodyWidget extends StatelessWidget {
  List<String> objects;

  DataBodyWidget({this.objects = const []});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: objects.map(
          (obj) =>Expanded(
            child: Center(child: Text(obj)))
    ).toList());
  }
}
